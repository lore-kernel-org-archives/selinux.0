Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA6IxUd8022173
 for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2014 13:59:30 -0500
Message-ID: <545BC4FE.80507@tresys.com>
Date: Thu, 6 Nov 2014 13:59:10 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux Userspace Release: 20140826-rc5
References: <5451090B.2080107@tresys.com>
 <CAPzO=Nw+JszpR=FoNenH43k4cihg7pnEhecA2MyLzc9qJJcR7A@mail.gmail.com>
In-Reply-To: <CAPzO=Nw+JszpR=FoNenH43k4cihg7pnEhecA2MyLzc9qJJcR7A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/06/2014 01:45 PM, Sven Vermeulen wrote:
> On Oct 29, 2014 4:41 PM, "Steve Lawrence" <slawrence@tresys.com> wrote:
>>
>> The fifth release candidate for the next release of SELinux Userspace
>> [1] is now available.
> [...]
>> Please give this a test and let us know if you find any problems.
> 
> I noticed that the semodule listing command does no longer include the
> module version - instead focus is now on the priority. Is this deliberate?
> 
> Wkr,
>   Sven Vermeulen
> 

Yes, with the move to source policies and high level languages, the
concept of module versions was remove. High level languages may still
provide there own mechanism of module versioning if it makes sense (e.g.
pp modules still have versions in them), but libsemanage no longer uses
these for anything. This is also the reason for deprecating the semodule
--upgrade option.

- Steve
