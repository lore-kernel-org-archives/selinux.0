Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2AFuXZ004286
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 05:15:56 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2AEY4G027584
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 10:14:35 GMT
Date: Tue, 2 Nov 2004 10:26:47 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jaspreet Singh <jsingh@ensim.com>
Cc: nsa <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Configuring kernel module for labeling ...
Message-ID: <20041102102647.GV9643@lkcl.net>
References: <1099385154.11681.3.camel@jsingh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1099385154.11681.3.camel@jsingh>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, Nov 02, 2004 at 02:15:55PM +0530, Jaspreet Singh wrote:
> Hi,
> 
> could anybody explain me the following msg ...

 in a roundabout way that i _hope_ will demonstrate a methodolgy and
 guess-work that will enhance your own ability to track these issues
 down, yes, i think so.

 [i had to go through the same process with adding fuse, but had help
 from stephen in the fs_use bit iirc]

> SELinux: initialized (dev overlay_fs, type overlay_fs), not configured
> for labeling
 
 okay, grep "not configured for label" in security/*/*.c, gives
 selinux/hooks.c an array of labeling behaviours - entry with index 4 is
 "not configured for labeling".

 sbsec->behaviour indexes that array (line 593) and looking at locations
 where it's used, you have #defines SECURITY_FS_USE_XATTR -->
 SECURITY_FS_USE_MNTPOINT in selinux/include/security.h

 i think i know where this is leading, especially with the
 Opt_defcontent and stuff.

 okay, jaspreet: did you add overlay_fs to /etc/selinux/src/fs_use?

 because i _think_ the fs_use file contains wordy versions of the
 SECURITY_FS_USE #defines.

 and the default is "not configured".

 so you will need to specify, in /etc/selinux/src/fs_use, a line
 fs_use_xattr overlay system_u:object_r:fs_t;

 [just like i had to do with fuse].

 the name (overlay) MUST match the name of your module in your overlay
 kernel source code.

 l.

-- 
--
you don't have to BE MAD   | this space    | my brother wanted to join mensa,
  to work, but   IT HELPS  |   for rent    | for an ego trip - and get kicked 
 you feel better!  I AM    | can pay cash  | out for a even bigger one.
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
