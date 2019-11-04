//全局变量&方法

//api接口相关
class ApiUrl{
  static String apiUrl = "https://openingsource.org/wp-json/wp/v2/";
  //切换api接口（0、默认、使用原接口，1、使用国内反代）
  static void changeApiUrl(int i) {
    switch(i) {
      case 0:
        apiUrl = "https://openingsource.org/wp-json/wp/v2/";
        break;
      case 1:
        apiUrl = "https://os.maxoyed.com/wp-json/wp/v2/";
        break;
      default:
        apiUrl = "https://openingsource.org/wp-json/wp/v2/";
    }
  }
  //获取url
  static String getApiUrl() {
    return apiUrl;
  }
}