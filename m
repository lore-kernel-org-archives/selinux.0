Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3MJXGnJ028929
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 15:33:16 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so57492eek.23
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 12:33:15 -0700 (PDT)
Message-ID: <1398195193.16991.12.camel@x220.localdomain>
Subject: Re: [secilc] typeattributeset with "and" expression does not work
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Tue, 22 Apr 2014 21:33:13 +0200
In-Reply-To: <5356BD03.40501@tresys.com>
References: <1398189362.16991.6.camel@x220.localdomain>
 <5356BD03.40501@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2014-04-22 at 15:03 -0400, Steve Lawrence wrote:
> On 04/22/2014 01:56 PM, Dominick Grift wrote:
> > (type foo)
> > (typeattribute bar)
> > (typeattribute baz)
> > (typeattributeset bar (and baz foo))
> > 
> > It compiles but neither bar, nor baz gets associated with type foo
> > 
> 
> This is because 'and' is similar to the set intersection of baz and foo.
> But baz is empty, so the intersection of baz and foo is nothing,
> resulting in nothing being added to the bar attribute.
> 
> You probably want the union of baz and foo? Replacing 'and' with 'or'
> would make it so bar would be associated with foo and everything
> associated with baz.

Impressive, what i am looking for is actually very simple.

I just want to know how i can associate more than a single type
attribute to a specified type in a single statement, that is possible.

(type foo)
(typeattribute bar)
(typeattribute baz)

The equivalent of:

(typeattributeset bar foo)
(typeattributeset baz foo)

In a single statement instead of two

> > Also, i still have that weird boolean issue where, even though sesearch
> > shows the rules are loaded and enabled, SELinux still blocks the access
> 
> I think we actually fixed this about an hour ago. Give it a shot, let us
> know if it's actually fixed.

Nice, i will try with up-to-date secilc tomorrow

> Thanks for the feedback!
> - Steve
> 
> 
