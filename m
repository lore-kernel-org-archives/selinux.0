Message-ID: <1475682490.7709.1.camel@btinternet.com>
Subject: Re: restorecon -r goes up the tree?
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Jason Zaman <jason@perfinion.com>, SELinux <selinux@tycho.nsa.gov>,
 dac.override@gmail.com
Date: Wed, 05 Oct 2016 16:48:10 +0100
In-Reply-To: <c6c6edc8-8da4-7739-2960-31a478579501@tycho.nsa.gov>
References: <20161005072834.GA8208@meriadoc>
 <1475677444.6421.6.camel@btinternet.com>
 <c6c6edc8-8da4-7739-2960-31a478579501@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2016-10-05 at 10:36 -0400, Stephen Smalley wrote:
> On 10/05/2016 10:24 AM, Richard Haines wrote:
> > 
> > On Wed, 2016-10-05 at 15:28 +0800, Jason Zaman wrote:
> > > 
> > > Hey all,
> > > 
> > > There have been a few changes to restorecon just before RC1 and
> > > it
> > > appears to not stay in the dir it was pointed at anymore?
> > > 
> > > meriadoc ~ # mount | grep "/dev"
> > > udev on /dev type devtmpfs
> > > (rw,nosuid,relatime,seclabel,size=10240k,nr_inodes=1521608,mode=7
> > > 55)
> > > devpts on /dev/pts type devpts
> > > (rw,relatime,seclabel,gid=5,mode=620,ptmxmode=000)
> > > mqueue on /dev/mqueue type mqueue
> > > (rw,nosuid,nodev,noexec,relatime,seclabel)
> > > shm on /dev/shm type tmpfs
> > > (rw,nosuid,nodev,noexec,relatime,seclabel)
> > > 
> > > meriadoc ~ # restorecon -rv /dev/
> > > Warning no default label for /run/sm-notify.pid
> > > Warning no default label for /run/cgmanager/fs
> > > Warning no default label for /run/user/1000/dconf
> > > Warning no default label for /run/user/1000/dconf/user
> > > Warning no default label for /run/user/1000/gvfs
> > > Warning no default label for /run/lightdm.pid
> > > Warning no default label for /run/dbus.pid
> > > ^C
> > > 
> > > I'd already run restorecon so this output isnt as verbose as it
> > > was
> > > before (scrollback fell off). But the first time it was also
> > > going
> > > into
> > > /usr and /lib and many other places that are not /dev. /dev and
> > > /run
> > > are
> > > also separate mountpoints so its not just that its doing the
> > > entire
> > > rootfs or something cuz if that was the case it would stay in
> > > /dev.
> > > Also "/dev" vs "/dev/" makes no difference.
> > 
> > I can also see the problem and investigating. It appears it is in
> > the new selinux_restorecon(3) code regarding realpath conversion.
> > This
> > code was lifted from Android.c and seems the same in latest
> > Android.
> > Will send patch once resolved.
> 
> It is a difference between glibc and bionic behaviors for dirname()
> and
> basename().  They can modify their argument under POSIX.  You cannot
> pass pathname_orig to them.  You would have gotten compiler warnings
> with the Android code, but apparently silenced those with (char *)
> casts.
> 
Your patch fixes this problem - thanks
> 
> 
