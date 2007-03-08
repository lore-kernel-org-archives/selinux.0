Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28Evn3W005398
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:57:49 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28EvljV007580
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:57:48 GMT
Message-ID: <45F02455.3030907@redhat.com>
Date: Thu, 08 Mar 2007 09:57:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: radius needs to read netlink_route and fix r_dir_perms->list_dir_perms
Content-Type: multipart/mixed;
 boundary="------------080402020009070607020604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080402020009070607020604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080402020009070607020604
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_services_radius.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_services_radius.patch"

--- nsaserefpolicy/policy/modules/services/radius.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/services/radius.te	2007-03-08 08:42:37.000000000 -0500
@@ -36,8 +36,9 @@
 allow radiusd_t self:unix_stream_socket create_stream_socket_perms;
 allow radiusd_t self:tcp_socket create_stream_socket_perms;
 allow radiusd_t self:udp_socket create_socket_perms;
+allow radiusd_t self:netlink_route_socket r_netlink_socket_perms;
 
-allow radiusd_t radiusd_etc_t:dir r_dir_perms;
+allow radiusd_t radiusd_etc_t:dir list_dir_perms;
 read_files_pattern(radiusd_t,radiusd_etc_t,radiusd_etc_t)
 read_lnk_files_pattern(radiusd_t,radiusd_etc_t,radiusd_etc_t)
 files_search_etc(radiusd_t)

--------------080402020009070607020604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
