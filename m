Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1RJ96Do021099
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 14:09:06 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1RJ5tjS010030
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 19:05:55 GMT
Subject: Re: [ PATCH ] home_domain macro / x_client cleanup patch
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1109437744.4873.28.camel@cobra.ivg2.net>
References: <1109437744.4873.28.camel@cobra.ivg2.net>
Content-Type: multipart/mixed; boundary="=-WNRaKqv8Q7taEeZ18A1N"
Date: Sun, 27 Feb 2005 14:09:29 -0500
Message-Id: <1109531369.21556.28.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WNRaKqv8Q7taEeZ18A1N
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


>- All mozilla changes are reorganizing things. The only
>significant change is that /tmp files are now created in
>$1_mozilla_tmp_t, lpr can only print those, and only
>those ones are executable. 

This broke some things. I also stopped using macros
for interaction w/ $1_tmp_t to reduce privileges. 
Here's a followup patch that addresses some denials. 

Applies on top of the latest policy + the home_domain patch I sent.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-WNRaKqv8Q7taEeZ18A1N
Content-Disposition: attachment; filename=mozilla_fix.diff
Content-Type: text/x-patch; name=mozilla_fix.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

--- mozilla_macros.te	2005-02-27 14:02:43.000000000 -0500
+++ mozilla_macros.new	2005-02-27 14:04:04.000000000 -0500
@@ -74,8 +74,8 @@
 file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_tmp_t)
 can_unix_connect($1_t, $1_mozilla_t)
 allow $1_t $1_mozilla_tmp_t:sock_file write;
-allow $1_mozilla_t $1_tmp_t:file { read write };
-allow $1_mozilla_t $1_tmp_t:sock_file write;
+allow $1_mozilla_t $1_tmp_t:file { read write lock };
+allow $1_mozilla_t $1_tmp_t:sock_file { read write };
 dontaudit $1_mozilla_t $1_tmp_t:dir setattr;
 
 # Allow mozilla to read user home content

--=-WNRaKqv8Q7taEeZ18A1N--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
