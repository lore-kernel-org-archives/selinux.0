Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA13927
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 10:45:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA07612
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 14:44:17 GMT
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.103])
	by jazzswing.ncsc.mil  with ESMTP id OAA07606
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 14:44:15 GMT
Subject: Re: IBM's Multics paper
To: Russell Coker <russell@coker.com.au>
Cc: Tracy R Reed <treed@ultraviolet.org>, SE Linux <selinux@tycho.nsa.gov>,
        Paul A Karger <pkarger@us.ibm.com>
Message-ID: <OF39E377B1.6F7F0248-ON85256C30.004A7A16@us.ibm.com>
From: Trent Jaeger <jaegert@us.ibm.com>
Date: Tue, 10 Sep 2002 10:44:47 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

                                                                                                               
                                                                                                               
                                                                                                               


Hi,

I am not one of the authors of this paper (Paul Karger on the cc is), but I
gave Paul the numbers for the SELinux policy.

The numbers for this paper are from the policy files, policy.conf
(pre-processed), and ss_policy (compiled) and they are for the complete
SELinux example policy as stated in the paper.

I agree that the policy can be cut-down (and should be based on your
security target), but I am not aware of any principled approaches for
cut-down. This is the interface that administrators see at present.

Personally, I believe that access decisions must be made at the SELinux
policy level, but I think that the point that Paul is trying to make is
that  strong security guarantees must be expressed in a way that average
system administrators can maintain (many folks on this list are well above
average :->).  I don't think that the strong system security guarantees in
Multics were dependent on the fine-grained policy, so this should not be
the case for SELinux either.

A number of folks are awarelooking into policy management, but let me just
update you on my recent efforts that are consistent with this discussion. I
am doing a simple Biba integrity verification on the Apache policy relative
the rest of the SELinux example policy (assuming trusted system and
authentication services).  Interestingly, the only violations are: (1)
shared files: /tmp, tmpfs_t, writeable_t; (2) a number of logging and
system status files; (3) interactions with many services that would not be
run with Apache (possible cut-downs).  Shared /tmp is a well-known UNIX
problem, but its solution is independent of SELinux (although it would be a
significant benefit).  Log files could be handled as exceptions, likely,
although I am still looking at this.

An issue that I am interested in is policy interactions with other
services.  For example, sendmail can edit files in /etc that Apache is
permitted to read.  This could be handled by editing the policy, but if you
are running a highly secure Apache server do you really want to run
sendmail too?  Rather than editing the policy to create your own
specialized, possibly ad hoc policy, might it be possible to create
"conflicting subjects" that are not permitted to run together.  Thus, the
current SELinux policy would remain largely unchanged, but the security
guarantees that this policy implements can be understood and verified
against the SELinux policy.

Then, the policy that the TCB depends on might include only a high-level
Biba lattice, some verified exceptions, and some conflicting subjects.
This would be much smaller than the entire SELinux policy (and Multics),
but you would still have the fine-grained control that you really need to
ensure the higher level requirements.

Does this seem like a reasonable direction?  Does this interact with the
other work on policy management for SELinux?

Regards,
Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595



Russell Coker <russell@coker.com.au>@tycho.nsa.gov on 09/10/2002 05:19:12
AM

Please respond to Russell Coker <russell@coker.com.au>

Sent by:    owner-selinux@tycho.nsa.gov


To:    Tracy R Reed <treed@ultraviolet.org>, SE Linux
       <selinux@tycho.nsa.gov>
cc:
Subject:    Re: IBM's Multics paper



If we're going to have much discussion about this then it may be best to
move
it to my selinux-talk mailing list, selinux-talk-request@coker.com.au for
subscription requests.

On Tue, 10 Sep 2002 01:35, Tracy R Reed wrote:
> As seen on slashdot today...
>
>
http://domino.watson.ibm.com/library/cyberdig.nsf/papers/FDEFBEBC9DD3E35485
>256C2C004B0F0D/$File/RC22534.pdf
>
> I read the entirety of the first paper and parts of the second paper
which
> is the original Multics vulnerability analysis.
>
> At the top of page 3 of the report (page 5 in your pdf viewed) they
> specifically mention SE Linux. They compared Multics 768k bytes of
> executable code and data 1767k bytes and suggest that it is far too big
to
> be secure and that the complexity leading to that large size needs to be
> corrected. I infer that due to the Linux kernels monolithic design that
> this may not be possible.

