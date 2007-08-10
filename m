Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7AG5JfY017474
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 12:05:19 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7AG5I1t020461
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 16:05:18 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 00/16] Permit filesystem local caching [try #3]
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
        selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2007 17:04:55 +0100
Message-ID: <20070810160455.24698.30983.stgit@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



These patches add local caching for network filesystems such as NFS and AFS.

FS-Cache now runs fully asynchronously as required by Trond Myklebust for NFS.

--
Changes:
[try #3]:

 (*) Added missing file to CacheFiles patch.

 (*) Made new security functions return errors and pass actual return data via
     argument pointer.

 (*) Cleaned up NFS patch.

 (*) The 'fsc' flag must now be passed to NFS mount by the string options.

 (*) Split the NFS patch into three as requested by Trond.

[try #2]:

 (*) The CacheFiles module no longer accepts directory fds in its cull and
     inuse commands from cachefilesd.  Instead it uses the current working
     directory of the calling process as the basis for looking up the object.
     Corollary to this, fget_light() no longer needs to be exported.

--
A tarball of the patches is available at:

	http://people.redhat.com/~dhowells/fscache/patches/nfs+fscache-22.tar.bz2


To use this version of CacheFiles, the cachefilesd-0.9 is also required.  It
is available as an SRPM:

	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.9-1.fc7.src.rpm

Or as individual bits:

	http://people.redhat.com/~dhowells/fscache/cachefilesd-0.9.tar.bz2
	http://people.redhat.com/~dhowells/fscache/cachefilesd.fc
	http://people.redhat.com/~dhowells/fscache/cachefilesd.if
	http://people.redhat.com/~dhowells/fscache/cachefilesd.te
	http://people.redhat.com/~dhowells/fscache/cachefilesd.spec

The .fc, .if and .te files are for manipulating SELinux.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
