Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1G7VdL9014128
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 02:31:40 -0500 (EST)
Received: from mcfeely.r00td0wn.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1G7UQfs000716
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 07:30:26 GMT
Message-ID: <4212F68B.2010509@diyab.net>
Date: Wed, 16 Feb 2005 02:30:19 -0500
From: Timothy Wood <timothy@diyab.net>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Bootup problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Do you ever look further into this issue Stephen?  The reason I ask is
that I'm still seeing it on the current kernel.

Timothy,

| On Sun, 2004-05-23 at 14:13, Thomas Bleher wrote:
|> The attached dmesg (non-relevant lines before and after snipped) is the
|> bootlog of a 2.6.6er-kernel on a SuSE 9.0 system. No initrd, no special
|> modules (only sound as module, everything else compiled in).
|> The system works fine afterwards, the filesystem is properly labeled.
|> It just seems like it is the file labels are initialized to late.
|> Anyone knows why this is happening or where I should look?
|
| The sequence appears to be:
| 1) policy load is started (from /sbin/init, right?),
| 2) usb device is detected,
| 3) policy load completes,
| 4) security initialization of already created superblocks and inodes is
| started (this was deferred until the policy was loaded),
| 5) kernel invokes hotplug due to device detection,
| 6) security state for hotplug inode has not yet been initialized, thus
| it is still marked with unlabeled_t,
| 7) no domain transition occurs on hotplug execution due to lack of
| proper file type, so hotplug runs in kernel_t, yielding a series of
| denials,
| 8) some other inodes are also not yet initialized, so they also have
| unlabeled_t,
| 9) security initialization of hda3 inodes completes, so hotplug and
| other inodes now have the right security context (but the running
| hotplug process is still in kernel_t),
| 10) various denials due to the fact that the filesystems have not yet
| been mounted, so you are just accessing the empty mount point
| directories that are left in file_t.
|
| The interleaving of the device detection / hotplug execution and policy
| load / inode initialization is not good; requires further investigation.
|
| --
| Stephen Smalley <sds@epoch.ncsc.mil>
| National Security Agency

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCEvaLPT0XLCkCs2ARAu3qAJ9Ldo1z2goPr7cCntUIOzJlizJ41ACfciAO
enBPFxF31kF0NzE3LlamXVU=
=oBiX
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
