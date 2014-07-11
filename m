Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6BHKoer011994
 for <selinux@tycho.nsa.gov>; Fri, 11 Jul 2014 13:20:50 -0400
Message-ID: <53C01CDD.80407@tresys.com>
Date: Fri, 11 Jul 2014 13:20:29 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain>
In-Reply-To: <1404975079.31209.11.camel@x220.localdomain>
Content-Type: text/plain; charset="UTF-8"
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/10/2014 02:51 AM, Dominick Grift wrote:
> On Wed, 2014-07-09 at 15:21 -0400, Steve Lawrence wrote:
>> In January, we sent an RFC [1] to update userspace to integrate CIL
>> [2] and source policy. And in April, we sent an updated RFC [3] which
>> added support for high level languages and a tool to convert policy
>> package (pp) files to CIL. After getting some good feedback, we have
>> made some more changes, mostly to maintain ABI compatibility. The
>> major changes made since the last patchset are:
> 
> <snip>
> 
> I just spent a few hours playing with this and i am impressed.
> 
> Everything i tested just works.
> 
> What did i test?
> 
> 1. disabling/enabling existing modules
> 2. toggling booleans with semanage
> 3. adding and removing port and file contexts with semanage
> 4. adding/removing a policy module with semodule, checkmodule,
> semodule_package
> 5. adding/removing a (cil) policy module with semodule
> 6. associating a (new) user with staff_t identity
> 
> Comments?
> 
> if i do restorecon -R -v -F /home it resets contexts *every* time (from
> s0 to s0-s0). No noticable side effects because of this
> 

We recently pushed a fix to CIL that fixes the issue with how CIL
generates file contexts. It now removes the high level if it is the same
as the low level.

- Steve
