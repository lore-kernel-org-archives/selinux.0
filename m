Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2DATpxj010766
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 06:29:51 -0400
Received: from web86905.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2DATon3007494
	for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2007 10:29:50 GMT
Message-ID: <20070313102950.92335.qmail@web86905.mail.ukl.yahoo.com>
Date: Tue, 13 Mar 2007 10:29:46 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Confirmation about task_has_security in selinuxfs.c
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1173702959.2738.10.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I wanted to confirm that the function
"task_has_security" is the one which interacts with
the Security Server for access decisions? and the
variable "tsec" is the one which stores and conveys
the ultimate access decision by the SELinux Security
Server.

According to documentation, the SELinux FileSystem
interacts with the Security Server, which further
checks the possiblity of a decision stored in the
Access Vector Cache.


If Not, kindly guide me for the location responsible
for the interaction with the security server. 

Thank You,
MA





		
___________________________________________________________ 
All New Yahoo! Mail – Tired of unwanted email come-ons? Let our SpamGuard protect you. http://uk.docs.yahoo.com/nowyoucan.html


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
