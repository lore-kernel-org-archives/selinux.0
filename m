Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>, SELinux@tycho.nsa.gov
Subject: Re: Generic SELinux Package
Date: Thu, 18 Apr 2002 19:20:52 +0200
Cc: "'sds@tislabs.com'" <sds@tislabs.com>,
        "'hdholm@epoch.ncsc.mil'" <hdholm@epoch.ncsc.mil>
References: <72222DC86846D411ABD300A0C9EB08A10152434C@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152434C@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020418172054.1ADDB28606@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 18 Apr 2002 18:42, Westerman, Mark wrote:
> Apr 18 10:46:07 localhost kernel: ds: no socket drivers loaded!
> Apr 18 10:46:07 localhost kernel: RAMDISK: Compressed image found at block
> 0 Apr 18 10:46:07 localhost kernel: Freeing initrd memory: 445k freed Apr

The initrd image is initially loaded into a particular memory location by the 
boot loader (lilo, grub, etc), and the kernel image is loaded into another 
location.

When the data is loaded the boot loaded starts execution of the kernel code 
which gzip decompresses the kernel image, switches to protected mode, and 
starts running real kernel code.

The real kernel code knows where to find the initrd, it will then allocate 
some memoryfor a real ram disk, and copy (or gzip decompress) the initrd into 
the ram disk and then free the initrd.

On my system I have a gzip compressed initrd, the ram disk is 3.6M but the 
initrd image is only 1.1M.

> 18 10:46:07 localhost kernel: VFS: Mounted root (ext2 filesystem). Apr 18
> 10:46:07 localhost kernel: security:  starting up (compiled Apr 18 2002)
> Apr 18 10:46:07 localhost kernel: security:  loading policy configuration
> from /ss_policy
> Apr 18 10:46:07 localhost kernel: security:  5 users, 5 roles, 406 types
> Apr 18 10:46:07 localhost kernel: security:  29 classes, 43869 rules
>
>
> The ram disk must have the /ss_policy to boot. The question I am not
> understanding
> from the log messages. I see the RAMDISK freed and the root filesystem
> mounted
> then security loads the /ss_policy. Which policy is the selinux really
> using ?
> in an off line mail conversion with Stephen Smalley he stated the ramdisk
> is the
> one. The question is why ?

The policy is loaded after root is mounted because it's loaded from the 
second last line of mount_root(), but that's only half-way through the 
change_root() function which moves the initrd to /initrd and makes the new 
root file system mounted on the root.

It probably wouldn't be that difficult to make mount_root() not load the 
policy when an initrd is being used and to then have change_root() do it 
later.  In fact it seems to easy that I might have a hack at it later tonight 
(although maybe Steve knows of something that'll make this extremely 
difficult and painful).


That said, it shouldn't be that difficult to have a mini-policy on the initrd 
which is used to keep the system going until after init has been run, so init 
can then run load_policy.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
