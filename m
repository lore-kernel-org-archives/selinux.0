Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA07464
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 16:47:43 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1CLlgI15461
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 21:47:42 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h1CLlgf15457 for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 21:47:42 GMT
Subject: Re: Simple question
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: j.logsdon@lancaster.ac.uk
Cc: selinux@tycho.nsa.gov
In-Reply-To: <Pine.LNX.4.10.10302121830350.25327-100000@mercury.quantex>
References: <Pine.LNX.4.10.10302121830350.25327-100000@mercury.quantex>
Content-Type: text/plain
Date: 12 Feb 2003 16:47:37 -0500
Message-Id: <1045086458.16529.177.camel@moss-sooners.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In general terms it's difficult to respond in general terms.  One
problem is that "Access Control Lists" means different things to
different people.  Access control lists are a mechanism that could be
used for many of the same controls as SELinux, but typically ACLs are
different from SELinux in many ways.

Some differences between SELinux and what most people think of as ACLs:

1. ACLs are usually "discretionary" meaning that some user is allowed to
change them. SELinux controls are "mandatory" which means that the
policy is set administratively and the controls can't be changed by most
processes on the system.  In real-life terms that means that even if
relatively important processes are compromised the compromise can be
confined.

2. ACLs as most people use the term generally applies to filesystem
objects although it could apply to other system resources as well. 
SELinux controls are intended for all system resources, so for example,
signals generally wouldn't have separate ACLs (and that probably
wouldn't make sense either) but SELinux can control the delivery of
signals.

3. But what kind of control would you want on a file descriptor?  That
brings us to the point that SELinux has finer grained controls.  So
where ACLs are usually just read, write, execute, and delete, with
perhaps a few more options depending on the system you're discussing,
SELinux controls operations on resources specific to that resource. 
(Poor wording on my part, but hopefully understandable.) Additionally,
those controls are always in effect.

4. Another important factor is that SELinux can control access to system
resources (like files) based not just on user identity or credentials,
but on the security identifier of the process which was derived from a
combination of the user and the code the user ran.  Type enforcement
enables access control decisions to be based on such things as the
trustworthiness of the code that's running, and program function, as
well as the user identity.

In summary a good mandatory access control implementation will: 1) Have
an administratively set security policy. 2) Always be in control over
all subjects and objects on the system. 3) Base policy decisions on all
security relevant information.  Even a comprehensive access control list
implementation with administratively set ACLs is not going to be able to
meet the third.

On Wed, 2003-02-12 at 13:32, j.logsdon@lancaster.ac.uk wrote:
> Hi
> 
> In general terms, what does SEL do that I can't do (even if more
> complicated) by Access Control Lists?  If I can control the users and
> groups that can access files (and these are all properly set) what
> advantage do I have in running SEL?
> 
> I'm not being rude - just trying to understand the difference and to see
> whether it is really necessary to run a bespoke kernel.
> 
> TIA
> 
> John
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
-- 
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
