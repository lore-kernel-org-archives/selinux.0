Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s15HIS1F020636
 for <selinux@tycho.nsa.gov>; Wed, 5 Feb 2014 12:18:28 -0500
Received: by mail-pd0-f171.google.com with SMTP id g10so604645pdj.30
 for <selinux@tycho.nsa.gov>; Wed, 05 Feb 2014 09:18:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52F271AF.6080902@mthode.org>
References: <52E8B5F8.2070005@mthode.org> <52EA80AC.2070802@tycho.nsa.gov>
 <52EA86D2.104@mthode.org> <2218414.0HDc6YTzKt@sifl>
 <52F271AF.6080902@mthode.org>
Date: Wed, 5 Feb 2014 12:18:25 -0500
Message-ID: <CAHC9VhReAdqxhQ2NCydFpzQMnO5x0jG3Cy_wteEMiu9jYYg4iw@mail.gmail.com>
Subject: Re: file access causes a kernel bug
From: Paul Moore <paul@paul-moore.com>
To: mthode@mthode.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: Richard Yao <ryao@gentoo.org>, selinux@tycho.nsa.gov, behlendorf@llnl.gov,
 Brian Behlendorf <behlendorf1@llnl.gov>, Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Feb 5, 2014 at 12:15 PM, Matthew Thode <mthode@mthode.org> wrote:
> On 01/30/2014 11:19 AM, Paul Moore wrote:
>> On Thursday, January 30, 2014 11:07:30 AM Matthew Thode wrote:
>>> On 01/30/2014 10:41 AM, Stephen Smalley wrote:
>>>> Try the attached patch.
>>>
>>> Confirmed that this fixes it :D thanks a ton for this.
>>
>> Queued up in my stable branch, I'll send a pull request to James once -rc1 is
>> released.
>>
>> Thanks guys.
>>
> Mind letting me know when this has been upstreamed?

I've been away for a bit and unable to push patches, but you should
see it this week.

-- 
paul moore
www.paul-moore.com
