class ApiUtil {

  static const String MAIN_API_URL = 'https://phplaravel-198319-974141.cloudwaysapps.com/api';

  static const String ALL_CATEGORIES = '/categories';

  static const String RECENT_POSTS = '/posts';

  static String categoryPosts( String categoryID ){
    return MAIN_API_URL + ALL_CATEGORIES + '/' + categoryID + '/posts';
  }


}