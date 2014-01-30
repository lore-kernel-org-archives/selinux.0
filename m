Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0UHJhnm002816
 for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2014 12:19:43 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so4800226qac.3
 for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2014 09:19:41 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: mthode@mthode.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: file access causes a kernel bug
Date: Thu, 30 Jan 2014 12:19:37 -0500
Message-ID: <2218414.0HDc6YTzKt@sifl>
In-Reply-To: <52EA86D2.104@mthode.org>
References: <52E8B5F8.2070005@mthode.org> <52EA80AC.2070802@tycho.nsa.gov>
 <52EA86D2.104@mthode.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: behlendorf@llnl.gov, Richard Yao <ryao@gentoo.org>,
 Brian Behlendorf <behlendorf1@llnl.gov>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, January 30, 2014 11:07:30 AM Matthew Thode wrote:
> On 01/30/2014 10:41 AM, Stephen Smalley wrote:
> > Try the attached patch.
> 
> Confirmed that this fixes it :D thanks a ton for this.

Queued up in my stable branch, I'll send a pull request to James once -rc1 is 
released.

Thanks guys.

-- 
paul moore
www.paul-moore.com
