import 'package:avalor_app/metamaskprovider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MetaMaskProvider()..init(),
        builder: (context, child) {
          return Scaffold(
            body: Container(
              color: const Color.fromRGBO(28, 17, 67, 1),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Consumer<MetaMaskProvider>(
                  builder: (context, provider, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size:
                                    const Size.fromRadius(40.0), // Image radius
                                child: Image.asset('assets/images/newicon.png',
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          const Text(
                            "Kart Racing League",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          const Text(
                            "BLIND MINT EVENT",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Lottie.asset('assets/images/giftanimation.json',
                          repeat: false, animate: provider.isanim),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.yellow),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(21.0))),
                              onPressed: () {
                                context.read<MetaMaskProvider>().animate();
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.document_scanner_outlined,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "Approve",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                          const SizedBox(
                            width: 10.0,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: provider.balance ==
                                          BigInt.from(-1)
                                      ? MaterialStateProperty.all(Colors.yellow)
                                      : MaterialStateProperty.all(
                                          Colors.blue[100]),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(25.0))),
                              onPressed: () {
                                context.read<MetaMaskProvider>().connect();
                              },
                              child: provider.balance == BigInt.from(-1)
                                  ? const Text(
                                      "CONNECT",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Row(
                                      children: [
                                        ClipOval(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(
                                                10.0), // Image radius
                                            child: Image.asset(
                                                'assets/images/download.png',
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          provider.balance.toString() +
                                              " " +
                                              provider.getNetworkName
                                                  .toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ))
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          );
        });
  }
}
