Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j05GkIIi003181
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 11:46:18 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j05GiQFH009291
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 16:44:26 GMT
Subject: Re: policy
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200501030202.01321.russell@coker.com.au>
References: <200501030202.01321.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1104943711.1511.12.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 05 Jan 2005 11:48:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

This chunk is not needed because this rule occurs earlier in rpm's
policy.

--- /usr/src/se/policy/domains/program/unused/rpm.te    2004-11-21 21:51:14.000000000 +1100
+++ ./domains/program/unused/rpm.te     2004-11-22 03:14:43.000000000 +1100
@@ -66,6 +66,11 @@
 domain_auto_trans(rpm_script_t, cupsd_exec_t, cupsd_t)
 ')
 
+ifdef(`gpg.te', `
+# gpg wants this so it does not dump core on errors
+allow rpm_t self:process { setrlimit };
+')
+
 # for a bug in rm
 dontaudit initrc_t pidfile:file write;
 

On Sun, 2005-01-02 at 10:01, Russell Coker wrote:
> udev.diff just combines a couple of lines into a single line.
> 
> diff changes the Makefile to have it not run setfiles -q needlessly (good for 
> when a script runs "make install" a few hundred times).
> 
> Adds a couple of lines to assert.te.
> 
> Adds hide_broken_symptoms to ldconfig.te (there is no good cause for 
> ldconfig_t to access a TCP socket).
> 
> Changes ftpd.te to allow access to home_root_t for the case of NFS root.  This 
> means that if you have home directories individually mounted on /home/user 
> then things will still work (and there's no harm in granting such access).
> 
> Added some extra access that seems to be needed by the latest version of howl.
> 
> Removed the memory_device_t commend from xdm.te - we should not need to 
> re-enable that.
> 
> Removed redundant entries from types.fc relating to the old locations 
> before /etc/selinux was used.
> 
> Add support for the Debian locations for pmap_dump and pmap_set.  I wonder 
> whether those files will have to change locations in other distributions for 
> the case of /usr on NFS...
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
