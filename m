Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i13FFLRb006221
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 10:15:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i13FE0VK016706
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 15:14:00 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i13FE0lx016700
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 15:14:00 GMT
Subject: Re: fork and security context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <bs-f-vazquez@bs.rd.nttdata.co.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1075788687.826.222.camel@volcano.rd.nttdata.co.jp>
References: <1075437775.1088.144.camel@volcano.rd.nttdata.co.jp>
	 <1075469989.22930.19.camel@moss-spartans.epoch.ncsc.mil>
	 <1075788687.826.222.camel@volcano.rd.nttdata.co.jp>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1075821304.4024.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 03 Feb 2004 10:15:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-02-03 at 01:11, Fernando Luis Vázquez Cao wrote:
> Wouldn't the "inheritance of state and the initialization of the process
> in the new SID" be controlled as effectively as it is with the use of
> "setexeccon" and "execv"?. This is, in once sentence, the source of all
> my doubts.

No.  On an exec-based domain transition, SELinux controls:
1) The ability of the source domain to transition to the target domain
(which you can do on a fork, as you note).

2) The ability of the target domain to be entered via a particular
entrypoint program.  This binds the initialization of the process in
that target domain to the startup code for that program, and binds the
target domain to separate code from the source domain.  It is important
to be able to control what code can be executed with what set of
permissions (i.e. domain) and how a process can be initialized (i.e.
startup code) when run with a particular set of permissions.  A
fork-based domain transition can't enforce such controls; from the
kernel's perspective, both the source and target domain execute the same
code and the target domain can be initialized from anywhere within the
program being executed by the source domain when it does the fork.  This
weakens the guarantees that can be provided by the kernel, and increases
the assurance burden on the application.  

3) The ability of the target domain to inherit state from the source
domain, or stated differently, the ability of the source domain to
influence the target domain by passing state to it.  While we could
implement specific forms of inheritance control and state sanitization
for a domain-changing fork, these would increasingly diverge from the
natural semantics of fork (whereas exec already has parallels for at
least some of these controls), and you can't implement some at all
without turning fork into exec - e.g. think about memory inheritance. 
If we implemented a domain-changing fork and provided as much
inheritance control as feasible, it isn't clear that the resulting fork
would be any more useable by existing applications than an exec-based
transition.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
