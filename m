Subject: Re: libselinux mountpoint changing patch.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        Lennart Poettering <lennart@poettering.net>
In-Reply-To: <CACLa4psD13cYBwzd0qQCa6Dh5JtAe3pdhbCSxROq85uXpyx9zw@mail.gmail.com>
References: <4DC01640.9000206@redhat.com>
	 <1304436800.1587.20.camel@moss-pluto>
	 <CACLa4psD13cYBwzd0qQCa6Dh5JtAe3pdhbCSxROq85uXpyx9zw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 22 Aug 2011 13:33:22 -0400
Message-ID: <1314034402.14217.119.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-08-22 at 13:26 -0400, Eric Paris wrote:
> On Tue, May 3, 2011 at 11:33 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Tue, 2011-05-03 at 10:50 -0400, Daniel J Walsh wrote:
> 
> >> NOTE:  We added the check for RO, to allow tools like mock to be able to
> >> tell a chroot that SELinux is disabled while enforcing it outside the
> >> chroot.
> >>
> >>
> >> # getenforce
> >> Enabled
> >> # mount -t selinuxfs -o remount,ro selinuxfs /var/chroot/selinux
> >
> > Just to clarify, the right commands to use are:
> > mount --bind /selinux /var/chroot/selinux
> > mount -o remount,ro /var/chroot/selinux
> >
> > Do not use:
> > mount -t selinuxfs -o ro selinuxfs /var/chroot/selinux
> > as this will in fact change the flags on /selinux as well.  Surprise!
> > Result of there only being a single instance (superblock) of selinuxfs,
> > although you can have multiple vfsmounts of it.
> 
> surprise, this doesn't work either!
> # cat mount.F16 | grep selinux
> mount --bind /selinux /mnt/F16/sys/fs/selinux/
> mount -o remount,ro /mnt/F16/sys/fs/selinux/
> 
> # cat /proc/mounts | grep selinux
> selinuxfs /selinux selinuxfs ro,relatime 0 0
> selinuxfs /mnt/F16/sys/fs/selinux selinuxfs ro,relatime 0 0
> 
> crap.

Hmmm...works for me on F14 (yeah, I know - ancient history).

# mkdir -p /var/chroot/selinux
# mount --bind /selinux /var/chroot/selinux
# mount -o remount,ro /var/chroot/selinux
# cat /proc/mounts | grep selinux
none /selinux selinuxfs rw,relatime 0 0
none /var/chroot/selinux selinuxfs ro,relatime 0 0
# echo 0 > /selinux/enforce
# echo 0 > /var/chroot/selinux/enforce 
bash: /var/chroot/selinux/enforce: Read-only file system

Did something change recently in the kernel or mount?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
