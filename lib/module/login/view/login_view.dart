import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:antrian_app/core.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        controller.view = this;

        return Theme(
            data: ThemeData(
              primaryColor: Colors.purple,
              scaffoldBackgroundColor: Colors.white,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.purple,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.purple.withOpacity(0.1),
                iconColor: Colors.purple,
                prefixIconColor: Colors.purple,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Responsive(
                mobile: mobileView(context: context, controller: controller),
                desktop: desktopView(context: context, controller: controller),
                tablet: mobileView(context: context, controller: controller),
              ),
            ));
      },
    );
  }

  desktopView(
      {required BuildContext context, required LoginController controller}) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 150.0,
                      ),
                      const Column(
                        children: [
                          Text(
                            "Sign In To Bank ABC",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                                fontSize: 40),
                          ),
                          SizedBox(height: 16.0 * 2),
                          SizedBox(height: 16.0 * 2),
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 8,
                              child: Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: Colors.purple,
                                      controller: controller.email,
                                      decoration: const InputDecoration(
                                        hintText: "Your email",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.person),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        obscureText: true,
                                        cursorColor: Colors.purple,
                                        controller: controller.password,
                                        decoration: const InputDecoration(
                                          hintText: "Your password",
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Icon(Icons.lock),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 50.0),
                                    Hero(
                                      tag: "login_btn",
                                      child: SizedBox(
                                        width: 200,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            controller.doLogin();
                                          },
                                          child: Text(
                                            "Login".toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16.0),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Text(
                                          "Don’t have an Account ? ",
                                          style:
                                              TextStyle(color: Colors.purple),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return Container();
                                                },
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CostumerPickQueueView()),
                                            );
                                          },
                                          child: const Text(
                                            "Menu Antrian Costumer",
                                            style: TextStyle(
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(const LayarView());
                                          },
                                          child: const Text(
                                            "Menu Antrian Layar",
                                            style: TextStyle(
                                              color: Colors.purple,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: media!['link'],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            8.0,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 200.0,
                              width: 300,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 50.0, vertical: 50),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    8.0,
                                  ),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 120.0,
                                    width: 120.0,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "assets/logo/bank.png",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          8.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    "Bank ABC",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      color: Colors.grey[200],
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  mobileView(
      {required BuildContext context, required LoginController controller}) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Column(
                    children: [
                      Text(
                        "Sign In To Bank ABC",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          fontSize: 28.0,
                        ),
                      ),
                      SizedBox(height: 16.0 * 2),
                      SizedBox(height: 16.0 * 2),
                    ],
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 8,
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.purple,
                                controller: controller.email,
                                decoration: const InputDecoration(
                                  hintText: "Your email",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Icon(Icons.person),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  cursorColor: Colors.purple,
                                  controller: controller.password,
                                  decoration: const InputDecoration(
                                    hintText: "Your password",
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.lock),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Hero(
                                tag: "login_btn",
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.doLogin();
                                  },
                                  child: Text(
                                    "Login".toUpperCase(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 220.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "Don’t have an Account ? ",
                                    style: TextStyle(color: Colors.purple),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Container();
                                          },
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CostumerPickQueueView()),
                          );
                        },
                        child: const Text(
                          "Menu Antrian Costumer",
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const LayarView());
                        },
                        child: const Text(
                          "Menu Antrian Layar",
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
