Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA02835
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 14:45:35 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA27447
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 19:43:31 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id TAA27443 for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 19:43:31 GMT
Message-Id: <200211291952.OAA23878@moss-shockers.ncsc.mil>
Date: Fri, 29 Nov 2002 14:52:49 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: 2.4.20
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri 29 Nov 2002, Russell Coker wrote:
 
> However there is a problem that I suspect to be a bug in the 2.4.20 kernel.  
> It seems to allow a file handle for the root directory of the initrd to be 
> inherited to all processes.
> 
> I've attached a log of the avc messages.

Yes, this appears to be an oversight.  Notice that 2.5 correctly closes
the file descriptors (old_fd, root_fd) in handle_initrd():

http://linus.bkbits.net:8080/linux-2.5/diffs/init/do_mounts.c@1.23?nav=index.htm
l|src/.|src/init|hist/init/do_mounts.c

whereas 2.4 does not:

http://linux.bkbits.net:8080/linux-2.4/diffs/init/do_mounts.c@1.29?nav=index.htm
l|src/.|src/init|hist/init/do_mounts.c

Please report this omission to Al Viro.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
