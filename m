Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA03001
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 15:03:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA28121
	for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 20:01:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id UAA28117 for <selinux@tycho.nsa.gov>; Fri, 29 Nov 2002 20:01:06 GMT
Message-Id: <200211292010.PAA23902@moss-shockers.ncsc.mil>
Date: Fri, 29 Nov 2002 15:10:23 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: executing a sock_file
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Nov 28 15:50:18 lyta kernel: avc:  denied  { execute } for  pid=4084 
> exe=/usr/lib/openoffice/program/soffice.bin 
> path=/tmp/OSL_PIPE_1001_SingleOfficeIPC_-383479802 dev=03:02 ino=900 
> scontext=rjc:user_r:user_t tcontext=rjc:object_r:user_tmp_t tclass=sock_file
> 
> What does it mean by executing a sock_file?
> 
> Star Office seems to run OK anyway...

Can you reproduce this denial reliably?  For normal file execution, the
base kernel should deny attempts to execute any non-regular file before
LSM/SELinux is ever invoked.  Possibly a check on a mmap, but that doesn't
make a lot of sense to me either for a sock file.   

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
