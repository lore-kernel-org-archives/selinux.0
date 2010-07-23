Subject: Re: fuse and selinux don't seem to work well together
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 23 Jul 2010 13:35:51 -0400
Message-Id: <1279906551.8180.37.camel@moss-terrapins.epoch.ncsc.mil>
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

I think the first question here is what is the fs name when you mount a
fuse file system. We have an entry in policy that says fuse is genfscon
fuse / gen_context(system_u:object_r:fusefs_t,s0). If every fuse file
system appears to the kernel to be a fuse fs then you can't add a
genfscon statement to your particular FS telling it to use xattrs. This
might be a use for the native labeling file system code we've been
working on for labeled NFS.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
