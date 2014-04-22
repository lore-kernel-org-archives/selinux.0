Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3MJ3VX1026389
 for <selinux@tycho.nsa.gov>; Tue, 22 Apr 2014 15:03:31 -0400
Message-ID: <5356BD03.40501@tresys.com>
Date: Tue, 22 Apr 2014 15:03:31 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: [secilc] typeattributeset with "and" expression does not work
References: <1398189362.16991.6.camel@x220.localdomain>
In-Reply-To: <1398189362.16991.6.camel@x220.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/22/2014 01:56 PM, Dominick Grift wrote:
> (type foo)
> (typeattribute bar)
> (typeattribute baz)
> (typeattributeset bar (and baz foo))
> 
> It compiles but neither bar, nor baz gets associated with type foo
> 

This is because 'and' is similar to the set intersection of baz and foo.
But baz is empty, so the intersection of baz and foo is nothing,
resulting in nothing being added to the bar attribute.

You probably want the union of baz and foo? Replacing 'and' with 'or'
would make it so bar would be associated with foo and everything
associated with baz.

> Also, i still have that weird boolean issue where, even though sesearch
> shows the rules are loaded and enabled, SELinux still blocks the access

I think we actually fixed this about an hour ago. Give it a shot, let us
know if it's actually fixed.

Thanks for the feedback!
- Steve
