Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3MKiLpk002341
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 16:44:21 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so108086eek.20
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 13:44:21 -0700 (PDT)
Message-ID: <1398199459.16991.17.camel@x220.localdomain>
Subject: Re: [secilc] typeattributeset with "and" expression does not work
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Tue, 22 Apr 2014 22:44:19 +0200
In-Reply-To: <1398199159.16991.14.camel@x220.localdomain>
References: <1398189362.16991.6.camel@x220.localdomain>
 <5356BD03.40501@tresys.com> <1398195193.16991.12.camel@x220.localdomain>
 <5356C6AA.5030009@tresys.com> <1398199159.16991.14.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-04-22 at 22:39 +0200, Dominick Grift wrote:
> On Tue, 2014-04-22 at 15:44 -0400, Steve Lawrence wrote:
> 
> > >>> Also, i still have that weird boolean issue where, even though sesearch
> > >>> shows the rules are loaded and enabled, SELinux still blocks the access
> > >>
> > >> I think we actually fixed this about an hour ago. Give it a shot, let us
> > >> know if it's actually fixed.
> > > 
> > > Nice, i will try with up-to-date secilc tomorrow
> 
> Current head does not fix the boolean issue, i just verified and the
> issue is still there

Actually it partly works (but it did before as well)

Its the conditional capability permissions that do not work

i have for example a set of consitional rules:

(allow ARG1 security_t (security load_policy))
(allow ARG1 security_t (file (write)))

The file write works but the security load_policy does not work
