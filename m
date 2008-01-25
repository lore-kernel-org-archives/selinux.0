Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0P5PhWR008070
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2008 00:25:43 -0500
Received: from tyo201.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0P5Pf4W021801
	for <selinux@tycho.nsa.gov>; Fri, 25 Jan 2008 05:25:42 GMT
Message-ID: <47997296.2010603@ak.jp.nec.com>
Date: Fri, 25 Jan 2008 14:24:38 +0900
From: Kohei KaiGai <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: dwalsh@redhat.com
CC: cpebenito@tresys.com, selinux@tycho.nsa.gov
Subject: racoon got dead due to permission lacking
Content-Type: multipart/mixed;
 boundary="------------030503020902060106040502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030503020902060106040502
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

When I tested labeled ipsec, racoon got dead with the following messages:
(I added some line break for reader's confortable)

| type=AVC msg=audit(1201052881.758:783): avc:  denied  { read }
|   for  pid=26854 comm="racoon" name="net" dev=proc ino=4026531867
|   scontext=root:system_r:racoon_t:s0
|   tcontext=system_u:object_r:proc_t:s0 tclass=dir
| type=AVC msg=audit(1201052881.758:784): avc:  denied  { read }
|   for  pid=26854 comm="racoon" name="unix" dev=proc ino=4026532018
|   scontext=root:system_r:racoon_t:s0
|   tcontext=system_u:object_r:proc_t:s0 tclass=file
| type=AVC msg=audit(1201052881.758:785): avc:  denied  { node_bind }
|   for  pid=26854 comm="racoon" saddr=127.0.0.1 src=500
|   scontext=root:system_r:racoon_t:s0
|   tcontext=system_u:object_r:lo_node_t:s0 tclass=udp_socket
| type=AVC msg=audit(1201052881.759:786): avc:  denied  { node_bind }
|   for  pid=26854 comm="racoon" saddr=10.19.71.81 src=500
|   scontext=root:system_r:racoon_t:s0
|   tcontext=system_u:object_r:node_t:s0 tclass=udp_socket
| type=AVC msg=audit(1201052881.759:787): avc:  denied  { node_bind }
|   for  pid=26854 comm="racoon" saddr=0000:0000:0000:0000:0000:0000:0000:0001 src=500
|   scontext=root:system_r:racoon_t:s0
|   tcontext=system_u:object_r:compat_ipv4_node_t:s0 tclass=udp_socket
| type=AVC msg=audit(1201052881.759:788): avc:  denied  { node_bind }
|   for  pid=26854 comm="racoon" saddr=fe80:0000:0000:0000:0211:09ff:fe34:68e0 src=500
|   scontext=root:system_r:racoon_t:s0
|   tcontext=system_u:object_r:link_local_node_t:s0 tclass=udp_socket

selinux-policy-3.2.5-15.fc9 and ipsec-tools-0.7-8.fc9 are installed.
It seems to me that racoon tries to read /proc/net/unix, and bind adresses
on udp socket.

The attached patch grant those permissions, and it killed this matter.
Please apply it.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------030503020902060106040502
Content-Type: text/x-patch;
 name="serefpolicy-ipsec-racoon-fixed.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serefpolicy-ipsec-racoon-fixed.patch"

--- serefpolicy-3.2.5/policy/modules/system/ipsec.te	2007-12-19 19:37:28.000000000 +0900
+++ serefpolicy-3.2.5.fixed/policy/modules/system/ipsec.te	2008-01-25 11:57:06.000000000 +0900
@@ -301,8 +301,12 @@
 
 corenet_all_recvfrom_unlabeled(racoon_t)
 corenet_tcp_bind_all_nodes(racoon_t)
+corenet_udp_bind_all_nodes(racoon_t)
 corenet_udp_bind_isakmp_port(racoon_t)
 
+# /proc/net/...
+read_files_pattern(racoon_t,proc_t,proc_t)
+
 dev_read_urand(racoon_t)
 
 # allow racoon to set contexts on ipsec policy and SAs

--------------030503020902060106040502--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
