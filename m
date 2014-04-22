Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3MKdM13001815
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 16:39:22 -0400
Received: by mail-ee0-f48.google.com with SMTP id b57so103320eek.21
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 13:39:21 -0700 (PDT)
Message-ID: <1398199159.16991.14.camel@x220.localdomain>
Subject: Re: [secilc] typeattributeset with "and" expression does not work
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Tue, 22 Apr 2014 22:39:19 +0200
In-Reply-To: <5356C6AA.5030009@tresys.com>
References: <1398189362.16991.6.camel@x220.localdomain>
 <5356BD03.40501@tresys.com> <1398195193.16991.12.camel@x220.localdomain>
 <5356C6AA.5030009@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-04-22 at 15:44 -0400, Steve Lawrence wrote:

> >>> Also, i still have that weird boolean issue where, even though sesearch
> >>> shows the rules are loaded and enabled, SELinux still blocks the access
> >>
> >> I think we actually fixed this about an hour ago. Give it a shot, let us
> >> know if it's actually fixed.
> > 
> > Nice, i will try with up-to-date secilc tomorrow

Current head does not fix the boolean issue, i just verified and the
issue is still there
 
> >> Thanks for the feedback!
> >> - Steve
> >>
> >>
> > 
> > 
> 
