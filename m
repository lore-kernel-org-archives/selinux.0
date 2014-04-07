Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s37Bj6L2025831
 for <selinux@tycho.nsa.gov>; Mon, 7 Apr 2014 07:45:07 -0400
Message-ID: <53428FBE.3050302@redhat.com>
Date: Mon, 07 Apr 2014 07:45:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Patrick K., ITF" <cto@itechfrontiers.com>, selinux@tycho.nsa.gov
Subject: Re: What do you mean by a 'domain'.
References: <53426EC3.6020109@gmail.com> <53427577.1070704@itechfrontiers.com>
In-Reply-To: <53427577.1070704@itechfrontiers.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 04/07/2014 05:52 AM, Patrick K., ITF wrote:
>
> On 4/7/2014 5:24 AM, dE wrote:
>> Hi!
>>
>> Sorry for the trival question; but on reading various SELinux resources,
>> it appears everyone talks about some 'domain' but no one defines what is
>> it.
>>
>> So I wanna what what is a domain in SELinux.
>>
>>
>> Thank you!
>
> Hello,
>
> Generally a domain is a scope or realm, consisting of related contexts
> in which you define and operate your security components (depending on
> your security model) using a combination of:
>
> SELinux  user, role, type and level (optionally, MLS sensitivity level)
>
>
> Particularly, a domain is also used interchangeably with SELinux "type"
>
> In addition, in RBAC (Role-based security model) to some extent a
> "role" can serve as an intermediary between domains (types) and be
> part of it.
>
> Representations:
>
> SELinux User :  SELinux Role :  SELinux Type :  Sensitivity Level
> unconfined_u :  unconfined_r : unconfined_t  : s0-s0:c0.c1024
>
>
> # ps -eZ
> # ls -laZ
>
>
>
>
> Best Regards,
>
>
I would describe a "Domain" as in SELinux type applied to a process as
opposed to a type  applied to an Object like a file, port, interface,
network ...
