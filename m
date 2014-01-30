Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0UJJvnj010612
 for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2014 14:19:59 -0500
Received: by mail-qa0-f51.google.com with SMTP id f11so5080851qae.10
 for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2014 11:19:56 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: mthode@mthode.org
Subject: Re: file access causes a kernel bug
Date: Thu, 30 Jan 2014 14:19:47 -0500
Message-ID: <1897429.yoaRn36u2g@sifl>
In-Reply-To: <52EA8D4D.5080707@mthode.org>
References: <52E8B5F8.2070005@mthode.org> <2218414.0HDc6YTzKt@sifl>
 <52EA8D4D.5080707@mthode.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Richard Yao <ryao@gentoo.org>, selinux@tycho.nsa.gov, behlendorf@llnl.gov,
 Brian Behlendorf <behlendorf1@llnl.gov>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, January 30, 2014 11:35:09 AM Matthew Thode wrote:
> On 01/30/2014 11:19 AM, Paul Moore wrote:
> > On Thursday, January 30, 2014 11:07:30 AM Matthew Thode wrote:
> >> On 01/30/2014 10:41 AM, Stephen Smalley wrote:
> >>> Try the attached patch.
> >> 
> >> Confirmed that this fixes it :D thanks a ton for this.
> > 
> > Queued up in my stable branch, I'll send a pull request to James once -rc1
> > is released.
> > 
> > Thanks guys.
> 
> Any chance for backport to 3.13?

It will go off to the stable list and ultimately it will be up to the stable 
kernel maintainers.  However, considering the size and nature of the patch I 
see no reason why it would not be applied to a 3.13.X release in the future.

-- 
paul moore
www.paul-moore.com
