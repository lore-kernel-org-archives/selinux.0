Subject: Re: System console hangs on boot in enforced unless some
 permissions added (with 2.6.32-3).
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@udmvt.ru
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20100428160413.GN25652@ruber.office.udmvt.ru>
References: <20100228223834.GE3990@myhost.felk.cvut.cz>
	 <1267452601.601.3.camel@moss-pluto.epoch.ncsc.mil>
	 <20100301165602.GH3990@myhost.felk.cvut.cz>
	 <1267463356.601.26.camel@moss-pluto.epoch.ncsc.mil>
	 <20100428160413.GN25652@ruber.office.udmvt.ru>
Content-Type: text/plain
Date: Wed, 28 Apr 2010 15:32:37 -0400
Message-Id: <1272483157.6013.300.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-04-28 at 20:04 +0400, selinux@udmvt.ru wrote:
> Is it only me unable to run Debian's 2.6.32-3 kernel with SELinux in enforced mode,
> or is anyone else's system blocked by the devtmpfs compiled into the kernel? :)
> 
> Look, I have these strange messages in permissive mode:
> 	type=AVC msg=audit(1272355319.117:102): avc:  denied  { search } for  pid=1668 comm="getty" name="/" dev=devtmpfs ino=4 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> 	type=AVC msg=audit(1272355319.117:102): avc:  denied  { write } for  pid=1668 comm="getty" name="/" dev=devtmpfs ino=4 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> 	type=AVC msg=audit(1272355319.117:102): avc:  denied  { add_name } for  pid=1668 comm="getty" name="vcs2" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=dir
> 	type=AVC msg=audit(1272355319.117:102): avc:  denied  { create } for  pid=1668 comm="getty" name="vcs2" scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:tmpfs_t:s0 tclass=chr_file

Two problems:
- getty shouldn't be in kernel_t.  This means that you never
transitioned out of kernel_t to init_t upon executing /sbin/init.
Is /sbin/init labeled correctly?

- Your devtmpfs instance apparently wasn't labeled.  In Fedora, there is
a restorecon -R /dev that happens from rc.sysinit to fix up labels once
policy has loaded.

You might have fewer errors too if you use device_t rather than tmpfs_t
as the default in your fs_use_trans statement.

> So, after all, now with my "fix" just everyone with mount privilege can do
>  # mount -t devtmpfs blablabla-no-device-is-needed /mountpoint
> to get directory full of device nodes with NO proper labelling?

Once it has been initially mounted and labeled, all subsequent mounts
should get the same instance - they don't create a new one each time.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
