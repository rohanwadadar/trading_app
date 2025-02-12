import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.white),
            onPressed: () {
              // Add action for chat
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header Section
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      AssetImage('assets/images/profile_picture.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Fery Pratama',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Last Updated On Sep 07 2024',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // About Section
              SectionTitle(title: 'About'),
              ProfileOption(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {},
              ),
              ProfileOption(
                icon: Icons.info_outline,
                title: 'Profile Information',
                onTap: () {},
              ),

              // Activity & Orders Section
              SectionTitle(title: 'Activity & Orders'),
              ProfileOption(
                icon: Icons.history,
                title: 'Activity History',
                onTap: () {},
              ),
              ProfileOption(
                icon: Icons.shopping_bag_outlined,
                title: 'Orders',
                onTap: () {},
              ),

              // Watch Lists Section
              SectionTitle(title: 'Watch Lists'),
              ProfileOption(
                icon: Icons.star_outline,
                title: 'Manage Watch Lists',
                onTap: () {},
              ),

              // Tax Forms Section
              SectionTitle(title: 'Tax Forms'),
              ProfileOption(
                icon: Icons.description_outlined,
                title: 'Tax Documents',
                onTap: () {},
              ),

              // Communication Section
              SectionTitle(title: 'Communication'),
              ProfileOption(
                icon: Icons.email_outlined,
                title: 'Message Center',
                onTap: () {},
              ),
              ProfileOption(
                icon: Icons.notifications_outlined,
                title: 'Notification Preferences',
                onTap: () {},
              ),

              // Alerts Section
              SectionTitle(title: 'Alerts'),
              ProfileOption(
                icon: Icons.notification_important_outlined,
                title: 'Manage Alerts',
                onTap: () {},
              ),

              // Account Features Section
              SectionTitle(title: 'Account Features'),
              ProfileOption(
                icon: Icons.featured_play_list_outlined,
                title: 'Feature Settings',
                onTap: () {},
              ),

              // Payments & Transfers Section
              SectionTitle(title: 'Payments & Transfers'),
              ProfileOption(
                icon: Icons.payments_outlined,
                title: 'Payment Methods',
                onTap: () {},
              ),
              ProfileOption(
                icon: Icons.swap_horiz,
                title: 'Transfer Settings',
                onTap: () {},
              ),

              // Brokerage & Trading Section
              SectionTitle(title: 'Brokerage & Trading'),
              ProfileOption(
                icon: Icons.trending_up,
                title: 'Trading Preferences',
                onTap: () {},
              ),

              // Banks & Cards Section
              SectionTitle(title: 'Banks & Cards'),
              ProfileOption(
                icon: Icons.credit_card,
                title: 'Manage Debit Cards',
                onTap: () {},
              ),
              ProfileOption(
                icon: Icons.account_balance,
                title: 'Linked Accounts & Banks',
                onTap: () {},
              ),

              // Settings Section
              SectionTitle(title: 'Settings'),
              ProfileOption(
                icon: Icons.settings,
                title: 'General Settings',
                onTap: () {},
              ),
              ProfileOption(
                icon: Icons.view_quilt,
                title: 'Layout',
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                  activeColor: Colors.blue,
                ),
              ),

              // Help Section
              SectionTitle(title: 'Get Help'),
              ProfileOption(
                icon: Icons.help_outline,
                title: 'FAQ',
                onTap: () {},
              ),
              ProfileOption(
                icon: Icons.support_agent,
                title: 'Contact Support',
                onTap: () {},
              ),

              // Logout Option
              SizedBox(height: 20),
              ProfileOption(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {},
                textColor: Colors.red,
              ),

              SizedBox(height: 30),
              // Social Media Section
              Center(
                child: Column(
                  children: [
                    Text(
                      'Our Social Media',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialMediaIcon(icon: FontAwesomeIcons.facebook),
                        SocialMediaIcon(icon: FontAwesomeIcons.instagram),
                        SocialMediaIcon(icon: FontAwesomeIcons.twitter),
                        SocialMediaIcon(icon: FontAwesomeIcons.whatsapp),
                        SocialMediaIcon(icon: FontAwesomeIcons.snapchat),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'App version 1.0.0',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Function? onTap;
  final Color textColor;

  ProfileOption({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontSize: 16),
      ),
      trailing: trailing ??
          Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap as void Function()?,
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final IconData icon;

  SocialMediaIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}
