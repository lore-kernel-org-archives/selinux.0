Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w39Cuub7024907
 for <selinux@tycho.nsa.gov>; Mon, 9 Apr 2018 08:56:56 -0400
Received: from gtierney.internal.digirati.com ([62.254.125.26]) by
 mail.gmx.com (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MYP57-1f0lDn2qZt-00V91z for <selinux@tycho.nsa.gov>; Mon, 09 Apr 2018
 14:56:18 +0200
Date: Mon, 9 Apr 2018 13:56:16 +0100
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180409125616.GA12076@gtierney.internal.digirati.com>
References: <6a2368f9-5979-737f-ca56-2e8b85e90e93@redhat.com>
 <20180409075523.GA2087@julius.enp8s0.d30>
 <20180409084124.GB2087@julius.enp8s0.d30>
 <d72be794-a882-a7ff-381b-fd1ffb78d0c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <d72be794-a882-a7ff-381b-fd1ffb78d0c8@redhat.com>
Subject: Re: CIL namespaces and blockinheritfilter keyword.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 09, 2018 at 01:41:12PM +0200, Lukas Vrabec wrote:

... snip ...

Those wiki pages on SELinuxProject/cil are now pretty out of date 
(you'll notice that some other statements mentioned there like 
`template` are not implemented as well).  The updated documentation is 
at https://github.com/SELinuxProject/selinux/tree/master/secilc/docs.

>Hi Dominick,
>
>Yes, This is one of the options to create hierarchy when the block on
>top will have just minimum rules and every child block will append new
>rules.
>
>Unfortunately, this probably won't work in real world. Let's say that I
>have this hierarchy and badlogger block contains several allow rules and
>I want to inherit all of them except one, *BUT* I'm not SELinux policy
>expert and don't know how hierarchy looks like. That's the reason why
>I'm looking for blockinheritfilter.
>

I think it's more reasonable for someone not intimate with the policy to
familiarize themselves with the hierarchy/composition of a well structured
policy, rather than what they may need to disallow in a given scope (which may
come from other inherited blocks, calls to macros, or `in` statements scattered
across several policy modules).  This means they can compose their policy out
of high level building blocks rather than low level allow rules (which arguably
would require a policy expert to fully understand the implications of).

"blockinheritfilter" also seems to be at odds with the permission
whitelisting/deny-by-default model of SELinux by having the policy author
revoke permissions rather than permit them.

Thanks,
Gary.

>However, we should go via creating block namespaces hierarchy as you
>described if there are no plans to implement this feature.
>
>Thanks,
>Lukas.
>
>
>-- 
>Lukas Vrabec
>Software Engineer, Security Technologies
>Red Hat, Inc.
>
