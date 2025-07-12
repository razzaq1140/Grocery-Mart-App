import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(Icons.shopping_bag, "Orders"),
                _buildMenuItem(Icons.person_outline, "My Details"),
                _buildMenuItem(Icons.location_on_outlined, "Delivery Address"),
                _buildMenuItem(Icons.credit_card_outlined, "Payment Methods"),
                _buildMenuItem(Icons.card_giftcard_outlined, "Promo Cord"),
                _buildMenuItem(Icons.notifications_none, "Notifications"),
                _buildMenuItem(Icons.help_outline, "Help"),
                _buildMenuItem(Icons.info_outline, "About"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildLogoutButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(
              "https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg",
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Afsar Hossen",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.edit, size: 16, color: Colors.green),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "lmshuvo97@gmail.com",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
          onTap: () {},
        ),
        Divider(height: 1, thickness: 0.5),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: GestureDetector(
        onTap: () {
          // TODO: Handle logout
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
