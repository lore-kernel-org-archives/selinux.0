Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9LCPv0k002848
 for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2015 08:25:57 -0400
Subject: Re: Static analysis to assist policy creation?
To: Andrew Ruef <andrew@trailofbits.com>, selinux@tycho.nsa.gov,
 Vit Mojzis <vmojzis@redhat.com>
References: <85D0FAC1-423C-49CF-801D-E5EB160A9834@trailofbits.com>
From: Miroslav Grepl <mgrepl@redhat.com>
Message-ID: <5627844E.1000907@redhat.com>
Date: Wed, 21 Oct 2015 14:25:50 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
In-Reply-To: <85D0FAC1-423C-49CF-801D-E5EB160A9834@trailofbits.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/20/2015 07:17 PM, Andrew Ruef wrote:
> Hello SELinux list, 
> 
> We’ve been thinking about creating a static (or potentially concolic) analysis and testing infrastructure that would assist in the creation of finer grained SELinux policies than audit2allow. We think that some work can be done through alias analysis and domain specific object (strings, memory regions/files, etc) analysis wholly statically, but we’ve developed an extensive symbolic execution system for C/binary programs that could also be applied. 
> 
> I’ve done some searching and asking around and it doesn’t seem like there are any tools that do this. I’m aware of some past projects that made use of static analysis tools to help create security policies, like the IBM SWORD4J work. The IBM people seemed really happy with those results and they have relayed that it really helped their internal efforts for security labeling, so maybe there is some hope for tools in this area. 
> 
> My question is two-fold
> 
> 1. Is there a history of using static analysis to create SELinux policies that I haven’t found so far?
> 
> 2. Is there any interest in the community for such an effort today?
> 
> Thank you,
> 
> Andrew

Hi Andrew,
we have a guy (Vit Mojzis) in Red Hat who works on

"SELinux policy analysis tool" diploma thesis consisting of the following

1) Get acquainted with Security Enhanced Linux (SELinux).
2) Design SELinux policy analysis tool capable of
 (a) representing SELinux policies as well as given integrity goals
 (b) identifying conflicts between them (i.e., capable of analysis of
interactions between policy modules)
 (c) providing information necessary for resolution of such conflicts.
3) Implement the tool so that it can be integrated with current SELinux
user-space tools.
4) Demonstrate functionality of the developed tool on a non-trivial use
case.
5) Evaluate the obtained results and discuss possible future
improvements of the developed tool.

It is not the same what you want but I believe there is a certain
overlap with your idea.

> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 


-- 
Miroslav Grepl
Senior Software Engineer, SELinux Solutions
Red Hat, Inc.
