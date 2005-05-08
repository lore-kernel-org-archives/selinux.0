Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j48HpXgA027870
	for <selinux@tycho.nsa.gov>; Sun, 8 May 2005 13:51:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j48HnTUT027801
	for <selinux@tycho.nsa.gov>; Sun, 8 May 2005 17:49:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: petre rodan <kaiowas@gentoo.org>
Subject: Re: gentoo diffs
Date: Mon, 9 May 2005 03:49:18 +1000
Cc: SELinux <selinux@tycho.nsa.gov>
References: <427CBAD8.6060901@gentoo.org>
In-Reply-To: <427CBAD8.6060901@gentoo.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iElfCgmE1NuIFGA"
Message-Id: <200505090349.22645.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_iElfCgmE1NuIFGA
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 07 May 2005 22:55, petre rodan <kaiowas@gentoo.org> wrote:
> * named: changed one file label

I've attached a patch to apply after that one, it does the same thing for 
Debian and also changes a "." to "\.".

> * daemontools: policy cleanup, added support for 2 more services

+daemon_base_domain(svc_start)
+domain_auto_trans(init_t, svc_start_exec_t, svc_start_t)

Is this for daemons that may be started either from /etc/inittab 
or /etc/init.d scripts?

> * kerberos: gentoo file locations

Those should have ifdef(`distro_gentoo' around them.  Ideally we want as many 
ifdef(`distro_... rules in the file contexts as possible.  The more stuff 
that can be removed because of being applicable to distributions other than 
the one you use the better.  setfiles still has performance issues...

> * postfix: gentoo file locations for 64bit systems

Are you seriously planning to have both 32bit and 64bit versions of Postfix 
installed on the same system at the same time?  If not then you shouldn't be 
using special names for 64bit versions.  If you are then I suspect you are 
doing something vastly different from what everyone else is doing and 
ifdef(`distro_gentoo' would be appropriate.

We should probably have ifdef(`distro_redhat' and ifdef(`distro_debian' in any 
case.

Also I'm quite certain that you are not using all four combinations 
of /usr/lib(exec)?(64)?/postfix/.

I plan to extend the stem compression support in setfiles to two levels, 
taking full advantage of that means removing such conditionals from the 
policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_iElfCgmE1NuIFGA
Content-Type: text/x-diff;
  charset="utf-8";
  name="named.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="named.diff"

--- file_contexts/program/named.fc.orig	2005-05-09 03:34:48.000000000 +1000
+++ file_contexts/program/named.fc	2005-05-09 03:35:35.000000000 +1000
@@ -9,12 +9,12 @@
 ifdef(`distro_debian', `
 /etc/bind(/.*)?			system_u:object_r:named_zone_t
 /etc/bind/named\.conf	--	system_u:object_r:named_conf_t
-/etc/bind/rndc\.key	--	system_u:object_r:named_conf_t
+/etc/bind/rndc\.key	--	system_u:object_r:dnssec_t
 /var/cache/bind(/.*)?		system_u:object_r:named_cache_t
 ') dnl distro_debian
 
 /etc/rndc.*		--	system_u:object_r:named_conf_t
-/etc/rndc.key  		-- 	system_u:object_r:dnssec_t
+/etc/rndc\.key		-- 	system_u:object_r:dnssec_t
 /usr/sbin/named      	--	system_u:object_r:named_exec_t
 /usr/sbin/named-checkconf --	system_u:object_r:named_checkconf_exec_t
 /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t

--Boundary-00=_iElfCgmE1NuIFGA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
