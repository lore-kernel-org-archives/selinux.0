Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9L3H89i001084
 for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2015 23:17:08 -0400
Received: by pacfv9 with SMTP id fv9so41982002pac.3
 for <selinux@tycho.nsa.gov>; Tue, 20 Oct 2015 20:17:03 -0700 (PDT)
Date: Wed, 21 Oct 2015 11:16:58 +0800
From: Jason Zaman <jason@perfinion.com>
To: Andrew Ruef <andrew@trailofbits.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Static analysis to assist policy creation?
Message-ID: <20151021031658.GA8385@meriadoc>
References: <85D0FAC1-423C-49CF-801D-E5EB160A9834@trailofbits.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <85D0FAC1-423C-49CF-801D-E5EB160A9834@trailofbits.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Oct 20, 2015 at 01:17:27PM -0400, Andrew Ruef wrote:
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

Hey Andrew,

This sounds interesting and I'd love a tool to verify things. An often
overlooked part in policies is removing permissions that are no longer
required when a new version is released. A tool like this could be a
great help to re-run whenever there is a major bump in a package to keep
the policy as slim as possible.

You might also want to try the reference policy list. That one is a
little oriented towards actual policy development:
refpolicy@oss.tresys.com

-- Jason
