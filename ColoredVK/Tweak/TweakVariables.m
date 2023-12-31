//
//  TweakVariables.m
//  ColoredVK2
//
//  Created by Даниил on 01.04.18.
//

#import "TweakVariables.h"
#import "UIColor+ColoredVK.h"
#import "ColoredVKMainController.h"
#import "ColoredVKNewInstaller.h"
#import "NSObject+ColoredVK.h"
#import "TweakFunctions.h"

@interface UIStatusBar : UIView
@property (nonatomic, strong) UIColor *foregroundColor;
@end
@interface VKMMainController : UIViewController
@property (strong, nonatomic) UITableView *tableView;
@end

BOOL isNew3XClient;

BOOL premiumEnabled;
NSBundle *vksBundle;

BOOL enableQuickAccessMenu;
BOOL enableQuickAccessMenuForceTouch;
BOOL enableQuickAccessMenuLongPress;

CVKCellSelectionStyle menuSelectionStyle;

BOOL enableNightTheme;
BOOL enabled;
BOOL enabledToolBarColor;
BOOL enabledTabbarColor;
BOOL enabledBarColor;
BOOL enabledMessagesListImage;
BOOL enabledGroupsListImage;
BOOL enabledAudioImage;
BOOL enabledMenuImage;
BOOL enabledFriendsImage;

BOOL changeMenuTextColor;
BOOL enabledSettingsExtraImage;
BOOL useSettingsExtraParallax;
BOOL settingsExtraUseBackgroundBlur;
BOOL changeSettingsExtraTextColor;
BOOL hideSettingsSeparators;
BOOL showFastDownloadButton;
BOOL useMenuParallax;
BOOL menuUseBackgroundBlur;
BOOL enabledBarImage;

BOOL hideMenuSearch;
BOOL showBar;
BOOL shouldCheckUpdates;
BOOL changeSBColors;
BOOL hideMenuSeparators;
BOOL messagesUseBlur;
BOOL useCustomMessageReadColor;
BOOL useCustomDialogsUnreadColor;
BOOL menuUseBlur;
BOOL changeMessagesInput;

BOOL hideMessagesNavBarItems;
BOOL useMessageBubbleTintColor;
BOOL changeSwitchColor;
BOOL showCommentSeparators;
BOOL disableGroupCovers;
BOOL changeAudioPlayerAppearance;
BOOL enablePlayerGestures;
BOOL enabledSettingsImage;
BOOL hideMessagesListSeparators;
BOOL hideGroupsListSeparators;

BOOL hideAudiosSeparators;
BOOL hideFriendsSeparators;
BOOL hideVideosSeparators;
BOOL hideSettingsExtraSeparators;
BOOL messagesListUseBlur;
BOOL groupsListUseBlur;
BOOL audiosUseBlur;
BOOL friendsUseBlur;
BOOL videosUseBlur;
BOOL settingsUseBlur;

BOOL settingsExtraUseBlur;
BOOL messagesListUseBackgroundBlur;
BOOL groupsListUseBackgroundBlur;
BOOL audiosUseBackgroundBlur;
BOOL friendsUseBackgroundBlur;
BOOL videosUseBackgroundBlur;
BOOL settingsUseBackgroundBlur;
BOOL useMessagesListParallax;
BOOL useGroupsListParallax;
BOOL useAudioParallax;

BOOL useFriendsParallax;
BOOL useVideosParallax;
BOOL useSettingsParallax;
BOOL showMenuCell;
BOOL changeMessagesListTextColor;
BOOL changeGroupsListTextColor;
BOOL changeAudiosTextColor;
BOOL changeFriendsTextColor;
BOOL changeVideosTextColor;
BOOL changeSettingsTextColor;

BOOL useMessagesParallax;
BOOL enabledMessagesImage;
BOOL messagesUseBackgroundBlur;
BOOL changeMessagesTextColor;
BOOL enabledVideosImage;

UIColor *barForegroundColor;
UIColor *toolBarBackgroundColor;
UIColor *toolBarForegroundColor;
UIColor *messagesListBlurTone;
UIColor *groupsListBlurTone;
UIColor *audiosBlurTone;
UIColor *friendsBlurTone;
UIColor *audioPlayerTintColor;
UIColor *menuTextColor;
UIColor *tabbarBackgroundColor;

