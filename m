Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAA2cDIi027314
	for <selinux@tycho.nsa.gov>; Tue, 9 Nov 2004 21:38:13 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAA2aoxp000295
	for <selinux@tycho.nsa.gov>; Wed, 10 Nov 2004 02:36:50 GMT
Subject: Re: patch: misc policy additions
From: Colin Walters <walters@verbum.org>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041109210447.GC2543@jmh.mhn.de>
References: <20041109210447.GC2543@jmh.mhn.de>
Content-Type: text/plain
Date: Tue, 09 Nov 2004 19:29:10 -0500
Message-Id: <1100046550.26388.8.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-09 at 22:04 +0100, Thomas Bleher wrote:

+ifdef(`distro_suse', `
+# because of libraries in /var/lib/samba/bin
+allow ldconfig_t { var_lib_t bin_t }:dir search;
+allow ldconfig_t var_lib_t:lnk_file read;

I know this is under distro_suse, but wouldn't it be better to label
these files as lib_t, and have that be ifdef(`distro_suse') in the
samba.fc?

-# read /proc/meminfo, /proc/self/mounts and /etc/mtab
-allow nrpe_t { self proc_t etc_runtime_t }:file { getattr read };
+# read /proc/meminfo, /proc/self/mounts, /etc/localtime and /etc/mtab
+allow nrpe_t { self proc_t etc_runtime_t locale_t }:file { getattr read };

The convention here seems to be: read_locale(nrpe_t)  That does allow
one to turn off reading of locale files in a centralized place.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
