Subject: Re: fuse and selinux don't seem to work well together
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 23 Jul 2010 13:46:34 -0400
Message-Id: <1279907194.8180.40.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-07-23 at 12:14 -0500, Xavier Toth wrote:
> I'm looking at building a fuse filesystem for polyinstantiated
> directories which could be used as a alternative to pam_namespace.
> I've noticed that my filesystem is never queried for the xattr
> security.selinux and that the file contexts are defaulting to a fuse
> file type. I've seen some list posting from 2004 related to this
> subject but not much else. Is this a bug or a feature?
> 
> Ted
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

Since I'm unclear about the internals of fuse this might be a completely
wrong idea but another thing that could be tried is having mount take
the filesystem name from the fuse mount command (looks like its at the
beginning of the device portion of the fstab entry) and have SELinux
query the policy for that fs name and do labeling based on that. One
issue I can see with this is if fuse shares a single superblock for all
of the fuse mounts inside the kernel and relies on the userspace
component to actually do the separation of the requests this could be a
problem.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
