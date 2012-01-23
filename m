From: "Daniel P. Berrange" <berrange@redhat.com>
To: SELinux@tycho.nsa.gov
Subject: [PATCH 00/11] Two bug fixes & misc code cleanup fixes
Date: Mon, 23 Jan 2012 15:41:10 +0000
Message-Id: <1327333281-4223-1-git-send-email-berrange@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I was looking at the libselinux code and noticed that it did not
use much more besides '-Wall' for its default compilation flags.
As an experiment to see if there were any lurking bugs, I modified
the Makefile for libselinux to add about 30 other GCC supported
warnings.  This patch series is the result. I found 2 real bugs,
one potential use of unitialized variable in an OOM scenario,
and the other a (benign) format string mistake that meant the
user would not be told which flag was invalid.

At the same time I fixed const-correctness in several internal
and public APIs, added more printf format validation annotations,
removed old style function declarations & removed some dead
code.

One warning item that I didn't tackle here is to reduce the maximum
stack usage. With the -Wframe-larger-than flag I had to set the
libselinux stack size to 32kb, which is getting very excessive
IMHO. Most of the excessive stack usage is due to many PATH_MAX
declarations, the remainders due to a couple of large structs
placed on the stack. All of these are probably better off in
the heap long term

Hopefully the first 9 patches are fairly easily accepted. I did
not know what todo about the last 2 patches which actually add
the extra CFLAGS warnings. In most projects I would have imported
GNULIBs m4 macros for detecting support of compiler flags, but
since none of the selinux libraries use autoconf, I don't see a
good way/place to detect what compiler flags can be used.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
