Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09GW6JT001905
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 11:32:06 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so3030952wes.30
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 08:32:04 -0800 (PST)
Message-ID: <1389285122.15747.27.camel@x220.localdomain>
Subject: Re: [RFC] CIL and Source Policy Integration
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Thu, 09 Jan 2014 17:32:02 +0100
In-Reply-To: <52CECCAC.5070805@tresys.com>
References: <52CDB8AC.4090504@tresys.com>
 <1389274525.14773.32.camel@x220.localdomain>
 <1389279068.15411.6.camel@x220.localdomain> <52CEBFC8.5060506@tresys.com>
 <1389283773.15747.18.camel@x220.localdomain> <52CECCAC.5070805@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2014-01-09 at 11:22 -0500, Steve Lawrence wrote:

> 
> Yes, looking into some more, I think you're right. There's a bug
> somewhere. Still looking into it.
> 

Thank you. I do not want to flood this thread so i will only post if i
find issues, everything else works as far as i am concerned.

For example i just tested toggling booleans on and off with setsebool,
and that worked fine as well.

I am currently only focusing on CIL, not on whether the user space
modifications are backwards compatible.

> Thanks,
> - Steve
