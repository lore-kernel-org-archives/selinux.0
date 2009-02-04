Subject: Re: Security context of symbolic links on ubifs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tim <timasyk@gmail.com>
Cc: SELinux mailing list <SELinux@tycho.nsa.gov>
In-Reply-To: <a5e2b64d0902031638vc33883en849830af3f33064b@mail.gmail.com>
References: <a5e2b64d0902021515q18b61935q829abc2bc1772a7e@mail.gmail.com>
	 <1233670196.14235.16.camel@localhost.localdomain>
	 <a5e2b64d0902031638vc33883en849830af3f33064b@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 09:00:37 -0500
Message-Id: <1233756037.30244.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-02-04 at 09:38 +0900, Tim wrote:
> 2009/2/3 Stephen Smalley <sds@tycho.nsa.gov>:
> > On Tue, 2009-02-03 at 08:15 +0900, Tim wrote:
> >> Hello!
> >>
> >> For an embedded project I'm trying to set security context of symbolic
> >> links located on ubifs to files located on ubifs as well.
> >> The result is as following:
> >> - after setting security context using setfiles or restorecon for
> >> links, ls -Z reports correct links labeling;
> >> - after rebooting computer I see that ALL symbolic links got default
> >> label for files for that filesystem (which is incorrect);
> >> Security context labeling for normal files/directories/devices works
> >> just fine and can survive reboot.
> >> I've tried same security context labels for link and linked file,
> >> different security contexts for link and linked file - results are the
> >> same as described.
> >> Any ideas why this is happening?
> >
> > ubifs doesn't appear to implement complete support for security
> > attributes.  It does not define .getxattr and .setxattr operations for
> > symlinks (ubifs_symlink_inode_operations).  Also, it doesn't appear to
> > call security_inode_init_security() and set an attribute when allocating
> > new inodes (ubifs_new_inode), so it won't automatically label new files
> > that are created at runtime.
> >
> > You also need to configure your policy to tell SELinux that the
> > filesystem supports security attributes via fs_use_xattr statements.
> > But that won't be sufficient without further code modifications to
> > ubifs.
> >
> > --
> > Stephen Smalley
> > National Security Agency
> 
> Thank you very much for explanation.
> 
> I already use fs_use_xattr for ubifs. And yes, all files created on
> run-time receive default file security context. I will look forward
> for patches for ubifs for full xattr support (if any).

That would be more likely if you raised the issue with the ubifs
developers (or even better, submitted patches for it yourself to them).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
