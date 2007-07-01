Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l614ZbrZ018212
	for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2007 00:35:37 -0400
Received: from server.engineering.idb (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l614ZXYt012673
	for <selinux@tycho.nsa.gov>; Sun, 1 Jul 2007 04:35:35 GMT
Message-ID: <46872F11.8030906@aus-city.com>
Date: Sun, 01 Jul 2007 14:35:29 +1000
From: David Cottle <webmaster@aus-city.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: selinux AVC errors despite making a rule :(
Content-Type: multipart/mixed;
 boundary="------------040707080701090201010709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040707080701090201010709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Okay I got a server running FC6 and Plesk 8.1.1 running websites.

I do a :
grep avc /var/log/messages
to see any policies need tweaking.

I get:
Jun 28 23:29:18 server kernel: audit(1183073358.302:2368: avc: denied {
link } for pid=8544 comm="in.proftpd"
scontext=system_u:system_r:ftpd_t:s0
tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=key

every single minute. Now I started a webcam that FTPs into the server
every minute. So I thought no biggy, its in.proftpd, lets make a policy:

grep proftpd /var/log/messages | audit2allow -M proftpd
selinux -i proftpd.pp

okay but i STILL get these errors every minute...

Can someone please help me?

Thanks!

--------------040707080701090201010709
Content-Type: text/x-vcard; charset=utf-8;
 name="webmaster.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="webmaster.vcf"

begin:vcard
fn:David Cottle
n:Cottle;David
email;internet:webmaster@aus-city.com
title:Webmaster
version:2.1
end:vcard


--------------040707080701090201010709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
