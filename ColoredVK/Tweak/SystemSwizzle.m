//
//  SystemSwizzle.m
//  ColoredVK
//
//  Created by Даниил on 23.03.18.
//

#import "Tweak.h"
#import <dlfcn.h>
#import "ColoredVKSwitch.h"

@interface PSListController : UIViewController
@end
@interface SelectAccountTableViewController : UITableViewController
@end

CVK_CONSTRUCTOR
{
    @autoreleasepool {
        dlopen("/System/Library/PrivateFrameworks/Preferences.framework/Preferences", RTLD_LAZY);
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UIWindowDidBecomeVisibleNotification object:nil 
                                                           queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
                                                               actionChangeCornerRadius(nil);
                                                           }];
    }
}


#pragma mark - AppDelegate
CHDeclareClass(AppDelegate);
CHDeclareMethod(2, BOOL, AppDelegate, application, UIApplication*, application, didFinishLaunchingWithOptions, NSDictionary *, options)
{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    ColoredVKNewInstaller *newInstaller = [ColoredVKNewInstaller sharedInstaller];
    installerCompletionBlock = ^(BOOL purchased) {
        premiumEnabled = YES;
        reloadPrefs(nil);
    };
    [newInstaller checkStatus];
    
    return CHSuper(2, AppDelegate, application, application, didFinishLaunchingWithOptions, options);;
}

CHDeclareMethod(1, void, AppDelegate, applicationDidBecomeActive, UIApplication *, application)
{
    CHSuper(1, AppDelegate, applicationDidBecomeActive, application);
    
    actionChangeCornerRadius(nil);
    
    if (cvkMainController.audioCover) {
        [cvkMainController.audioCover updateColorScheme];
    }
}



#pragma mark UINavigationBar
#define DEFAULT_NAVIGATION_BAR_SWIZZLE(nav_bar_class)\
CHDeclareClass(nav_bar_class)\
CHDeclareMethod(1, void, nav_bar_class, setBarTintColor, UIColor*, barTintColor) {\
    barTintColor = cvk_UINavigationBar_setBarTintColor(self, _cmd, barTintColor);\
    CHSuper(1, nav_bar_class, setBarTintColor, barTintColor);\
}CHDeclareMethod(1, void, nav_bar_class, setTintColor, UIColor*, tintColor){\
    tintColor = cvk_UINavigationBar_setTintColor(self, _cmd, tintColor);\
    CHSuper(1, nav_bar_class, setTintColor, tintColor);\
}CHDeclareMethod(1, void, nav_bar_class, setTitleTextAttributes, NSDictionary*, attributes){\
    attributes = cvk_UINavigationBar_setTitleTextAttributes(self, _cmd, attributes);\
    CHSuper(1, nav_bar_class, setTitleTextAttributes, attributes);\
}CHDeclareMethod(1, void, nav_bar_class, setFrame, CGRect, frame) {\
    CHSuper(1, nav_bar_class, setFrame, frame);\
    cvk_UINavigationBar_setFrame(self, _cmd, frame);\
}

@interface VANavigationBar : UINavigationBar @end

@interface VANavigationItem : UINavigationItem
@property(nonatomic) __weak VANavigationBar *navigationBar;
@end

DEFAULT_NAVIGATION_BAR_SWIZZLE(UINavigationBar)
//DEFAULT_NAVIGATION_BAR_SWIZZLE(VANavigationBar)

CHDeclareClass(VANavigationItem);
CHDeclareMethod(0, UIColor *, VANavigationItem, barTintColor)
{
    UIColor *origColor = CHSuper(0, VANavigationItem, barTintColor);
    return cvk_UINavigationBar_setBarTintColor(self.navigationBar, _cmd, origColor);
}

CHDeclareMethod(0, UIColor *, VANavigationItem, tintColor)
{
    UIColor *origColor = CHSuper(0, VANavigationItem, tintColor);
    return cvk_UINavigationBar_setTintColor(self.navigationBar, _cmd, origColor);
}

CHDeclareClass(UISearchBar);
CHDeclareMethod(0, void, UISearchBar, layoutSubviews)
{
    CHSuper(0, UISearchBar, layoutSubviews);
    
    if ([self.superview isKindOfClass:[UINavigationBar class]]) {
        if (enabled) {
            if (enableNightTheme)
                self.searchBarTextField.backgroundColor = cvkMainController.nightThemeScheme.backgroundColor;
            else if (enabledBarImage)
                self.searchBarTextField.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
            else if (enabledBarColor)
                self.searchBarTextField.backgroundColor = barBackgroundColor.cvk_darkerColor;
        } else {
            self.searchBarTextField.backgroundColor = [UIColor colorWithRed:0.078f green:0.227f blue:0.4f alpha:0.8f];
        }
    }
}


