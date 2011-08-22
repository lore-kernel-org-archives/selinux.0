Subject: Re: libselinux mountpoint changing patch.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Lennart Poettering
 <lennart@poettering.net>
In-Reply-To: <4E529754.6090402@redhat.com>
References: <4DC01640.9000206@redhat.com>
	 <1304436800.1587.20.camel@moss-pluto>
	 <CACLa4psD13cYBwzd0qQCa6Dh5JtAe3pdhbCSxROq85uXpyx9zw@mail.gmail.com>
	 <1314034402.14217.119.camel@moss-pluto>  <4E529754.6090402@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Aug 2011 14:45:22 -0400
Message-ID: <1314038722.14217.132.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-08-22 at 13:52 -0400, Eric Paris wrote:
> On 08/22/2011 01:33 PM, Stephen Smalley wrote:
> > On Mon, 2011-08-22 at 13:26 -0400, Eric Paris wrote:
> >> On Tue, May 3, 2011 at 11:33 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>> On Tue, 2011-05-03 at 10:50 -0400, Daniel J Walsh wrote:
> >>
> >>>> NOTE:  We added the check for RO, to allow tools like mock to be able to
> >>>> tell a chroot that SELinux is disabled while enforcing it outside the
> >>>> chroot.
> >>>>
> >>>>
> >>>> # getenforce
> >>>> Enabled
> >>>> # mount -t selinuxfs -o remount,ro selinuxfs /var/chroot/selinux
> >>>
> >>> Just to clarify, the right commands to use are:
> >>> mount --bind /selinux /var/chroot/selinux
> >>> mount -o remount,ro /var/chroot/selinux
> >>>
> >>> Do not use:
> >>> mount -t selinuxfs -o ro selinuxfs /var/chroot/selinux
> >>> as this will in fact change the flags on /selinux as well.  Surprise!
> >>> Result of there only being a single instance (superblock) of selinuxfs,
> >>> although you can have multiple vfsmounts of it.
> >>
> >> surprise, this doesn't work either!
> >> # cat mount.F16 | grep selinux
> >> mount --bind /selinux /mnt/F16/sys/fs/selinux/
> >> mount -o remount,ro /mnt/F16/sys/fs/selinux/
> >>
> >> # cat /proc/mounts | grep selinux
> >> selinuxfs /selinux selinuxfs ro,relatime 0 0
> >> selinuxfs /mnt/F16/sys/fs/selinux selinuxfs ro,relatime 0 0
> >>
> >> crap.
> > 
> > Hmmm...works for me on F14 (yeah, I know - ancient history).
> > 
> > # mkdir -p /var/chroot/selinux
> > # mount --bind /selinux /var/chroot/selinux
> > # mount -o remount,ro /var/chroot/selinux
> > # cat /proc/mounts | grep selinux
> > none /selinux selinuxfs rw,relatime 0 0
> > none /var/chroot/selinux selinuxfs ro,relatime 0 0
> > # echo 0 > /selinux/enforce
> > # echo 0 > /var/chroot/selinux/enforce 
> > bash: /var/chroot/selinux/enforce: Read-only file system
> > 
> > Did something change recently in the kernel or mount?
> 
> mount(8)
> 
> under F15 mount does:
> mount("selinuxfs", "/mnt/F16/sys/fs/selinux", 0x7f613d1ce7b0,
> MS_RDONLY|MS_REMOUNT|MS_RELATIME, NULL) = 0
> 
> whereas under F14 mount does:
> mount("/sleinux", "/var/chroot/selinux", 0x7ff5f154ea69,
> NS_MGC_VAL|MS_RDONLY|MS_REMOUNT|MS_BIND, NULL) = 0
> 
> under F15 I can get it to work if I use the command:
> 
> mount -o remount,ro,bind /var/chroot/selinux
> 
> now for me to hunt down who owns mount(8)

Does F15 and later have /etc/mtab?  The man page for mount(8) on F14
says that you have to explicitly pass bind on the remount if you lack
an /etc/mtab on your system, as mount(8) figures out whether or not it
was a bind mount originally from the /etc/mtab entry.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