UIColor *tabbarSelForegroundColor;
UIColor *tabbarForegroundColor;
UIColor *settingsExtraTextColor;
UIColor *SBBackgroundColor;
UIColor *menuSeparatorColor;
UIColor *messageBubbleTintColor;
UIColor *messageBubbleSentTintColor;
UIColor *messagesTextColor;
UIColor *messagesBlurTone;
UIColor *menuBlurTone;

UIColor *messagesInputTextColor;
UIColor *messagesInputBackColor;
UIColor *dialogsUnreadColor;
UIColor *messageUnreadColor;
UIColor *menuSeparatorColor;
UIColor *barBackgroundColor;
UIColor *switchesTintColor;
UIColor *switchesOnTintColor;
UIColor *messagesListTextColor;
UIColor *groupsListTextColor;

UIColor *audiosTextColor;
UIColor *friendsTextColor;
UIColor *videosTextColor;
UIColor *settingsTextColor;
UIColor *videosBlurTone;
UIColor *settingsBlurTone;
UIColor *settingsExtraBlurTone;
UIColor *menuSelectionColor;
UIColor *SBForegroundColor;

CGFloat appCornerRadius;
CGFloat settingsExtraImageBlackout;
CGFloat menuImageBlackout;
CGFloat chatListImageBlackout;
CGFloat groupsListImageBlackout;
CGFloat audioImageBlackout;
CGFloat friendsImageBlackout;
CGFloat videosImageBlackout;
CGFloat settingsImageBlackout;
CGFloat chatImageBlackout;

CGFloat navbarImageBlackout;

UIBlurEffectStyle menuBlurStyle;
UIBlurEffectStyle messagesBlurStyle;
UIBlurEffectStyle messagesListBlurStyle;
UIBlurEffectStyle groupsListBlurStyle;
UIBlurEffectStyle audiosBlurStyle;
UIBlurEffectStyle friendsBlurStyle;
UIBlurEffectStyle videosBlurStyle;
UIBlurEffectStyle settingsBlurStyle;
UIBlurEffectStyle settingsExtraBlurStyle;

UIKeyboardAppearance keyboardStyle;