#pragma mark UITextInputTraits
CHDeclareClass(UITextInputTraits);
CHDeclareMethod(0, UIKeyboardAppearance, UITextInputTraits, keyboardAppearance) 
{
    if (enabled) {
        if (enableNightTheme)
            return UIKeyboardAppearanceDark;
        
        if (keyboardStyle != UIKeyboardAppearanceDefault)
            return keyboardStyle;
    }
    
    return CHSuper(0, UITextInputTraits, keyboardAppearance);
}


#pragma mark UISwitch
CHDeclareClass(UISwitch);
CHDeclareMethod(0, void, UISwitch, layoutSubviews)
{
    CHSuper(0, UISwitch, layoutSubviews);
    
    if ([self isKindOfClass:[UISwitch class]]) {
        Class cvkSwitchClass = objc_lookUpClass("ColoredVKSwitch");
        if (enabled && enableNightTheme) {
            self.tintColor = [UIColor clearColor];
            self.onTintColor = cvkMainController.nightThemeScheme.switchOnTintColor;
            self.thumbTintColor = cvkMainController.nightThemeScheme.switchThumbTintColor;
            self.backgroundColor = cvkMainController.nightThemeScheme.backgroundColor;
            self.layer.cornerRadius = 16.0f;
        } else if (enabled && changeSwitchColor) {
            self.tintColor = switchesTintColor;
            self.onTintColor = switchesOnTintColor;
            if (![self isKindOfClass:cvkSwitchClass]) {
                self.thumbTintColor = nil;
                self.backgroundColor = nil;
            }
        } else if (![self isKindOfClass:cvkSwitchClass])  {
            self.tintColor = nil;
            self.onTintColor = nil;
            self.thumbTintColor = nil;
            self.backgroundColor = nil;
        }
    }
}


#pragma mark UITableView
CHDeclareClass(UITableView);
CHDeclareMethod(6, UITableViewHeaderFooterView*, UITableView, _sectionHeaderView, BOOL, arg1, withFrame, CGRect, frame, forSection, NSInteger, section, floating, BOOL, floating, reuseViewIfPossible, BOOL, reuse, willDisplay, BOOL, display)
{
    UITableViewHeaderFooterView *view = CHSuper(6, UITableView, _sectionHeaderView, arg1, withFrame, frame, forSection, section, floating, floating, reuseViewIfPossible, reuse, willDisplay, display);
    
    if (enabled)
        setupHeaderFooterView(view, self);
    
    return view;
}

