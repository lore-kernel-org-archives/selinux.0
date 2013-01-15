Message-ID: <50F56457.5040904@tycho.nsa.gov>
Date: Tue, 15 Jan 2013 09:14:47 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: =?GB2312?B?tq3u2g==?= <dywisdomno1@gmail.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Subject: Re: Security label of file in Yaffs2 on Android
References: <CAPG=pduMTUpeY+Goikvh6nOAtcAvxn4h1Ai36H0ihwqfCHs9Eg@mail.gmail.com> <50F407C7.5020402@tycho.nsa.gov> <CAPG=pdsAfAFBDakun1JTMOmbNbwdNAFX+=CNGTTVkXJvuAPqGg@mail.gmail.com> <CAPG=pdvVT4fAees1q2FsXafnBrsD8-y3dePbM_OMLAdC==r+nA@mail.gmail.com> <CAPG=pdvW9n4oAwankdawNo1u_duQQH=BM0cNNuEhC3Lm_phk+A@mail.gmail.com>
In-Reply-To: <CAPG=pdvW9n4oAwankdawNo1u_duQQH=BM0cNNuEhC3Lm_phk+A@mail.gmail.com>
Content-Type: text/plain; charset=GB2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/15/2013 04:52 AM, ¶­îÚ wrote:
> LOL,Too early to end the problem.
> My goal is to "attached every file and dir in android with a security 
> label".
> The files under /data can be setxattr and the change can last after the 
> reboot of the emulator now, but the change of setxattr to the files 
> under /system still can't last after the reboot of the emulator. That's 
> really weird. According to init.rc, both the /data and /system were 
> mounted in yaffs type. I can't figure out any difference between them to 
> cause this.
> ps:
> I modified init.rc to make /system mounted rw.

http://developer.android.com/tools/devices/emulator.html#diskimages

"The emulator does not permit renaming the temporary system image or
persisting it at device power-off."

This is presumably because system images aren't normally modified at
runtime, unlike the user data images.

To create a system image with security labels for SE Android, we
modified mkyaffs2image to create the image with the extended attributes
already set based on our external/sepolicy/file_contexts configuration,
which specifies a mapping from pathname regexes to security contexts.
It shouldn't be hard to generalize our code to support other xattrs.
Our changes to external/yaffs2 have been merged into AOSP.  We also did
the same thing for make_ext4fs (system/extras/ext4_utils), as ext4 is
used on modern devices.





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
