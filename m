Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA12500
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 06:41:38 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA03518
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 10:39:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA03514 for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 10:39:49 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tracy R Reed <treed@ultraviolet.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: IBM's Multics paper
Date: Tue, 10 Sep 2002 11:19:12 +0200
References: <20020909163557.K20187@ultraviolet.org>
In-Reply-To: <20020909163557.K20187@ultraviolet.org>
MIME-Version: 1.0
Message-Id: <200209101119.12834.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If we're going to have much discussion about this then it may be best to move 
it to my selinux-talk mailing list, selinux-talk-request@coker.com.au for 
subscription requests.

On Tue, 10 Sep 2002 01:35, Tracy R Reed wrote:
> As seen on slashdot today...
>
> http://domino.watson.ibm.com/library/cyberdig.nsf/papers/FDEFBEBC9DD3E35485
>256C2C004B0F0D/$File/RC22534.pdf
>
> I read the entirety of the first paper and parts of the second paper which
> is the original Multics vulnerability analysis.
>
> At the top of page 3 of the report (page 5 in your pdf viewed) they
> specifically mention SE Linux. They compared Multics 768k bytes of
> executable code and data 1767k bytes and suggest that it is far too big to
> be secure and that the complexity leading to that large size needs to be
> corrected. I infer that due to the Linux kernels monolithic design that
> this may not be possible.

I wonder how they got those numbers, from dmesg on one of my systems:
Memory: 256388k/262080k available (929k kernel code, 5304k reserved, 356k 
data, 84k init, 0k highmem)

So it's 929K of code and 356K of data by my count...

A SE Linux policy may be 2-3M for a fully configured system, but I've cut it 
down to as little as 300K uncompressed.

Also I think it's a really bad idea to count policy and code size at the same 
time, they are different things with different issues.  Code size (which is a 
serious issue) is related to the problems of auditing all that C code and 
making sure it does what it's supposed to do, and it comes from many 
different people with different skill levels...  Policy has to be audited, 
but it comes from a much smaller group of people, it's always checked by at 
least two people with the way things work now, and the people who are writing 
the sample policy know what they are doing.

> There isn't much we can do about the hardware, stack direction, or
> implementation language at the moment. We are stuck with x86 and C for a
> good long time it seems. But doesn't x86 hardware now have the ability to
> prevent execution of data? That's what Solar Designers patch does iirc.
> But there has been some reason for not making it part of the standard
> kernel. I've heard about how it prevents intentionally executing
> trampoline code on the stack which some compilers use etc. but I have also
> heard that this can be fixed. Of course I recall Linus saying that if we
> disabled data execution on the stack they would just code around it. I
> don't understand how they would do this and if they could do it on x86

The recent OpenWall patches include trampoline support.  I've run it on some 
production servers and have not been able to find any problems caused by it.

Hopefully at some time in the near future we'll be able to combine this with 
SE Linux, or even better if we could have functionality equivalent to PAX in 
GRSEC.  http://www.grsecurity.net/

The reason it's easier for Multics is that the hardware supports it, there are 
less bits used for storing page access in i386 and some of these things have 
to be hacked (EG by giving the code and data segments different memory 
mappings such that the code segment doesn't have the stack).  It's really 
ugly.  Hopefully new CPU architectures such as IA64 and IA32-64 will have 
better support for such things.  I'm afraid that I can't recall the exact 
details of the CPU mechanisms involved, one book that I can't recommend 
highly enough is "A Guide to RISC Microprocessor Architecture" edited by 
Michael Slater.  It's an old book which probably isn't in print but should be 
in any good university library.  It is really good for background knowledge 
on how different CPUs do some of these things and why they do it, compare 
that with any book on the i386 (there are many) and you can get some good 
ideas on the relative merits of the CPUs.

Also as mentioned in the document there is a language issue, C is not the best 
language for reliable code.  If we started writing everything in Ada then 
things would become much more secure.

> The parallels between then and now (27 years later) are striking. It is
> rather depressing that we are still trying to solve the same problems they
> were trying to solve and end up reinventing the wheel.  What's worse is
> that our wheel may be rather rickety compared to theirs.

It's not surprising really.  Secure systems never entered the mainstream, so 
people with security knowledge didn't pass it on outside the security 
community.  Until recently most universities didn't even have a shadow 
password file on their time sharing machines!  How could they ever teach 
students anything about security?!?!

Some universities are offering info-sec courses, which I expect to be useless.  
You can't have a situation where there's no semblance of security and then 
just have a lecturer give some talks on security and hope for a good result!

I've been thinking about offering some university lectures on the topic of SE 
Linux.  The idea is a lecture for all 300+ students in the course, then a few 
tutorials for a couple of classes of students that have special interest in 
the area, they would then setup some SE server machines for the other 
students to use.  This could fit into a regular Unix course at any Uni 
(instead of boring the smarter students with tutorials on basic C coding etc 
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
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
