Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA07854
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 11:10:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA13531
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 15:10:20 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA13527
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2001 15:10:20 GMT
Date: Tue, 10 Apr 2001 11:10:40 -0400 (EDT)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200104101510.LAA00386@coalstove.epoch.ncsc.mil>
To: aw096@chebucto.ns.ca
Subject: Re: build-apps trouble.
Cc: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I can't see what's going on from the description here.  If you could
you send me the complete build-apps.log privately, I'll take a look at
it.  I'm also not quite sure what you changed in the syscalls
Makefiles.  Was it the files in the dependencies sections of the file
(after # DO NOT DELETE THIS LINE)?


--
Howard Holm <hdholm@epoch.ncsc.mil>
Information Assurance Research Office
National Security Agency

> Date: 	Mon, 9 Apr 2001 23:50:01 -0300 (ADT)
> From: Joey Mitchell Comeau <aw096@chebucto.ns.ca>
> To: selinux@tycho.nsa.gov
> Subject: build-apps trouble.
> 
> Hi.
> 
> I'm working through the installation of selinux and the build-apps tool is
> quitting with 
> stat*: no match. 
> 
> I looked in utils and there are no directories that start with stat, only
> spasswd and newrole
> 
> Everything in build-apps.log looks like
> 
> -----------PASTE
> make[1]: Entering directory
> `/root/slinux/slinux/syscalls/unix_stream_client'
> gcc  -c -I../../include -I../../kernel/include unix_stream_client.c
> unix_stream_client.o be done...
> -----------/PASTE
> 
> Which I assume means a-ok.
> The following got printed to stderr when it was running,
> 
> -------------PASTE
> msgwrite.c: In function `main':
> msgwrite.c:103: warning: passing arg 2 of `msgsnd_secure' from
> incompatible pointer type
> ------------/PASTE
> 
> Has something gone wrong earlier in the process?
> 
> I am working with the support files tarball from the nsa page, 
> as well as the full tree for 2.2.18 from same page.
> 
> So far the only change I've had to make is substituting the redhat-gcs
> references for mandrake/2.95.2 references in the makefiles in syscalls
> 
> any help or pointers would be greatly appreciated.
> 
> joey

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
