Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1RAaODo019846
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 05:36:24 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1RAXHjS002678
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 10:33:17 GMT
Date: Sun, 27 Feb 2005 10:43:13 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: fedora-devel-list@redhat.com, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: writing zero bytes in bash
Message-ID: <20050227104313.GB28871@lkcl.net>
References: <200502261832.16337.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200502261832.16337.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

as an aside, which may be of indirect relevance: the bluetooth
specification for audio devices requires that data be read every
oh 9ms or so in order to determine that the device is still
active.

there's a #define in the linux kernel which specifically
mentions the words "bluetooth" "audio" "zero" and "bytes".

hopefully that's only in the kernel and not percolated up to
user land, esp. as it's been noted by others on the selinux
mailing list the posix requirements that no interface shall
provide or require a zero byte write.

On Sat, Feb 26, 2005 at 06:32:13PM +1100, Russell Coker wrote:
 
> [...]

> To unset the fscreate or exec context you have to write zero bytes 
> to /proc/self/attr/fscreate or /proc/self/attr/exec respectively.
> 
> If you want to do this in a shell script you would do something like:
> echo -n "" > /proc/self/attr/fscreate
> 
> However that shell command results in bash (both the version in rawhide and 
> the version in RHEL4) performing the following system calls:
> 
> open("/proc/self/attr/exec", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 3
> fcntl64(1, F_GETFD)                     = 0
> fcntl64(1, F_DUPFD, 10)                 = 10
> fcntl64(1, F_GETFD)                     = 0
> fcntl64(10, F_SETFD, FD_CLOEXEC)        = 0
> dup2(3, 1)                              = 1
> close(3)                                = 0
> dup2(10, 1)                             = 1
> fcntl64(10, F_GETFD)                    = 0x1 (flags FD_CLOEXEC)
> close(10)                               = 0
> 
> It opens the file with O_CREAT (so if you were to do `echo -n "" > /tmp/flag` 
> to create a flag file then it would work as expected), but never calls the 
> write(2) system call.
> 
> To unset the fscreate or exec context you have to call write(fd, X, 0) (the 
> value of X doesn't seem to matter as the kernel code doesn't dereference it).
> 
> It seems likely to me that there may be other bits of kernel code exporting an 
> interface under /proc where a write of 0 bytes may have a different meaning 
> to merely opening a file with write access and then closing it.

> [...]

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
