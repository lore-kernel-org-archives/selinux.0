Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j06BhIIi007997
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 06:43:18 -0500 (EST)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j06BhJoP007022
	for <selinux@tycho.nsa.gov>; Thu, 6 Jan 2005 11:43:20 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: [patch] logrotate
Date: Thu, 6 Jan 2005 22:43:06 +1100
Cc: SELinux <selinux@tycho.nsa.gov>
References: <20050104030117.GB5321@yggdrasil.localdomain>
In-Reply-To: <20050104030117.GB5321@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_NRS3BkF+fZw2A/k"
Message-Id: <200501062243.09520.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_NRS3BkF+fZw2A/k
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 04 January 2005 14:01, Greg Norris <haphazard@kc.rr.com> wrote:
> Here are a handful of patches for logrotate, which I've found to be
> necessary for my Debian SELinux box... all are against current CVS.
> Please apply.
>
>    logrotate.fc.diff
>
> Debian creates the logrotate state file as "/var/lib/logrotate/status",
> rather than "/var/lib/logrotate.status".  The updated pattern will match
> both cases.

I've attached a slightly different version that will work on other distros 
too.


The other two patches are good as-is.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_NRS3BkF+fZw2A/k
Content-Type: text/x-diff;
  charset="utf-8";
  name="logrotate.fc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="logrotate.fc.diff"

--- /usr/src/se/policy/file_contexts/program/logrotate.fc	2004-11-20 01:18:21.000000000 +1100
+++ file_contexts/program/logrotate.fc	2005-01-06 22:28:37.000000000 +1100
@@ -3,9 +3,11 @@
 /usr/sbin/logcheck	--	system_u:object_r:logrotate_exec_t
 ifdef(`distro_debian', `
 /usr/bin/savelog	--	system_u:object_r:logrotate_exec_t
+/var/lib/logrotate/status --	system_u:object_r:logrotate_var_lib_t
+', `
+/var/lib/logrotate\.status --	system_u:object_r:logrotate_var_lib_t
 ')
 /etc/cron\.(daily|weekly)/sysklogd -- system_u:object_r:logrotate_exec_t
-/var/lib/logrotate\.status --	system_u:object_r:logrotate_var_lib_t
 /var/lib/logcheck(/.*)?		system_u:object_r:logrotate_var_lib_t
 # using a hard-coded name under /var/tmp is a bug - new version fixes it
 /var/tmp/logcheck	-d	system_u:object_r:logrotate_tmp_t

--Boundary-00=_NRS3BkF+fZw2A/k--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
