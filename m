Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA17300
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 11:30:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA24844
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 15:28:36 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id PAA24840
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 15:28:35 GMT
Date: Tue, 9 Oct 2001 11:30:09 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Justin R. Smith" <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: ssh, ad nauseum
In-Reply-To: <1002639082.14315.3.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0110091121350.3214-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 9 Oct 2001, Justin R. Smith wrote:

> I rebooted my normal (i.e., non-selinux) kernel and ssh'ed to my office
> machine from home and was asked for a password (so it didn't use my
> 'authorized_users' file). Then I remembered that I didn't restore the
> vanilla version of the sshd --- I was still using the selinux version.
>
> I then replaced the selinux sshd with the original one and rebooted.
> After this ssh worked normally. So, perhaps something in the selinux
> sshd is responsible for my little problem (always having to type a
> password to use ssh).

This seems unlikely.  The SELinux openssh patch merely changes sshd to
set the security context on the pty and to run the user process with
an appropriate security context.

What version of openssh are you running on the home machine and the office
machine?  Are you using the stock RH7.1 programs or a newer openssh package?
If the latter, did you try applying our openssh patch to the newer openssh
package and then configuring, building, and installing that modified
openssh in the same manner that you installed the original one?  The
patch applies fine to openssh-2.9.9p2 aside from a reject on a spurious
extra line.

When you generated your keys, did you generate keys for protocol 1 or
protocol 2 (default for ssh-keygen is 1, unless you use the -t option)?
If you are using protocol 1, does 'ssh -1 machine' work for you?  What
does 'ssh -v -1 machine' show?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
