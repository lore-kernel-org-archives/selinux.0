Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j12DOR53022016
	for <selinux@tycho.nsa.gov>; Wed, 2 Feb 2005 08:24:27 -0500 (EST)
Subject: Re: Latest diffs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 08:17:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-02 at 08:08, Stephen Smalley wrote:
> BTW, I think that putting the conditional rule in uses_shlib() is likely
> not what you want, as it means that if you allow execmod at all to
> texrel_shlib_t, you essentially allow it for all domains.  In practice,
> I think you will only want to allow it where needed, and especially not
> for daemon domains.  Hence, I would recommend removing it from
> uses_shlib() and instead add it selectively to domains that have a
> legitimate need, as has already been done for a few cases as well as the
> user domains.

Patch below committed.  We can add such conditional rules to individual
domain .te files as needed.  unconfined_t is already exempt.  daemon
domains should likely never have such permission.

Index: policy/macros/global_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/global_macros.te,v
retrieving revision 1.75
diff -u -r1.75 global_macros.te
--- policy/macros/global_macros.te	1 Feb 2005 18:39:52 -0000	1.75
+++ policy/macros/global_macros.te	2 Feb 2005 13:13:06 -0000
@@ -106,9 +106,6 @@
 allow $1 ld_so_t:lnk_file r_file_perms;
 allow $1 { texrel_shlib_t shlib_t }:file rx_file_perms;
 allow $1 { texrel_shlib_t shlib_t }:lnk_file r_file_perms;
-if (allow_execmod) {
-allow $1 texrel_shlib_t:file execmod;
-}
 allow $1 ld_so_cache_t:file r_file_perms;
 allow $1 device_t:dir search;
 allow $1 null_device_t:chr_file rw_file_perms;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
