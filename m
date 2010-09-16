Date: Wed, 15 Sep 2010 20:14:53 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: James Morris <jmorris@namei.org>
Cc: sds@tycho.nsa.gov, eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: fix parallel compile error
Message-ID: <20100916001452.GA2988@windriver.com>
References: <1281389665-22152-1-git-send-email-paul.gortmaker@windriver.com>
 <alpine.LRH.2.00.1009150819270.22184@tundra.namei.org>
 <20100915134429.GA17032@windriver.com>
 <alpine.LRH.2.00.1009160823270.32096@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LRH.2.00.1009160823270.32096@tundra.namei.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[Re: [PATCH] selinux: fix parallel compile error] On 16/09/2010 (Thu 08:24) James Morris wrote:

> On Wed, 15 Sep 2010, Paul Gortmaker wrote:
> 
> > Thanks for applying this earlier patch.  I found that there still
> > is a (now smaller) corner case to trigger this because of the ss subdir,
> > which is why I resent a slightly different patch to you last week.
> > This updated patch does a better job of showing and fixing the problem.
> > 
> > http://www.spinics.net/linux/fedora/linux-security-module/msg09277.html
> > 
> > Let me know if you would like a delta patch, instead of rewinding
> > and replacing the older one with this one.
> 
> Please send a delta patch, otherwise, it will mess up the git history.

No problem.  Inline below.  My patch #2 would have needed to have been
updated anyway, since the addition of ss/status.c wasn't in the tree
I'd originally created it on.

Thanks,
Paul.
---
