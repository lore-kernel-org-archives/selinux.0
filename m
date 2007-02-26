Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QJGeuZ017314
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 14:16:40 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1QJI1PM002402
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 19:18:01 GMT
Message-ID: <45E33256.3050506@redhat.com>
Date: Mon, 26 Feb 2007 14:17:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Fix man page
Content-Type: multipart/mixed;
 boundary="------------080402080400010308070102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080402080400010308070102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080402080400010308070102
Content-Type: text/plain;
 name="nsaserefpolicy_man_man8_kerberos_selinux.8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_man_man8_kerberos_selinux.8"

--- nsaserefpolicy/man/man8/kerberos_selinux.8	2007-02-19 11:32:55.000000000 -0500
+++ serefpolicy-2.5.5/man/man8/kerberos_selinux.8	2007-02-26 11:04:22.000000000 -0500
@@ -23,7 +23,7 @@
 .EX
 setsebool -P krb5kdc_disable_trans 1
 service krb5kdc restart
-setsebool -P kadmind_disable_trans booleans 1
+setsebool -P kadmind_disable_trans 1
 service kadmind restart
 .EE
 .PP

--------------080402080400010308070102--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
