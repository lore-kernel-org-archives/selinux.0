Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8FDPsLa012594
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 09:25:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8FDOELY011032
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 13:24:14 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8FDODsG011029
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2003 13:24:13 GMT
Subject: Re: booting selinux rh9
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jason <jna@vasco.com>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <200309152147.32147.jna@vasco.com>
References: <200309152147.32147.jna@vasco.com>
Content-Type: text/plain
Message-Id: <1063632346.13311.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Sep 2003 09:25:46 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-09-15 at 07:47, Jason wrote:
> However, once again, I cannot get past a certain problem, at login time after 
> rebooting, I try to login as root, and it says it cannot determine a security 
> context for me, and do I wish to specify one. I say y (which is default), I 
> type sysadm_r and type of sysadm_t (I also tried the user_r and user_t as 
> well), and it responds with invalid security context, and I try again.

This implies that the policy wasn't loaded or doesn't contain an entry
for root.

> So I reboot into selinux single mode, and this is ok, I check the the 
> selinuxfs has been mounted (of which it has) and all the directories seem to 
> be there.  As a note, my context at this point is kernel_t.

system_u:system_r:kernel_t or just 'kernel'?

> Does anyone know what I might have done wrong?
> I also believe that the initrd I created using the one supplied with the 
> patched differences in the download from nsa creates a valid linuxrc file of 
> which I have checked, but are you supposed to see the output of the initrd's 
> echo statements at boot time, because I dont? ( ie : echo Loading Policy)

You should see messages from the kernel like:
	VFS:  Mounted root (ext2 filesystem).
	security:  4 users, 5 roles, 274 types
	security:  30 classes, 13949 rules
	SELinux:  Completing initialization.
	SELinux:  Setting up existing superblocks.
	SELinux:  initialized (dev , type selinuxfs), uses genfs_contexts
	SELinux:  initialized (dev ram0, type ext2), uses xattr
	...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
