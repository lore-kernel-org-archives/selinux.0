Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6PNoTrT021560
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 19:50:29 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6PNoSYd010632
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 23:50:28 GMT
Received: from [10.76.0.1] (nexus.verbum.private [10.76.0.1])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by monk.area614.net (Postfix) with ESMTP id 3936F41081C
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 19:50:25 -0400 (EDT)
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-k6r0bmHmrtRNwSPyiEAx"
Message-Id: <1090798759.13627.7.camel@nexus.verbum.private>
Mime-Version: 1.0
Subject: [patch] actually label /dev/net
Date: Sun, 25 Jul 2004 19:50:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-k6r0bmHmrtRNwSPyiEAx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Attached is a very tiny patch against the FC2 policy to label /dev/net.
This is needed for the OpenVPN policy, in the next message.





--=-k6r0bmHmrtRNwSPyiEAx
Content-Disposition: attachment; filename=dev-net-label.patch
Content-Type: text/x-patch; name=dev-net-label.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

* finding or making patch-18
* finding or making patch-19
* computing changeset
A  {arch}/policy/policy--main/policy--main--0/root@area614.net--monk/patch-log/patch-19
M  file_contexts/types.fc
* changeset report
* added files

    {arch}/policy/policy--main/policy--main--0/root@area614.net--monk/patch-log/patch-19

* modified files

--- orig/file_contexts/types.fc
+++ mod/file_contexts/types.fc
@@ -139,6 +139,7 @@
 /u?dev/nb[^/]+		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/ataraid/.*		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/loop.*		-b	system_u:object_r:fixed_disk_device_t
+/u?dev/net/.*		-c	system_u:object_r:tun_tap_device_t
 /u?dev/ram.*		-b	system_u:object_r:fixed_disk_device_t
 /u?dev/rawctl		-c	system_u:object_r:fixed_disk_device_t
 /u?dev/raw/raw[0-9]+	-c	system_u:object_r:fixed_disk_device_t




--=-k6r0bmHmrtRNwSPyiEAx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
