/**
 * --------------------------------------------------------------------------
 * Job banner visibility toggle
 * --------------------------------------------------------------------------
 * TODO:
 * - replace fades with CSS animation
 */

jQuery(function () {
  const COOKIE_NAME         = 'job-banner-dismissed';
  const DISMISS_PERIOD_DAYS = 7;
  const VISIBLE_CSS_CLASS   = 'ik-job-banner__visible';
  const HIDDEN_CSS_CLASS    = 'ik-job-banner__hidden';

  const BANNER_SELECTOR = '.ik-job-banner';
  const BUTTON_SELECTOR = '.ik-job-banner--dismiss';

  function hideJobBanner($banner) {
    $banner.fadeOut(700).removeClass(VISIBLE_CSS_CLASS).addClass(HIDDEN_CSS_CLASS);
  }

  function showJobBanner($banner) {
    console.log("Showing job banner");

    $banner.fadeIn(700).removeClass(HIDDEN_CSS_CLASS).addClass(VISIBLE_CSS_CLASS);
  }

  function isDismissed() {
    return Cookies.get(COOKIE_NAME);
  }

  function setDismissed() {
    Cookies.set(COOKIE_NAME, 1, {expires: DISMISS_PERIOD_DAYS});
  }

  const $banner        = $(BANNER_SELECTOR);
  const $dismissButton = $(BUTTON_SELECTOR, $banner);
  const dismissed      = isDismissed();

  if (!dismissed) {
    showJobBanner($banner);

    $dismissButton.click(function () {
      hideJobBanner($banner);
      setDismissed();
    });
  } else {
    console.log("Job banner dismissed");
  }
});
