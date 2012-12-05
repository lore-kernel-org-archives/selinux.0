Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB5JPM9m008524
	for <selinux@tycho.nsa.gov>; Wed, 5 Dec 2012 14:25:22 -0500
Received: by mail-bk0-f53.google.com with SMTP id j5so2526206bkw.12
        for <selinux@tycho.nsa.gov>; Wed, 05 Dec 2012 11:24:34 -0800 (PST)
Date: Wed, 5 Dec 2012 20:24:26 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: selinux@tycho.nsa.gov
Subject: Re: policy for PowerDNS
Message-ID: <20121205192426.GA6594@siphos.be>
References: <50BCB590.8010602@hoentjen.eu>
 <1354547319.13093.2.camel@localhost>
 <50BDE094.9010405@hoentjen.eu>
 <50BE0529.2090902@redhat.com>
 <CAPzO=NyBgG7q8yqzxzQGnePN6FyuxRi_5YEKLc+t4tuH3Kao3w@mail.gmail.com>
 <50BF355A.3090708@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <50BF355A.3090708@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Dec 05, 2012 at 06:51:54AM -0500, Daniel J Walsh wrote:
> > If named by default doesn't require this access, doesn't it make sense to
> > keep it restricted? Remote code execution vulnerabilities might be
> > mitigated if the policy prohibits execution of common binaries
> > 
> > Reading /usr however seems less problematic (I'm even surprised it doesn't 
> > require this already).
> 
> Perhaps but if you have enough control over a process to execute random
> binaries, one would guess you have enough control to call other syscalls
> implemented in those binaries.

I can follow your reasoning, but I disagree.

Remote command execution can be done either in a very simple way (for
instance, user input that is not correctly sanitized and that is directly
used for spawning specific commands) or through memory manipulation.

Let's say it is memory manipulation, then there are imho two ways this can
lead to a remote command execution: data memory or execution memory.

Either the memory is data (non-executable) and is used by the application
for its flows, logic and what else. In this case, you won't have the
ability to invoke syscalls yourself (through the exploit) but you can
manipulate the application, which underlyingly might use the data to
spawn commands.

Or the memory is code (executable). In this case, if you can manipulate
this, then you indeed have control over the application completely and can
invoke system calls yourself.

The majority of Remote Code Execution vulnerabilities, imho, plays in the
data memory, not in the executable memory. For one, because executable
memory shouldn't be writeable in the first place (you can use PaX or other
constraints for that). It is also harder to manipulate this code to the
extend that you can do useful things with it.

But if we're talking about data memory manipulation/corruption, then the
syscalls don't play a role, and SELinux can reduce the impact of such
vulnerabilities if you can downplay what the domain is allowed to do. Such
as executing generic binaries.

Of course, an even better way to handle this is to chroot the named daemon
itself so that there are no binaries to execute beyond those that are
already needed. I do believe that chrooting named is still a very useful
approach even if you use SELinux [1], but there are people that think
differently.

Wkr,
	Sven Vermeulen

[1] http://blog.siphos.be/2012/04/why-both-chroot-and-selinux/



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
