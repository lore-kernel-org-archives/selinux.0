Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i136DRRb004577
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 01:13:28 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i136DI1K000865
	for <selinux@tycho.nsa.gov>; Tue, 3 Feb 2004 06:13:21 GMT
Subject: Re: fork and security context transitions
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <bs-f-vazquez@bs.rd.nttdata.co.jp>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1075469989.22930.19.camel@moss-spartans.epoch.ncsc.mil>
References: <1075437775.1088.144.camel@volcano.rd.nttdata.co.jp>
	 <1075469989.22930.19.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=
Message-Id: <1075788687.826.222.camel@volcano.rd.nttdata.co.jp>
Mime-Version: 1.0
Date: Tue, 03 Feb 2004 15:11:28 +0900
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you for your prompt reply.

I have read through the links you provided me with (I'm sorry you have
had to answer so many times to the same question) and I would like to
make some further comments.

In one of your early replies you say that "SELinux only supports process
SID transitions upon program execution so that inheritance of state and
the initialization of the process in the new SID can be controlled". I
agree with this statement, but what I was planning to do I feel that is
slightly different.

I was thinking of implementing a new function analogical to
"setexeccon", that could be called something like "setforkcon".
"setforkcon" would be invoked before the execution of fork (just as its
model function) and the child would be given the security context
specified in the call IF, AND ONLY IF, the parent process has been
granted the transition to the requested domain.

"fork" would be modified to be aware of the use of "setforkcon" (maybe
via /proc/*/attr/fork), but the compatibility with the original version
of fork would be preserved, since, in case "setforkcon" has not been
used, it is functionally identical. Of course, some changes would have
to be made in both the kernel and user space parts of "SELinux" to add
support to a new kind of operation (let's say "ftransition"). The
application requiring this functionality could be granted a
"ftransition" permission with a command such as:

allow d1_t d2_t:process ftransition;

Wouldn't the "inheritance of state and the initialization of the process
in the new SID" be controlled as effectively as it is with the use of
"setexeccon" and "execv"?. This is, in once sentence, the source of all
my doubts.

I think that such a functionality would ease the adoption of SELinux by
new applications. Of course, if my proposal makes no sense and something
like "setforkcon" is potentially insecure it SHOULD not be used,
regardless of its ease of use or user-friendliness.

As an example, if we wanted to make Samba and Apache SELinux aware so
that, in the event of a user session, a child process would be created
in a user-specific domain, what should we do? With SELinux you are
forced to split the servers in two executables, eventually being forced
to make a lot of application specific changes (once more, if this is the
only right approach let's stick with it).

I think that the previous examples represent a case different from that
of inetd, crond or ssh (to cite some), since the latter have to fork
third party applications that are completely unrelated to themselves and
whose trustworthiness is unknown.

In the case of Samba, Apache and my own application, we are talking
about ONE SINGLE application that forks itself. I think that splitting
these programs into a listening server and a service application that is
launched via execve is very similar, from a security point of view, to
my proposal. Why do I think this?

* Before changing the security context functionally identical functions
have to be executed ("setexeccon" and "setforkcon" respectively).

* Only if the right permissions (analogical in both cases) were granted
in the policy, would the requested transition be performed.

* The "initialization of the process" is equally controlled with both
solutions, since in both cases the children could be spawned in a set of
contexts (one per user) that is predefined in the security policy.

* There's no need to make the child process execute a program from a
type different from the father's, since both programs belong to the same
application and, therefore, it is trusted. Any way, with the proposed
extension I think that the same restrictions could be applied to the
child processes.

With the proposed approach I think that not new vulnerabilities (I
apologize if I am completely missing the point!!!!!) are introduced and
that the migration to a SELinux aware application is easier.

I'm sorry for such a long mail and hope that what I have said makes any
sense.

Best regards,

Fernando Vázquez


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
