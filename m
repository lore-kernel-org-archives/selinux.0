Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3DIJjMd029087
	for <selinux@tycho.nsa.gov>; Sun, 13 Apr 2008 14:19:45 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3DIJd5A009741
	for <selinux@tycho.nsa.gov>; Sun, 13 Apr 2008 18:19:44 GMT
From: Jim Meyering <jim@meyering.net>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: =?utf-8?B?T25kxZllaiBWYcWhw61r?= <ovasik@redhat.com>
Subject: setfscreatecon-w/invalid-context can mistakenly succeed
References: <Pine.LNX.4.44.0803271805390.3341-100000@redline.boston.redhat.com>
Date: Sun, 13 Apr 2008 18:11:07 +0200
In-Reply-To: <Pine.LNX.4.44.0803271805390.3341-100000@redline.boston.redhat.com>
	(James Morris's message of "Thu, 27 Mar 2008 18:06:54 -0400 (EDT)")
Message-ID: <874pa5buqs.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

In preparing for an upstream coreutils release, I'm seeing intermittent
failures of its tests/mkdir/selinux test.  For a stand-alone demonstration,
run this on a rawhide system with SELinux in enforcing mode:

  while :;do mkdir d -Z xxx 2>/dev/null&&{t=X;rmdir d;}||t=.;printf $t;done

I see output like this:

X.............................................................................\
..............................................................................\
..............................................................................\
.......................XX.XXXXXXXX.XXXXXX.XXXXXXXX.XXXXXXX.XXXXXXX.XXXXX.XXXXX\
XXX.XXXXXXXX.XXXXXXXX.XXX.XXXXXXXX.XXXXXXX.XXXXX...X.X.XXXXXXXXX.XXXXXXXXXX.XX\
XXX.XXXXX.XXXXX.XXXXX.XXXXX.X.XXXX......XXX...................................\
.......................................X...X..................................\
..............................................................................\
..............................................................................\
..............................................................................\
..............................................................................\
...........................................................................X..\
.XX.................................

Each X represents a mkdir command that has mistakenly succeeded, which
includes a setfscreatecon call that is expected to fail due to the
invalid "xxx" context.  Normally it fails, corresponding to "."s above:

    $ mkdir d -Z xxx
    /bin/mkdir: failed to set default file creation context to `xxx': \
    Invalid argument
    [Exit 1]

FYI, a second run did this:

...........................................XXXXX.XX..XXX.XXXX..XXXXX.X........\
............XX.X.X.X.X........XXXXX...........................................\
..............................................................................\
..XX....XX....X...............................................................\
..................................XX.X.X.X.XXXX.X.X.XXXX.X.XXXXXX.X.X.X.XXXX.X\
.X.X.X.XXX.X.XX.X.X.XXXX.X.X.X.X.XXXXX.XXXXX.....XXX.XX.......................\
..................X...........................................................\
..............................................................................\
.......XXX...XX.X.X....XX.......XXXX.XX.......................................\
..............................................................................\
..............................................................................\
..............................................................................\
....................................

I compared strace output, but the differences are not very revealing.
In the offending case, writing a NUL byte to
/proc/self/task/18605/attr/fscreate succeeds, and in the usual
case, it fails like this:

    gettid()                                = 18605
    open("/proc/self/task/18605/attr/fscreate", O_RDWR) = 3
    write(3, "\0", 1)                       = -1 EINVAL (Invalid argument)

FYI, rpm -q says this:

    libselinux-2.0.61-1.fc9.x86_64
    kernel-2.6.25-0.218.rc8.git7.fc9.x86_64

I presume this needs a BZ, since there are currently none matching
setfscreatecon.  If so, should it be against libselinux, the kernel,
or something else?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
