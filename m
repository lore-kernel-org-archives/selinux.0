Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0U6jcRb017870
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 01:45:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0U6iKVK002252
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 06:44:20 GMT
Received: from ms1.nttdata.co.jp (ms1.nttdata.co.jp [163.135.193.232])
	by jazzswing.ncsc.mil  with ESMTP id i0U6iIlx002248
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 06:44:19 GMT
Received: from mail0.nttdata.co.jp ([163.135.10.20])
	by ms1.nttdata.co.jp (8.12.10/3.7W-NTTDATA-TOP-10/23/03) with ESMTP id i0U6jJJ7017358
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 15:45:19 +0900 (JST)
Received: from harpocrates.rd.nttdata.co.jp (localhost [127.0.0.1])
	by mail0.nttdata.co.jp (8.12.9/3.7W-NTTDATA-TOP-10/22/03) with SMTP id i0U6jHdg016635
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 15:45:17 +0900 (JST)
Received: from rd5.rd.nttdata.co.jp ([10.8.144.182])
 by harpocrates.rd.nttdata.co.jp (SAVSMTP 3.1.0.29) with SMTP id M2004013015451600831
 for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 15:45:16 +0900
Received: from volcano.rd.nttdata.co.jp (volcano.rd.nttdata.co.jp [10.8.130.24])
	by rd5.rd.nttdata.co.jp (Postfix) with ESMTP id A91F441E47
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 13:43:02 +0900 (JST)
Subject: fork and security context transitions
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <bs-f-vazquez@bs.rd.nttdata.co.jp>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=
Message-Id: <1075437775.1088.144.camel@volcano.rd.nttdata.co.jp>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 13:42:55 +0900
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear all,

I have just started using SELinux and so far I am really satisfied with
the possibilities and quality of the project, but I have found what is
either a missing feature or, otherwise, a feature.

I working in the development of a server application whose client users
must have an Unix Account (for authentication purposes) and an
associated SELinux user account (every user is included in its own
security context after login in).

My intention was to fork a child of the server for every client
successfully authenticated, assigning to that child a client specific
security context different from the one of the server.

It is at this point that my problem arose. After reading through the
documentation, some white-papers and FAQs, I concluded that the only way
to achieve this was using the "execve" function, which can be used to
make a domain transition if the "setexeccon" has been previously
executed and the adequate permissions have been granted in the policy. I
understand that a child process inherits the parent's security context
and that it can only be changed with the use of "execve". Furthermore,
since a process cannot change its own security context I do not now any
other way to reach my goal.

Due to the latter, I have started to split my server into two
executables so that there's a listening server that creates children in
the required security context (using "execve").

Anyway, I soon found that the resulting code is not as easy to maintain
as the original one and that I have to make a fairly big amount of
changes. Besides, I think this is not the right approach, since in this
case, the use of SELinux is really having a big impact in the projects
code.

I was wandering if allowing to fork a child in a security context
different from the parent's (without using execve) is a good idea or
not, since I find it useful and, anyway, it can be achieved splitting a
program in two and using "execv".

I apologise in case I'm completely missing the point and I have
misunderstood any of the underlying basic SELinux concepts.

Best wishes from a SELinux newbie,

Fernando Vázquez

-- 
ＮＴＴ Data Corporation, R&D Headquarters
Open Systems Architecture Group
Fernando Vázquez
E-Mail: <bs-f-vazquez@bs.rd.nttdata.co.jp>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
