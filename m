Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5KDA0gn010294
 for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2016 09:10:00 -0400
Subject: Re: When/how to use "delete" in CIL?
To: Sven Vermeulen <sven.vermeulen@siphos.be>, SELinux <selinux@tycho.nsa.gov>
References: <CAPzO=NzdEVwf+BZKopVjoi2z2L4=VOnbeGGrbum0Uxe=D_W8qQ@mail.gmail.com>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <26ba8db8-25a7-f43e-20f0-71ace256f8f3@tresys.com>
Date: Mon, 20 Jun 2016 09:09:03 -0400
MIME-Version: 1.0
In-Reply-To: <CAPzO=NzdEVwf+BZKopVjoi2z2L4=VOnbeGGrbum0Uxe=D_W8qQ@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/19/2016 11:15 AM, Sven Vermeulen wrote:
> Hi all
> 
> I'm going through the information at
> https://github.com/SELinuxProject/cil/wiki to try some new things that
> CIL offers. One of the documented "features" is to delete rules from
> the final policy using the "(delete ...)" statement.
> 
> However, when I try to use that, I always get the failure "Error:
> Unknown keyword delete".
> 
> The test.cil file is pretty simple:
> (delete (allow sysadm_t rsync_etc_t (file (read))))
> 
> ~# semodule -i test.cil
> Error: Unknown keyword delete
> semodule:  Failed!
> 
> I considered that it might only work when it builds everything
> together with secilc, so I tried that as well:
> 
> ~$ secilc -c 29 /var/lib/selinux/mcs/active/modules/400/*/cil test.cil
> Error: Unknown keyword delete
> Failed to compile cildb: -1
> 
> Perhaps this keyword is not part of the final CIL construction? That
> wiki page above is from before it got merged in the main userspace,
> but I didn't find a more up-to-date version of that information.
> 

Unfortunately, some of the features described in that CIL wiki page
(e.g. delete, filter, transform) were never implemented.

More up to date documentation is available here:

https://github.com/SELinuxProject/selinux/tree/master/secilc/docs

- Steve
