Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA4ESeQe023546
 for <selinux@tycho.nsa.gov>; Tue, 4 Nov 2014 09:28:40 -0500
Message-ID: <5458E295.7020506@sonymobile.com>
Date: Tue, 4 Nov 2014 15:28:37 +0100
From: peter enderborg <peter.enderborg@sonymobile.com>
MIME-Version: 1.0
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Missing security labels for socket objects?
References: <54526941.3090208@sonymobile.com> <5452702C.2000704@tycho.nsa.gov>
 <54588F41.9050507@sonymobile.com> <5458DC37.50903@tycho.nsa.gov>
In-Reply-To: <5458DC37.50903@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A sysfs tree with both dac and mac control would be nice.

On 11/04/2014 03:01 PM, Stephen Smalley wrote:
> On 11/04/2014 03:33 AM, peter enderborg wrote:
>> Is there any work going on the make it more granular? I did not see
>> it in the "Remaning Work" backlog. It is a generic problem and should
>> have a generic solution.
>
> It is on the new kernel to-do list, at the bottom of new items on:
> https://github.com/SELinuxProject/selinux/wiki/Kernel-Todo
>
> However, I'm not sure what the general solution would look like.  I
> don't think we want to write policies on socket (domain, type, protocol)
> triples or introduce unique security classes for every such triple.  The
> security class abstraction in SELinux (and its underlying Flask
> architecture) is intended to provide a higher level abstraction for
> security policy writers.
>
