Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4OEt0Rb011069
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 10:55:00 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4OEqUB2029207
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 14:52:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4OEqTwi029204
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 14:52:29 GMT
Subject: Re: Bootup problems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <20040523181318.GA2104@jmh.mhn.de>
References: <20040523181318.GA2104@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1085410477.26446.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 May 2004 10:54:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-05-23 at 14:13, Thomas Bleher wrote:
> The attached dmesg (non-relevant lines before and after snipped) is the
> bootlog of a 2.6.6er-kernel on a SuSE 9.0 system. No initrd, no special
> modules (only sound as module, everything else compiled in).
> The system works fine afterwards, the filesystem is properly labeled.
> It just seems like it is the file labels are initialized to late.
> Anyone knows why this is happening or where I should look?

The sequence appears to be:
1) policy load is started (from /sbin/init, right?),
2) usb device is detected,
3) policy load completes,
4) security initialization of already created superblocks and inodes is
started (this was deferred until the policy was loaded),
5) kernel invokes hotplug due to device detection,
6) security state for hotplug inode has not yet been initialized, thus
it is still marked with unlabeled_t,
7) no domain transition occurs on hotplug execution due to lack of
proper file type, so hotplug runs in kernel_t, yielding a series of
denials,
8) some other inodes are also not yet initialized, so they also have
unlabeled_t,
9) security initialization of hda3 inodes completes, so hotplug and
other inodes now have the right security context (but the running
hotplug process is still in kernel_t),
10) various denials due to the fact that the filesystems have not yet
been mounted, so you are just accessing the empty mount point
directories that are left in file_t.

The interleaving of the device detection / hotplug execution and policy
load / inode initialization is not good; requires further investigation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
