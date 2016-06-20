Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KDvPEE016555
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 09:57:25 -0400
Received: by mail-ob0-f172.google.com with SMTP id y7so1311183obt.1
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 06:57:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <26ba8db8-25a7-f43e-20f0-71ace256f8f3@tresys.com>
References: <CAPzO=NzdEVwf+BZKopVjoi2z2L4=VOnbeGGrbum0Uxe=D_W8qQ@mail.gmail.com>
 <26ba8db8-25a7-f43e-20f0-71ace256f8f3@tresys.com>
From: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Mon, 20 Jun 2016 15:57:15 +0200
Message-ID: <CAPzO=NzbUm9AE46HtrS8ELcUp2CNkiS00aLE5yj3ddKR-S7_XA@mail.gmail.com>
Subject: Re: When/how to use "delete" in CIL?
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jun 20, 2016 at 3:09 PM, Steve Lawrence <slawrence@tresys.com> wrote:
>> I'm going through the information at
>> https://github.com/SELinuxProject/cil/wiki to try some new things that
>> CIL offers. One of the documented "features" is to delete rules from
>> the final policy using the "(delete ...)" statement.
[...]
> Unfortunately, some of the features described in that CIL wiki page
> (e.g. delete, filter, transform) were never implemented.
>
> More up to date documentation is available here:
>
> https://github.com/SELinuxProject/selinux/tree/master/secilc/docs

Thanks for the link to the documentation.

Are these features something that are still somewhere on the roadmap,
or should I assume that the current CIL functionality is what it will
focus on for the foreseeable future?

I understand that, given its nature, any contribution is more than welcome.

Wkr,
  Sven Vermeulen
