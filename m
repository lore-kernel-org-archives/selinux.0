Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09FRMu3028680
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 10:27:22 -0500
Message-ID: <52CEBFC8.5060506@tresys.com>
Date: Thu, 9 Jan 2014 10:27:04 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: [RFC] CIL and Source Policy Integration
References: <52CDB8AC.4090504@tresys.com>	
 <1389274525.14773.32.camel@x220.localdomain>
 <1389279068.15411.6.camel@x220.localdomain>
In-Reply-To: <1389279068.15411.6.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/09/2014 09:51 AM, Dominick Grift wrote:
> On Thu, 2014-01-09 at 14:35 +0100, Dominick Grift wrote:
>> On Wed, 2014-01-08 at 15:44 -0500, Steve Lawrence wrote:
>>
>>> Thanks, and we look forward to receive your feedback.
>>
>> I played with this a bit this morning. Followed all steps.
> 
> When one runs semodule -B, things start to break because of the login
> mappings that disappear, and as a consequence the home dir contexts also
> disappear.
> 
> It removes the login mappings, and the content of user home directories
> end up with type default_t
> 
> Most of the issues are due to: "cp
> -r /etc/selinux/targeted/{contexts,seusers,setrans.conf} /etc/selinux/cil-test/"
> 
> It should work without that step (either that or i am overlooking
> things)
> 
> 

Considering this patchset really only changes where modules are
installed and the format of those modules, I suspect you're right that
copying the targeted configuration is causing some issues. Plus the fact
that the policy is based on old refpolicy and not fedora policy, I
expected policy related issues. However, the main goal of this RFC was
to determine if the CIL and Source policy integration is headed down the
right path, and determine if there are any high level design flaws or
any issues that need to be worked out for upstream integration to occur.
If the only remaining issue is getting a system working in enforcing, I
think we're okay with that.

We'll continue to look into the issues you described and see if we can
come up with fixes, but I suspect they are more policy/configuration
related, and not problems with the patchset.

Thanks!
- Steve
