Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m24E47rC018001
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 09:04:07 -0500
Received: from web32205.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m24E45Re014702
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2008 14:04:05 GMT
Date: Tue, 4 Mar 2008 05:37:23 -0800 (PST)
From: Hal <hal_bg@yahoo.com>
Subject: xguest_u, LDAP and /tmp
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <394679.44483.qm@web32205.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,
I have been trying to implement xguest on our public computer room.
The users are authenticated by OpenLDAP (for easier user maintenance since
there are many computers) and I successfully converted all the users to
xguest_u. 
I want to achieve a bit more security: I do not want the users to see other
usernames using for example "ps -ef", "who", lastlog, and /tmp or /var/tmp. 

I saw something in D.Walsh blog which seems promising:
======
Also add these lines to /etc/secuirty/namespace.conf
/tmp    tmpfs   tmpfs   ~xguest
/var/tmp        tmpfs   tmpfs   ~xguest
$HOME           tmpfs   tmpfs   ~xguest
======
So is there any way to make this default for all the users on all machines. And
new users to work automatically with such private /tmp and /var/tmp?

Converting users however introduced another problem with firefox, it stopped
working for the ldap users, but not for the local (/etc/passwd) ones which are
also xguests. Tcpdump revealed LDAP requests by firefox only for the LDAP
users. Any idea how to solve this issue?

Thank you in advance!
All ideas and solutions are welcome!

Hal




      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
