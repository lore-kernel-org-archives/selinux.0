Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j59I1qgA012491
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 14:01:52 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j59HrxFL007416
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 17:54:00 GMT
Subject: Re: [uml-devel] 2.6.12-rc6-mm1 patches testing
From: antoine <antoine@nagafix.co.uk>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <200506091920.34246.blaisorblade@yahoo.it>
References: <1118280325.10107.124.camel@localhost>
	 <200506091724.50908.blaisorblade@yahoo.it>
	 <1118332604.10190.58.camel@localhost>
	 <200506091920.34246.blaisorblade@yahoo.it>
Content-Type: text/plain
Date: Thu, 09 Jun 2005 19:04:38 +0100
Message-Id: <1118340278.10190.112.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> UML needs simply to mmap (PROT_EXEC) datas from the /tmp/vm_XXXXXX file to 
> work, and so it tries doing this very early, to give the user a hint on what 
> happens. On a fs mounted noexec this is forbidden, so possibly it's forbidden 
> also by SELinux; however, it would be nicer if SELinux could simply allow 
> mmap()ing with PROT_EXEC without allowing file execution...; allowing mmap() 
> does not put a big hole inside protections while allowing file execution 
> does...means that if the user can supply a program to execute, that program 
> can be written to mmap() and execute code from /tmp, but at that point the 
> intruder could simply execute his code.

Can anyone answer this for us please?
I am trying to workaround this:
audit(1117846877.640:0): avc:  denied  { execute } for  pid=29031 comm=um-kernel path=/tmp/vm_file-NnIm5X (deleted) dev=md7 ino=3965039 scontext=root:sysadm_r:um_kernel_t tcontext=root:object_r:um_tmp_t tclass=file
Without giving uml execute access to its tmp directory.

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
