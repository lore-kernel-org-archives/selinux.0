Subject: Re: setfscreatecon-w/invalid-context can mistakenly succeed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jim Meyering <jim@meyering.net>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        =?UTF-8?Q?Ond=C5=99ej_Va=C5=A1=C3=ADk?= <ovasik@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <874pa5buqs.fsf@rho.meyering.net>
References: 
	 <Pine.LNX.4.44.0803271805390.3341-100000@redline.boston.redhat.com>
	 <874pa5buqs.fsf@rho.meyering.net>
Content-Type: text/plain
Date: Mon, 14 Apr 2008 08:17:04 -0400
Message-Id: <1208175424.18883.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 2008-04-13 at 18:11 +0200, Jim Meyering wrote:
> Hello,
> 
> In preparing for an upstream coreutils release, I'm seeing intermittent
> failures of its tests/mkdir/selinux test.  For a stand-alone demonstration,
> run this on a rawhide system with SELinux in enforcing mode:
> 
>   while :;do mkdir d -Z xxx 2>/dev/null&&{t=X;rmdir d;}||t=.;printf $t;done
> 
> I see output like this:
> 
> X.............................................................................\
> ..............................................................................\
> ..............................................................................\
> .......................XX.XXXXXXXX.XXXXXX.XXXXXXXX.XXXXXXX.XXXXXXX.XXXXX.XXXXX\
> XXX.XXXXXXXX.XXXXXXXX.XXX.XXXXXXXX.XXXXXXX.XXXXX...X.X.XXXXXXXXX.XXXXXXXXXX.XX\
> XXX.XXXXX.XXXXX.XXXXX.XXXXX.X.XXXX......XXX...................................\
> .......................................X...X..................................\
> ..............................................................................\
> ..............................................................................\
> ..............................................................................\
> ..............................................................................\
> ...........................................................................X..\
> .XX.................................
> 
> Each X represents a mkdir command that has mistakenly succeeded, which
> includes a setfscreatecon call that is expected to fail due to the
> invalid "xxx" context.  Normally it fails, corresponding to "."s above:
> 
>     $ mkdir d -Z xxx
>     /bin/mkdir: failed to set default file creation context to `xxx': \
>     Invalid argument
>     [Exit 1]
> 
> FYI, a second run did this:
> 
> ...........................................XXXXX.XX..XXX.XXXX..XXXXX.X........\
> ............XX.X.X.X.X........XXXXX...........................................\
> ..............................................................................\
> ..XX....XX....X...............................................................\
> ..................................XX.X.X.X.XXXX.X.X.XXXX.X.XXXXXX.X.X.X.XXXX.X\
> .X.X.X.XXX.X.XX.X.X.XXXX.X.X.X.X.XXXXX.XXXXX.....XXX.XX.......................\
> ..................X...........................................................\
> ..............................................................................\
> .......XXX...XX.X.X....XX.......XXXX.XX.......................................\
> ..............................................................................\
> ..............................................................................\
> ..............................................................................\
> ....................................
> 
> I compared strace output, but the differences are not very revealing.
> In the offending case, writing a NUL byte to
> /proc/self/task/18605/attr/fscreate succeeds, and in the usual
> case, it fails like this:
> 
>     gettid()                                = 18605
>     open("/proc/self/task/18605/attr/fscreate", O_RDWR) = 3
>     write(3, "\0", 1)                       = -1 EINVAL (Invalid argument)
> 
> FYI, rpm -q says this:
> 
>     libselinux-2.0.61-1.fc9.x86_64
>     kernel-2.6.25-0.218.rc8.git7.fc9.x86_64
> 
> I presume this needs a BZ, since there are currently none matching
> setfscreatecon.  If so, should it be against libselinux, the kernel,
> or something else?

Sounds more like a bug in mcstrans to me - giving back an empty string
in place of the "xxx" so that the kernel never sees the "xxx"?  Or do I
misunderstand your description above.

However, I'm a little surprised by the EINVAL above as well from the
kernel, as the selinux_setprocattr handler in the kernel is written to
accept NULL, "\0", or "\n" as a way of clearing the attribute value
(resetting to policy default).  setfscreatecon(NULL) does the former for
use by programs, while echo -n "" > /proc/self/attr/fscreate does the
last one for use from scripts.  I'm wondering if we are running afoul of
some inconsistency in the proc code itself before we reach the selinux
code.  So possibly a kernel bug report would also make sense.  But the
mcstrans issue is more crucial, as we shouldn't be mapping an invalid
context to the empty string there.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
