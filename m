Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09G9YC8031993
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 11:09:37 -0500
Received: by mail-wg0-f51.google.com with SMTP id z12so2740800wgg.6
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 08:09:35 -0800 (PST)
Message-ID: <1389283773.15747.18.camel@x220.localdomain>
Subject: Re: [RFC] CIL and Source Policy Integration
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Thu, 09 Jan 2014 17:09:33 +0100
In-Reply-To: <52CEBFC8.5060506@tresys.com>
References: <52CDB8AC.4090504@tresys.com>
 <1389274525.14773.32.camel@x220.localdomain>
 <1389279068.15411.6.camel@x220.localdomain> <52CEBFC8.5060506@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-01-09 at 10:27 -0500, Steve Lawrence wrote:

> Considering this patchset really only changes where modules are
> installed and the format of those modules, I suspect you're right that
> copying the targeted configuration is causing some issues. Plus the fact
> that the policy is based on old refpolicy and not fedora policy, I
> expected policy related issues. However, the main goal of this RFC was
> to determine if the CIL and Source policy integration is headed down the
> right path, and determine if there are any high level design flaws or
> any issues that need to be worked out for upstream integration to occur.
> If the only remaining issue is getting a system working in enforcing, I
> think we're okay with that.
> 
> We'll continue to look into the issues you described and see if we can
> come up with fixes, but I suspect they are more policy/configuration
> related, and not problems with the patchset.
> 
> Thanks!
> - Steve

Alright, i understand. I do suspect this is more than just a simple
policy issue but i can't narrow it down at the moment. Login mappings
are missing one way or another, and that seems to break other things
like home dir context generation. Since semodule -B initiates all this i
would argue that semodule -B functionality for at least some part is
broken on way or another.

I did do other tests and they seems to all pass.

For example disabling and enabling modules:

so for example:

semodule -d irc (disabled it: confirmed with sesearch)
cd cilpolicy xargs -a LISTING semodule -i
(tells me that it will disable irc module after install because its set
disabled: confirmed with sesearch)
semodule -e irc (enables it again: confirmed with sesearch)