CHDeclareMethod(1, void, UITableView, setBackgroundView, UIView*, backgroundView)
{
    if (enabled && enableNightTheme) {
        if (!backgroundView)
            backgroundView = [UIView new];
        
        if (![self.delegate isKindOfClass:objc_lookUpClass("VKAPPlacesViewController")])
            backgroundView.backgroundColor = cvkMainController.nightThemeScheme.backgroundColor;
    }
    
    if ([self.backgroundView isKindOfClass:[ColoredVKWallpaperView class]] && [backgroundView isKindOfClass:objc_lookUpClass("TeaserView")]) {
        TeaserView *teaserView = (TeaserView *)backgroundView;
        teaserView.labelTitle.textColor = UITableViewCellTextColor;
        teaserView.labelText.textColor = UITableViewCellTextColor;
        [self.backgroundView addSubview:teaserView];
        
        teaserView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view":teaserView}]];
        [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":teaserView}]];
    } else {
        CHSuper(1, UITableView, setBackgroundView, backgroundView);
    }
}

CHDeclareMethod(2, void, UITableView, _configureCellForDisplay, UITableViewCell *, cell, forIndexPath, NSIndexPath *, indexPath)
{
    CHSuper(2, UITableView, _configureCellForDisplay, cell, forIndexPath, indexPath);
    
    if (enabled && enableNightTheme) {
        UIView *selectedView = [UIView new];
        selectedView.backgroundColor = cvkMainController.nightThemeScheme.backgroundColor;
        
        cell.selectedBackgroundView = selectedView;
    }
}

CHDeclareMethod(1, void, UITableView, willMoveToWindow, UIWindow *, window)
{
    CHSuper(1, UITableView, willMoveToWindow, window);
    
    if (window && enabled) {
        self.backgroundColor = self.backgroundColor;
        self.separatorColor = self.separatorColor;
    }
}

CHDeclareMethod(1, void, UITableView, setSeparatorColor, UIColor *, separatorColor)
{
    if (enabled && enableNightTheme)
        separatorColor = cvkMainController.nightThemeScheme.backgroundColor;
    
    CHSuper(1, UITableView, setSeparatorColor, separatorColor);
}

CHDeclareMethod(1, void, UITableView, setBackgroundColor, UIColor *, backgroundColor)
{
    if (enabled && enableNightTheme)
        backgroundColor = cvkMainController.nightThemeScheme.backgroundColor;
    
    CHSuper(1, UITableView, setBackgroundColor, backgroundColor);
}

CHDeclareClass(LoadingFooterView);
CHDeclareMethod(0, void, LoadingFooterView, layoutSubviews)
{
    CHSuper(0, LoadingFooterView, layoutSubviews);
    
    if (enabled && !enableNightTheme && [self.superview isKindOfClass:[UITableView class]]) {
        if ([((UITableView *)self.superview).backgroundView isKindOfClass:[ColoredVKWallpaperView class]]) {
            self.label.textColor = UITableViewCellTextColor;
            self.anim.color = UITableViewCellTextColor;
        }
    }
}


#pragma mark - UIViewController
CHDeclareClass(UIViewController);
CHDeclareMethod(3, void, UIViewController, presentViewController, UIViewController *, VCToPresent, animated, BOOL, flag, completion, id, completion)
{
    if (![NSStringFromClass([self class]) containsString:@"ColoredVK"]) {
        if (IS_IPAD && ([VCToPresent isKindOfClass:[UIAlertController class]] || 
                        [VCToPresent isKindOfClass:[UIActivityViewController class]]
                        )) {
            VCToPresent.modalPresentationStyle = UIModalPresentationPopover;
            VCToPresent.popoverPresentationController.permittedArrowDirections = 0;
            VCToPresent.popoverPresentationController.sourceView = self.view;
            VCToPresent.popoverPresentationController.sourceRect = self.view.bounds;
        }
    }
    
    CHSuper(3, UIViewController, presentViewController, VCToPresent, animated, flag, completion, completion);
    
}


#pragma mark -
#pragma mark VKSettings
#pragma mark -

#pragma mark PSListController
CHDeclareClass(PSListController);
CHDeclareMethod(1, void, PSListController, viewWillAppear, BOOL, animated)
{
    resetNavigationBar(self.navigationController.navigationBar);
    resetTabBar();
    
    CHSuper(1, PSListController, viewWillAppear, animated);
}

#pragma mark SelectAccountTableViewController
CHDeclareClass(SelectAccountTableViewController);
CHDeclareMethod(1, void, SelectAccountTableViewController, viewWillAppear, BOOL, animated)
{
    CHSuper(1, SelectAccountTableViewController, viewWillAppear, animated);
    resetNavigationBar(self.navigationController.navigationBar);
    resetTabBar();
}


CHDeclareClass(UITabBarItem);
CHDeclareMethod(1, void, UITabBarItem, setImage, UIImage *, image)
{
    if (ios_available(10.0)) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    } else {
        UIColor *itemTintColor = (enabled && enabledTabbarColor) ? (enableNightTheme ? cvkMainController.nightThemeScheme.buttonColor : tabbarForegroundColor) : [UIColor cvk_defaultColorForIdentifier:@"TabbarForegroundColor"];
        image = [image cvk_imageWithTintColor:itemTintColor];
    }
    
    CHSuper(1, UITabBarItem, setImage, image);
}

CHDeclareMethod(1, void, UITabBarItem, setSelectedImage, UIImage *, selectedImage)
{
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    CHSuper(1, UITabBarItem, setSelectedImage, selectedImage);
}


#define HOOK_STATUS_BAR_STYLE(Class) \
    CHDeclareClass(Class); \
    CHDeclareMethod(0, UIStatusBarStyle, Class, preferredStatusBarStyle) { \
        return statusBarStyleForController(self, CHSuper(0, Class, preferredStatusBarStyle)); \
    }

HOOK_STATUS_BAR_STYLE(ArticlePageController)
HOOK_STATUS_BAR_STYLE(VKAudioPlayerListTableViewController)
HOOK_STATUS_BAR_STYLE(PostEditController)
HOOK_STATUS_BAR_STYLE(VKPhotoPicker)
HOOK_STATUS_BAR_STYLE(StoryEditorSendViewController)
HOOK_STATUS_BAR_STYLE(VKAPViewController)
HOOK_STATUS_BAR_STYLE(VKPPAlbumListController)
HOOK_STATUS_BAR_STYLE(PostEditOptionsController)

#undef HOOK_STATUS_BAR_STYLE
