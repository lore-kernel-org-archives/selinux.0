Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OHE9x6004102
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 12:14:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2OHAclY002017
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 17:10:38 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id h2OHAbKX002008
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 17:10:38 GMT
Date: Mon, 24 Mar 2003 12:13:43 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patches
In-Reply-To: <200303222314.01287.russell@coker.com.au>
Message-ID: <Pine.LNX.4.33.0303241207420.20487-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 22 Mar 2003, Russell Coker wrote:

> I've attached a patch for the passwd_t policy as previously described.
>

  Thanks for the patch. One comment:

+++ policy/domains/program/initrc.te    2003-03-22 22:12:15.000000000
+0100
@@ -173,10 +173,12 @@
 allow initrc_t ttyfile:chr_file relabelfrom;
 allow initrc_t tty_device_t:chr_file relabelto;

+ifdef(`rpm.te', `
 # Create and read /boot/kernel.h.
 # RedHat systems typically create this file at boot time.
 allow initrc_t boot_t:lnk_file r_file_perms;
 file_type_auto_trans(initrc_t, boot_t, boot_runtime_t)
+')

 # Delete and re-create /boot/System.map.
 allow initrc_t boot_t:dir { read getattr write remove_name add_name };
diff -ru /tmp/policy/domains/program/modutil.te
policy/domains/program/modutil.te


We can't use the presence of rpm.te to denote a RedHat system, and this
approach won't work for the core policy.

-- 
Wayne Salamon
wsalamon@tislabs.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