I wonder how they got those numbers, from dmesg on one of my systems:
Memory: 256388k/262080k available (929k kernel code, 5304k reserved, 356k
data, 84k init, 0k highmem)

So it's 929K of code and 356K of data by my count...

A SE Linux policy may be 2-3M for a fully configured system, but I've cut
it
down to as little as 300K uncompressed.

Also I think it's a really bad idea to count policy and code size at the
same
time, they are different things with different issues.  Code size (which is
a
serious issue) is related to the problems of auditing all that C code and
making sure it does what it's supposed to do, and it comes from many
different people with different skill levels...  Policy has to be audited,
but it comes from a much smaller group of people, it's always checked by at
least two people with the way things work now, and the people who are
writing
the sample policy know what they are doing.

> There isn't much we can do about the hardware, stack direction, or
> implementation language at the moment. We are stuck with x86 and C for a
> good long time it seems. But doesn't x86 hardware now have the ability to
> prevent execution of data? That's what Solar Designers patch does iirc.
> But there has been some reason for not making it part of the standard
> kernel. I've heard about how it prevents intentionally executing
> trampoline code on the stack which some compilers use etc. but I have
also
> heard that this can be fixed. Of course I recall Linus saying that if we
> disabled data execution on the stack they would just code around it. I
> don't understand how they would do this and if they could do it on x86

The recent OpenWall patches include trampoline support.  I've run it on
some
production servers and have not been able to find any problems caused by
it.

Hopefully at some time in the near future we'll be able to combine this
with
SE Linux, or even better if we could have functionality equivalent to PAX
in
GRSEC.  http://www.grsecurity.net/

The reason it's easier for Multics is that the hardware supports it, there
are
less bits used for storing page access in i386 and some of these things
have
to be hacked (EG by giving the code and data segments different memory
mappings such that the code segment doesn't have the stack).  It's really
ugly.  Hopefully new CPU architectures such as IA64 and IA32-64 will have
better support for such things.  I'm afraid that I can't recall the exact
details of the CPU mechanisms involved, one book that I can't recommend
highly enough is "A Guide to RISC Microprocessor Architecture" edited by
Michael Slater.  It's an old book which probably isn't in print but should
be
in any good university library.  It is really good for background knowledge
on how different CPUs do some of these things and why they do it, compare
that with any book on the i386 (there are many) and you can get some good
ideas on the relative merits of the CPUs.

Also as mentioned in the document there is a language issue, C is not the
best
language for reliable code.  If we started writing everything in Ada then
things would become much more secure.

> The parallels between then and now (27 years later) are striking. It is
> rather depressing that we are still trying to solve the same problems
they
> were trying to solve and end up reinventing the wheel.  What's worse is
> that our wheel may be rather rickety compared to theirs.

It's not surprising really.  Secure systems never entered the mainstream,
so
people with security knowledge didn't pass it on outside the security
community.  Until recently most universities didn't even have a shadow
password file on their time sharing machines!  How could they ever teach
students anything about security?!?!

Some universities are offering info-sec courses, which I expect to be
useless.
You can't have a situation where there's no semblance of security and then
just have a lecturer give some talks on security and hope for a good
result!

I've been thinking about offering some university lectures on the topic of
SE
Linux.  The idea is a lecture for all 300+ students in the course, then a
few
tutorials for a couple of classes of students that have special interest in
the area, they would then setup some SE server machines for the other
students to use.  This could fit into a regular Unix course at any Uni
(instead of boring the smarter students with tutorials on basic C coding
etc
they can do more interesting things such as learning SE Linux).

This will result in the students learning a lot about security, especially
when as part of their practical work they have to put machines online and
issue a public challenge to crack them...

--
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
 the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
