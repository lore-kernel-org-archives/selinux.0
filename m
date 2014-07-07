Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s67EONRp027098
 for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2014 10:24:23 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so6819103wib.13
 for <selinux@tycho.nsa.gov>; Mon, 07 Jul 2014 07:24:22 -0700 (PDT)
Message-ID: <1404743060.9852.50.camel@x220.localdomain>
Subject: Re: secilc: is anyone able to confirm that type_change ...
From: Dominick Grift <dominick.grift@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Date: Mon, 07 Jul 2014 16:24:20 +0200
In-Reply-To: <53BAA801.8070308@tresys.com>
References: <1404563967.9852.42.camel@x220.localdomain>
 <1404652323.9852.49.camel@x220.localdomain> <53BAA801.8070308@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2014-07-07 at 10:00 -0400, Steve Lawrence wrote:

> I can't reproduce the problem with my test policies. The typechange
> statements look like they are correctly inserted into the binary and I
> am seeing the expected type changes at runtime.
> 
> Is this with your monogam policy?
> 

No, that one is no longer maintained.

It is this very small base policy:

https://github.com/doverride/e145
