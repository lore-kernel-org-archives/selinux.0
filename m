Subject: writing rules to disallow a domain to read particular files
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: nsa <SELinux@tycho.nsa.gov>
Content-Type: text/plain
Message-Id: <1097940101.2569.5.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Date: Sat, 16 Oct 2004 20:51:41 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

can someone help me with writing policy rules such that -

A domain (say apache_d) cannot access files beyond a directory
/home/jaspreet/

any clues ???

Also if anyone could explain the behavior of "newrole" how can that be
used here.

Jaspreet


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
