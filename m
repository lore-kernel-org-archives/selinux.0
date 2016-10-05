Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u95EOVC9001075
 for <selinux@tycho.nsa.gov>; Wed, 5 Oct 2016 10:24:31 -0400
Message-ID: <1475677444.6421.6.camel@btinternet.com>
Subject: Re: restorecon -r goes up the tree?
From: Richard Haines <richard_c_haines@btinternet.com>
To: Jason Zaman <jason@perfinion.com>, SELinux <selinux@tycho.nsa.gov>,
 dac.override@gmail.com
Date: Wed, 05 Oct 2016 15:24:04 +0100
In-Reply-To: <20161005072834.GA8208@meriadoc>
References: <20161005072834.GA8208@meriadoc>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2016-10-05 at 15:28 +0800, Jason Zaman wrote:
> Hey all,
> 
> There have been a few changes to restorecon just before RC1 and it
> appears to not stay in the dir it was pointed at anymore?
> 
> meriadoc ~ # mount | grep "/dev"
> udev on /dev type devtmpfs
> (rw,nosuid,relatime,seclabel,size=10240k,nr_inodes=1521608,mode=755)
> devpts on /dev/pts type devpts
> (rw,relatime,seclabel,gid=5,mode=620,ptmxmode=000)
> mqueue on /dev/mqueue type mqueue
> (rw,nosuid,nodev,noexec,relatime,seclabel)
> shm on /dev/shm type tmpfs (rw,nosuid,nodev,noexec,relatime,seclabel)
> 
> meriadoc ~ # restorecon -rv /dev/
> Warning no default label for /run/sm-notify.pid
> Warning no default label for /run/cgmanager/fs
> Warning no default label for /run/user/1000/dconf
> Warning no default label for /run/user/1000/dconf/user
> Warning no default label for /run/user/1000/gvfs
> Warning no default label for /run/lightdm.pid
> Warning no default label for /run/dbus.pid
> ^C
> 
> I'd already run restorecon so this output isnt as verbose as it was
> before (scrollback fell off). But the first time it was also going
> into
> /usr and /lib and many other places that are not /dev. /dev and /run
> are
> also separate mountpoints so its not just that its doing the entire
> rootfs or something cuz if that was the case it would stay in /dev.
> Also "/dev" vs "/dev/" makes no difference.

I can also see the problem and investigating. It appears it is in
the new selinux_restorecon(3) code regarding realpath conversion. This
code was lifted from Android.c and seems the same in latest Android.
Will send patch once resolved.
> 
> -- Jason
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
