Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0UDeLRb019099
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 08:40:21 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0UDcwVK018401
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 13:38:58 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0UDcvlx018398
	for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2004 13:38:57 GMT
Subject: Re: fork and security context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <bs-f-vazquez@bs.rd.nttdata.co.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1075437775.1088.144.camel@volcano.rd.nttdata.co.jp>
References: <1075437775.1088.144.camel@volcano.rd.nttdata.co.jp>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1075469989.22930.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 08:39:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-01-29 at 23:42, Fernando Luis Vázquez Cao wrote:
> Due to the latter, I have started to split my server into two
> executables so that there's a listening server that creates children in
> the required security context (using "execve").

Good.

> Anyway, I soon found that the resulting code is not as easy to maintain
> as the original one and that I have to make a fairly big amount of
> changes. Besides, I think this is not the right approach, since in this
> case, the use of SELinux is really having a big impact in the projects
> code.

Restructuring applications to support least privilege and isolation is a
good thing.

> I was wandering if allowing to fork a child in a security context
> different from the parent's (without using execve) is a good idea or
> not, since I find it useful and, anyway, it can be achieved splitting a
> program in two and using "execv".

It isn't a good idea.  Some prior discussions of this issue can be found
at the below links:
 
http://marc.theaimsgroup.com/?l=selinux&m=107272253121858&w=2
http://marc.theaimsgroup.com/?l=selinux&m=106910931928255&w=2
http://marc.theaimsgroup.com/?l=selinux&m=104939744006086&w=2
http://marc.theaimsgroup.com/?l=selinux&m=102587211414608&w=2
http://marc.theaimsgroup.com/?l=selinux&m=101343633303503&w=2

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
