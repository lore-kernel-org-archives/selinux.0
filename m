Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBK11LIi012175
	for <selinux@tycho.nsa.gov>; Sun, 19 Dec 2004 20:01:25 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBK11LKh005336
	for <selinux@tycho.nsa.gov>; Mon, 20 Dec 2004 01:01:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: [patch] misc. policy updates
Date: Mon, 20 Dec 2004 12:01:10 +1100
Cc: SELinux <selinux@tycho.nsa.gov>
References: <20041217012224.GA11330@yggdrasil.localdomain>
In-Reply-To: <20041217012224.GA11330@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XRixB2Wy0bMiE+7"
Message-Id: <200412201201.11825.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_XRixB2Wy0bMiE+7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 17 December 2004 12:22, Greg Norris <haphazard@kc.rr.com> wrote:
> The attached diff against ddclient.te is necessary in order for it to
> work properly with the new networking macros.  Also, it updates my email
> address in the policy header.  The other two simply perform the latter
> update for the other policies I've submitted.

I've added them to my tree.  I also added "log_domain(ddclient)" at the end of 
the file (no patch attached as a patch for a patch is painful) and added the 
attached patch to the file_contexts.

This means that ddclient takes over the policy of ddt-client.  Please delete 
ddt-client.te and ddt-client.fc from the policy source.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_XRixB2Wy0bMiE+7
Content-Type: text/x-diff;
  charset="utf-8";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/file_contexts/program/ddclient.fc	2004-11-20 01:18:19.000000000 +1100
+++ file_contexts/program/ddclient.fc	2004-12-20 11:56:53.000000000 +1100
@@ -3,3 +3,9 @@
 /usr/sbin/ddclient		--	system_u:object_r:ddclient_exec_t
 /var/cache/ddclient(/.*)?	--	system_u:object_r:ddclient_var_t
 /var/run/ddclient\.pid		--	system_u:object_r:ddclient_var_run_t
+# ddt - Dynamic DNS client
+/usr/sbin/ddtcd		--	system_u:object_r:ddclient_exec_t
+/var/run/ddtcd\.pid	--	system_u:object_r:ddclient_var_run_t
+/etc/ddtcd\.conf	--	system_u:object_r:ddclient_etc_t
+/var/lib/ddt-client(/.*)?	system_u:object_r:var_lib_ddclient_t
+/var/log/ddtcd\.log.*	--	system_u:object_r:ddclient_log_t

--Boundary-00=_XRixB2Wy0bMiE+7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
