Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16F9mRb023072
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 10:09:49 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i16F9lOi000255
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 15:09:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i16F9lWW000252 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 15:09:47 GMT
Subject: Re: Issues relabeling filesystems
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Ignacio Tripodi <ignaciot@unt.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BEA0F082-5867-11D8-A76A-000393013D1A@unt.edu>
References: <BEA0F082-5867-11D8-A76A-000393013D1A@unt.edu>
Content-Type: text/plain
Message-Id: <1076080186.16170.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 06 Feb 2004 10:09:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-06 at 00:46, Ignacio Tripodi wrote:
> I'm running SELinux on User Mode Linux, on a Fedora Core 1 root 
> filesystem I built. When trying to label the filesystem, I encountered 
> this problem:
> 
> [root@umlSELinux policy]# make relabel
> /usr/sbin/setfiles file_contexts/file_contexts `mount | awk 
> '/ext[23].*rw/{print $3}'`
> /usr/sbin/setfiles:  read 419 specifications
> /usr/sbin/setfiles:  labeling files under /
> /usr/sbin/setfiles: relocation error: /usr/sbin/setfiles: symbol 
> nftw64, version GLIBC_2.3.3 not defined in file libc.so.6 with link 
> time reference
> make: *** [relabel] Error 127
> 
> I actually included glibc-2.3.2 when I built the root-filesystem, as 
> well as glibc-common-2.3.2, glibc-debug-2.3.2, glibc-devel-2.3.2, 
> glibc-headers-2.3.2, etc. Any clues of what this error means will be 
> highly appreciated.
> Thanks!

If you want to use the setfiles from Fedora Core development, then you
need to upgrade your glibc.  You could just build our setfiles,
preferably from the sourceforge CVS tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
