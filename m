Subject: Re: fuse and selinux don't seem to work well together
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: merlin <merlin@countercultured.net>, Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <AANLkTin16BrQyNYAfbU95=0c3_R9uzPqqiORDz-Nrvu8@mail.gmail.com>
References: <AANLkTinTLamY+tesxS3W7ocnQCmEDCFhGT973jttYk_z@mail.gmail.com>
	 <1279909967.8180.43.camel@moss-terrapins.epoch.ncsc.mil>
	 <AANLkTiniFb1LjDJQRoc7zOVgD0FVXi=gBaxjusP36RZ3@mail.gmail.com>
	 <1279913697.32473.8.camel@moss-pluto.epoch.ncsc.mil>
	 <AANLkTi=CwucVcfRWN5Uk5=5HbVZRtuwVC6zW_w=_UEyH@mail.gmail.com>
	 <AANLkTimNxi1bOPQU1jrC6H--sCdX4Cm0PuNJZa4hNkwv@mail.gmail.com>
	 <4C4D0310.5040703@countercultured.net>
	 <AANLkTin16BrQyNYAfbU95=0c3_R9uzPqqiORDz-Nrvu8@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Jul 2010 15:22:15 -0400
Message-Id: <1280172135.2673.30.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok so looking through the code briefly this is what happens with respect
to the fstype for fuse. In the user space mount programs for fuse it
handles all of the parsing of the source string to grab the fuse fs type
out of it. It then crafts an FS type fuse.<subname> which is sent to the
kernel. The creation of the daemon to handle the requests is done in
user space and then it calls open on /dev/fuse. This grabs a new file
descriptor which the kernel uses as its communications channel to the
user space library and this FD is passed with the mount command.

Now here is where my understanding gets a little foggy but hopefully it
will help. Looking at the file_system_type structure for the fuse fs
type it has a flag called FS_HAS_SUBTYPE. Looking closely do_kern_mount
does two things to the fs_type string. First it will call get_fs_type
which pulls off the subtype leaving the base type. This is passed into
vfs_kernel_mount to be processed. After it calls vfs_kern_mount it then
checks if fs_flags has FS_HAS_SUBTYPE set and if it does calls
fs_set_subtype. This strips the first part of the name off and sets the
s_subtype field in the superblock. When the name finally arrives at
selinux_set_mnt_opts the file system name is fuse. This gets passed into
security_fs_use at some point to determine the labeling type for the
file system and grabs the entry in the policy db for fuse and uses that.
So having the fuse code call security_set_mnt_opts earlier isn't a good
idea. 

Now if you want to attempt to use the subtype in a fsuse statement we
need to set the subtype before calling vfs_kern_mount. I'm not sure if
this is allowed so something else might have to be done instead. I hope
this clears some things up for you.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