void reloadPrefs(void(^completion)(void))
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *prefs = [[NSDictionary alloc] initWithContentsOfFile:CVK_PREFS_PATH];
        
        enableQuickAccessMenu = prefs[@"enableQuickAccessMenu"] ? [prefs[@"enableQuickAccessMenu"] boolValue] : YES;
        enableQuickAccessMenuForceTouch = prefs[@"enableQuickAccessMenuForceTouch"] ? [prefs[@"enableQuickAccessMenuForceTouch"] boolValue] : YES;
        enableQuickAccessMenuLongPress = prefs[@"enableQuickAccessMenuLongPress"] ? [prefs[@"enableQuickAccessMenuLongPress"] boolValue] : YES;
        showFastDownloadButton = prefs[@"showFastDownloadButton"] ? [prefs[@"showFastDownloadButton"] boolValue] : YES;
        showMenuCell = prefs[@"showMenuCell"] ? [prefs[@"showMenuCell"] boolValue] : YES;
        cvkMainController.nightThemeScheme.userSelectedType = prefs[@"userSelectednightThemeType"] ? [prefs[@"userSelectednightThemeType"] integerValue] : -1;
        
        enabled = [prefs[@"enabled"] boolValue];
        hideMenuSearch = [prefs[@"hideMenuSearch"] boolValue];
        enabledMenuImage = [prefs[@"enabledMenuImage"] boolValue];
        menuImageBlackout = [prefs[@"menuImageBlackout"] floatValue];
        useMenuParallax = [prefs[@"useMenuParallax"] boolValue];
        useMessagesParallax = [prefs[@"useMessagesParallax"] boolValue];
        showBar = [prefs[@"showBar"] boolValue];
        shouldCheckUpdates = prefs[@"checkUpdates"]?[prefs[@"checkUpdates"] boolValue]:YES;
        
        enabledBarImage = [prefs[@"enabledBarImage"] boolValue];
        enabledBarColor = [prefs[@"enabledBarColor"] boolValue];
        enabledToolBarColor = [prefs[@"enabledToolBarColor"] boolValue];
        enabledTabbarColor = [prefs[@"enabledTabbarColor"] boolValue];
        
        enabledMessagesImage = [prefs[@"enabledMessagesImage"] boolValue];
        hideMenuSeparators = [prefs[@"hideMenuSeparators"] boolValue];
        messagesUseBlur = [prefs[@"messagesUseBlur"] boolValue];
        messagesUseBackgroundBlur = [prefs[@"messagesUseBackgroundBlur"] boolValue];
        useCustomMessageReadColor = [prefs[@"useCustomMessageReadColor"] boolValue];
        useCustomDialogsUnreadColor = [prefs[@"useCustomDialogsUnreadColor"] boolValue];
        menuUseBlur = [prefs[@"menuUseBlur"] boolValue];
        menuUseBackgroundBlur = [prefs[@"menuUseBackgroundBlur"] boolValue];
        changeMessagesInput = [prefs[@"changeMessagesInput"] boolValue];
        
        navbarImageBlackout = [prefs[@"navbarImageBlackout"] floatValue];
        chatImageBlackout = [prefs[@"chatImageBlackout"] floatValue];
        hideMessagesNavBarItems = [prefs[@"hideMessagesNavBarItems"] boolValue];
        changeMenuTextColor = [prefs[@"changeMenuTextColor"] boolValue];
        changeMessagesTextColor = [prefs[@"changeMessagesTextColor"] boolValue];
        useMessageBubbleTintColor = [prefs[@"useMessageBubbleTintColor"] boolValue];
        menuSelectionStyle = prefs[@"menuSelectionStyle"]?[prefs[@"menuSelectionStyle"] integerValue]:CVKCellSelectionStyleTransparent;
        messagesBlurStyle = prefs[@"messagesBlurStyle"]?[prefs[@"messagesBlurStyle"] integerValue]:UIBlurEffectStyleLight;
        menuBlurStyle = prefs[@"menuBlurStyle"]?[prefs[@"menuBlurStyle"] integerValue]:UIBlurEffectStyleLight;
        
        menuSeparatorColor =         [UIColor cvk_savedColorForIdentifier:@"MenuSeparatorColor"         fromPrefs:prefs];
        menuSelectionColor =        [[UIColor cvk_savedColorForIdentifier:@"menuSelectionColor"         fromPrefs:prefs] colorWithAlphaComponent:0.3f];
        barBackgroundColor =         [UIColor cvk_savedColorForIdentifier:@"BarBackgroundColor"         fromPrefs:prefs];
        toolBarBackgroundColor =     [UIColor cvk_savedColorForIdentifier:@"ToolBarBackgroundColor"     fromPrefs:prefs];
        toolBarForegroundColor =     [UIColor cvk_savedColorForIdentifier:@"ToolBarForegroundColor"     fromPrefs:prefs];
        messageBubbleTintColor =     [UIColor cvk_savedColorForIdentifier:@"messageBubbleTintColor"     fromPrefs:prefs];
        messageBubbleSentTintColor = [UIColor cvk_savedColorForIdentifier:@"messageBubbleSentTintColor" fromPrefs:prefs];
        menuTextColor =              [UIColor cvk_savedColorForIdentifier:@"menuTextColor"              fromPrefs:prefs];
        messagesTextColor =          [UIColor cvk_savedColorForIdentifier:@"messagesTextColor"          fromPrefs:prefs];
        messagesBlurTone =          [[UIColor cvk_savedColorForIdentifier:@"messagesBlurTone"           fromPrefs:prefs] colorWithAlphaComponent:0.3f];
        menuBlurTone =              [[UIColor cvk_savedColorForIdentifier:@"menuBlurTone"               fromPrefs:prefs] colorWithAlphaComponent:0.3f];
        tabbarBackgroundColor =     [UIColor cvk_savedColorForIdentifier:@"TabbarBackgroundColor"       fromPrefs:prefs];
        tabbarForegroundColor =     [UIColor cvk_savedColorForIdentifier:@"TabbarForegroundColor"       fromPrefs:prefs];
        tabbarSelForegroundColor =  [UIColor cvk_savedColorForIdentifier:@"TabbarSelForegroundColor"    fromPrefs:prefs];
        messagesInputTextColor =    [UIColor cvk_savedColorForIdentifier:@"messagesInputTextColor"      fromPrefs:prefs];
        messagesInputBackColor =    [UIColor cvk_savedColorForIdentifier:@"messagesInputBackColor"      fromPrefs:prefs];
        dialogsUnreadColor =        [[UIColor cvk_savedColorForIdentifier:@"dialogsUnreadColor"         fromPrefs:prefs] colorWithAlphaComponent:0.3f];
        messageUnreadColor =        [[UIColor cvk_savedColorForIdentifier:@"messageReadColor"           fromPrefs:prefs] colorWithAlphaComponent:0.2f];
        SBBackgroundColor =         [UIColor cvk_savedColorForIdentifier:@"SBBackgroundColor"           fromPrefs:prefs];
        SBForegroundColor =         [UIColor cvk_savedColorForIdentifier:@"SBForegroundColor"           fromPrefs:prefs];
        barForegroundColor =        [UIColor cvk_savedColorForIdentifier:@"BarForegroundColor"          fromPrefs:prefs];
        
        if (!hideMenuSeparators && !prefs[@"MenuSeparatorColor"] && isNew3XClient) {
            menuSeparatorColor  = [UIColor colorWithRed:215/255.0f green:216/255.0f blue:217/255.0f alpha:1.0f];
        }
        

        if (@available(iOS 13.0, *)) {} else {
            [NSObject cvk_runBlockOnMainThread:^{
                UIStatusBar *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
                if (statusBar != nil) {
                    if (enabled && enableNightTheme) {
                        statusBar.foregroundColor = [UIColor whiteColor];
                    } else if (enabled && changeSBColors) {
                        statusBar.foregroundColor = SBForegroundColor;
                        statusBar.backgroundColor = SBBackgroundColor;
                    } else {
                        statusBar.foregroundColor = nil;
                        statusBar.backgroundColor = nil;
                    }
                }
            }];
        }
        
        if (prefs) {
            enableNightTheme = prefs[@"nightThemeType"] ? ([prefs[@"nightThemeType"] integerValue] != -1) : NO;
            [cvkMainController.nightThemeScheme updateForType:[prefs[@"nightThemeType"] integerValue]];
            cvkMainController.nightThemeScheme.enabled = (enabled && enableNightTheme);
            
            if (enableNightTheme && !isNew3XClient) {
                [NSObject cvk_runBlockOnMainThread:^{
                    cvkMainController.menuBackgroundView.alpha = 0.0f;
                    if ([cvkMainController.vkMainController respondsToSelector:@selector(tableView)])
                        resetUISearchBar((UISearchBar*)cvkMainController.vkMainController.tableView.tableHeaderView);
                }];
            }
            
            changeSBColors = [prefs[@"changeSBColors"] boolValue];
            changeSwitchColor = [prefs[@"changeSwitchColor"] boolValue];
            showCommentSeparators = prefs[@"showCommentSeparators"] ? ![prefs[@"showCommentSeparators"] boolValue] : NO;
            
            disableGroupCovers = [prefs[@"disableGroupCovers"] boolValue];
            
            enabledMessagesListImage = [prefs[@"enabledMessagesListImage"] boolValue];
            enabledGroupsListImage = [prefs[@"enabledGroupsListImage"] boolValue];
            enabledAudioImage = [prefs[@"enabledAudioImage"] boolValue];
            changeAudioPlayerAppearance = [prefs[@"changeAudioPlayerAppearance"] boolValue];
            enablePlayerGestures = prefs[@"enablePlayerGestures"] ? [prefs[@"enablePlayerGestures"] boolValue] : YES;
            enabledFriendsImage = [prefs[@"enabledFriendsImage"] boolValue];
            enabledVideosImage = [prefs[@"enabledVideosImage"] boolValue];
            enabledSettingsImage = [prefs[@"enabledSettingsImage"] boolValue];
            enabledSettingsExtraImage = [prefs[@"enabledSettingsExtraImage"] boolValue];
            
            hideMessagesListSeparators = [prefs[@"hideMessagesListSeparators"] boolValue];
            hideGroupsListSeparators = [prefs[@"hideGroupsListSeparators"] boolValue];
            hideAudiosSeparators = [prefs[@"hideAudiosSeparators"] boolValue];
            hideFriendsSeparators = [prefs[@"hideFriendsSeparators"] boolValue];
            hideVideosSeparators = [prefs[@"hideVideosSeparators"] boolValue];
            hideSettingsSeparators = [prefs[@"hideSettingsSeparators"] boolValue];
            hideSettingsExtraSeparators = [prefs[@"hideSettingsExtraSeparators"] boolValue];
            
            messagesListUseBlur = [prefs[@"messagesListUseBlur"] boolValue];
            groupsListUseBlur = [prefs[@"groupsListUseBlur"] boolValue];
            audiosUseBlur = [prefs[@"audiosUseBlur"] boolValue];
            friendsUseBlur = [prefs[@"friendsUseBlur"] boolValue];
            videosUseBlur = [prefs[@"videosUseBlur"] boolValue];
            settingsUseBlur = [prefs[@"settingsUseBlur"] boolValue];
            settingsExtraUseBlur = [prefs[@"settingsExtraUseBlur"] boolValue];
            
            messagesListUseBackgroundBlur = [prefs[@"messagesListUseBackgroundBlur"] boolValue];
            groupsListUseBackgroundBlur = [prefs[@"groupsListUseBackgroundBlur"] boolValue];
            audiosUseBackgroundBlur = [prefs[@"audiosUseBackgroundBlur"] boolValue];
            friendsUseBackgroundBlur = [prefs[@"friendsUseBackgroundBlur"] boolValue];
            videosUseBackgroundBlur = [prefs[@"videosUseBackgroundBlur"] boolValue];
            settingsUseBackgroundBlur = [prefs[@"settingsUseBackgroundBlur"] boolValue];
            settingsExtraUseBackgroundBlur = [prefs[@"settingsExtraUseBackgroundBlur"] boolValue];
            
            
            useMessagesListParallax = [prefs[@"useMessagesListParallax"] boolValue];
            useGroupsListParallax = [prefs[@"useGroupsListParallax"] boolValue];
            useAudioParallax = [prefs[@"useAudioParallax"] boolValue];
            useFriendsParallax = [prefs[@"useFriendsParallax"] boolValue];
            useVideosParallax = [prefs[@"useVideosParallax"] boolValue];
            useSettingsParallax = [prefs[@"useSettingsParallax"] boolValue];
            useSettingsExtraParallax = [prefs[@"useSettingsExtraParallax"] boolValue];
            
            chatListImageBlackout = [prefs[@"chatListImageBlackout"] floatValue];
            groupsListImageBlackout = [prefs[@"groupsListImageBlackout"] floatValue];
            audioImageBlackout = [prefs[@"audioImageBlackout"] floatValue];
            friendsImageBlackout = [prefs[@"friendsImageBlackout"] floatValue];
            videosImageBlackout = [prefs[@"videosImageBlackout"] floatValue];
            settingsImageBlackout = [prefs[@"settingsImageBlackout"] floatValue];
            settingsExtraImageBlackout = [prefs[@"settingsExtraImageBlackout"] floatValue];
            
            appCornerRadius = [prefs[@"appCornerRadius"] floatValue];
            

            changeMessagesListTextColor = [prefs[@"changeMessagesListTextColor"] boolValue];
            changeGroupsListTextColor = [prefs[@"changeGroupsListTextColor"] boolValue];
            changeAudiosTextColor = [prefs[@"changeAudiosTextColor"] boolValue];
            changeFriendsTextColor = [prefs[@"changeFriendsTextColor"] boolValue];
            changeVideosTextColor = [prefs[@"changeVideosTextColor"] boolValue];
            changeSettingsTextColor = [prefs[@"changeSettingsTextColor"] boolValue];
            changeSettingsExtraTextColor = [prefs[@"changeSettingsExtraTextColor"] boolValue];
            
            keyboardStyle = prefs[@"keyboardStyle"]?[prefs[@"keyboardStyle"] integerValue]:UIKeyboardAppearanceDefault;
            
            messagesListBlurStyle = prefs[@"messagesListBlurStyle"]?[prefs[@"messagesListBlurStyle"] integerValue]:UIBlurEffectStyleLight;
            groupsListBlurStyle = prefs[@"groupsListBlurStyle"]?[prefs[@"groupsListBlurStyle"] integerValue]:UIBlurEffectStyleLight;
            audiosBlurStyle = prefs[@"audiosBlurStyle"]?[prefs[@"audiosBlurStyle"] integerValue]:UIBlurEffectStyleLight;
            friendsBlurStyle = prefs[@"friendsBlurStyle"]?[prefs[@"friendsBlurStyle"] integerValue]:UIBlurEffectStyleLight;
            videosBlurStyle = prefs[@"videosBlurStyle"]?[prefs[@"videosBlurStyle"] integerValue]:UIBlurEffectStyleLight;
            settingsBlurStyle = prefs[@"settingsBlurStyle"]?[prefs[@"settingsBlurStyle"] integerValue]:UIBlurEffectStyleLight;
            settingsExtraBlurStyle = prefs[@"settingsExtraBlurStyle"]?[prefs[@"settingsExtraBlurStyle"] integerValue]:UIBlurEffectStyleLight;
            
            
            switchesTintColor =          [UIColor cvk_savedColorForIdentifier:@"switchesTintColor"      fromPrefs:prefs];
            switchesOnTintColor =        [UIColor cvk_savedColorForIdentifier:@"switchesOnTintColor"    fromPrefs:prefs];
            
            messagesListTextColor =      [UIColor cvk_savedColorForIdentifier:@"messagesListTextColor"  fromPrefs:prefs];
            groupsListTextColor =        [UIColor cvk_savedColorForIdentifier:@"groupsListTextColor"    fromPrefs:prefs];
            audiosTextColor =            [UIColor cvk_savedColorForIdentifier:@"audiosTextColor"        fromPrefs:prefs];
            friendsTextColor =           [UIColor cvk_savedColorForIdentifier:@"friendsTextColor"       fromPrefs:prefs];
            videosTextColor =            [UIColor cvk_savedColorForIdentifier:@"videosTextColor"        fromPrefs:prefs];
            settingsTextColor =          [UIColor cvk_savedColorForIdentifier:@"settingsTextColor"      fromPrefs:prefs];
            settingsExtraTextColor =     [UIColor cvk_savedColorForIdentifier:@"settingsExtraTextColor" fromPrefs:prefs];
            
            messagesListBlurTone =      [[UIColor cvk_savedColorForIdentifier:@"messagesListBlurTone"   fromPrefs:prefs] colorWithAlphaComponent:0.3f];
            groupsListBlurTone =        [[UIColor cvk_savedColorForIdentifier:@"groupsListBlurTone"     fromPrefs:prefs] colorWithAlphaComponent:0.3f];
            audiosBlurTone =            [[UIColor cvk_savedColorForIdentifier:@"audiosBlurTone"         fromPrefs:prefs] colorWithAlphaComponent:0.3f];
            friendsBlurTone =           [[UIColor cvk_savedColorForIdentifier:@"friendsBlurTone"        fromPrefs:prefs] colorWithAlphaComponent:0.3f];
            videosBlurTone =            [[UIColor cvk_savedColorForIdentifier:@"videosBlurTone"         fromPrefs:prefs] colorWithAlphaComponent:0.3f];
            settingsBlurTone =          [[UIColor cvk_savedColorForIdentifier:@"settingsBlurTone"       fromPrefs:prefs] colorWithAlphaComponent:0.3f];
            settingsExtraBlurTone =     [[UIColor cvk_savedColorForIdentifier:@"settingsExtraBlurTone"  fromPrefs:prefs] colorWithAlphaComponent:0.3f];
            
            
            ColoredVKVersionCompare client302Compare = [[ColoredVKNewInstaller sharedInstaller].application compareAppVersionWith:@"3.0.2"];
            if (client302Compare >= ColoredVKVersionCompareEqual) {
                changeAudioPlayerAppearance = NO;
            }
        }
        
        [NSObject cvk_runBlockOnMainThread:^{
            resetTabBar();
            actionChangeCornerRadius([UIApplication sharedApplication].keyWindow);
            
            if (cvkMainController.navBarImageView)
                [cvkMainController.navBarImageView updateViewWithBlackout:navbarImageBlackout];
            
            [cvkMainController setMenuCellSwitchOn:enabled];
            
            if (completion)
                completion();
        }];
    });
}
