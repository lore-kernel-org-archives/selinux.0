Message-ID: <20050223183241.11825.qmail@web51504.mail.yahoo.com>
Date: Wed, 23 Feb 2005 10:32:41 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Question of purpose of labeling port numbers?
To: SELinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

  We know that in SELinux, TCP and UDP port numbers
are labeled to permit controls over the ability to
bind to particular ports. e.g., we can write a rule
"allow $1 port_t:udp_socket name_bind;" to explain
this.

  But, in the definition of macro "can_network" (in
global_macros.te), we can see the following rule:
"allow $1 port_type:{ tcp_socket udp_socket } {
send_msg recv_msg };".
  Does this rule mean that TCP and UDP port numbers
are also labeled to permit controls over the ability
of the socket(i.e. tcp_socket and udp_socket) to send
or receive messages on particular ports? 

Thank you.

=====
Best Regards,
Park Lee


	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
