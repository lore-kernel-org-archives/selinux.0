Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KF4Kna027460
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 11:04:20 -0400
Subject: Re: When/how to use "delete" in CIL?
To: Sven Vermeulen <sven.j.vermeulen@gmail.com>, SELinux
 <selinux@tycho.nsa.gov>
References: <CAPzO=NzdEVwf+BZKopVjoi2z2L4=VOnbeGGrbum0Uxe=D_W8qQ@mail.gmail.com>
 <26ba8db8-25a7-f43e-20f0-71ace256f8f3@tresys.com>
 <CAPzO=NzbUm9AE46HtrS8ELcUp2CNkiS00aLE5yj3ddKR-S7_XA@mail.gmail.com>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <9162f94b-9642-fb01-a7e5-58ac8d7077d7@tresys.com>
Date: Mon, 20 Jun 2016 11:04:04 -0400
MIME-Version: 1.0
In-Reply-To: <CAPzO=NzbUm9AE46HtrS8ELcUp2CNkiS00aLE5yj3ddKR-S7_XA@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/20/2016 09:57 AM, Sven Vermeulen wrote:
> On Mon, Jun 20, 2016 at 3:09 PM, Steve Lawrence <slawrence@tresys.com> wrote:
>>> I'm going through the information at
>>> https://github.com/SELinuxProject/cil/wiki to try some new things that
>>> CIL offers. One of the documented "features" is to delete rules from
>>> the final policy using the "(delete ...)" statement.
> [...]
>> Unfortunately, some of the features described in that CIL wiki page
>> (e.g. delete, filter, transform) were never implemented.
>>
>> More up to date documentation is available here:
>>
>> https://github.com/SELinuxProject/selinux/tree/master/secilc/docs
> 
> Thanks for the link to the documentation.
> 
> Are these features something that are still somewhere on the roadmap,
> or should I assume that the current CIL functionality is what it will
> focus on for the foreseeable future?
> 
> I understand that, given its nature, any contribution is more than welcome.

As far as I know, there are no current plans to add those features.
