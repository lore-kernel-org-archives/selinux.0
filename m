Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s75EcZOp029305
 for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2014 10:38:35 -0400
Message-ID: <53E0EC57.1000502@redhat.com>
Date: Tue, 05 Aug 2014 10:38:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Harpreet <harpreet20@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Query regarding role hierarchy SELinux
References: <CAOyQjW_ZyKRnt16wwrws7=m=VtAp3dpu_oHHyxHE4=jPaqeu2Q@mail.gmail.com>
In-Reply-To: <CAOyQjW_ZyKRnt16wwrws7=m=VtAp3dpu_oHHyxHE4=jPaqeu2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 08/05/2014 09:01 AM, Harpreet wrote:
>
> Dear Dan Walsh
>   I am doing academic project for providing role based access with
> selinux. Your blog has been of great help as I was new to SELinux.
> I want to define roles hierarchy in my policy file.
> And for that i was using dominance role macro to define hierachies.
> But now i see that dominance macro has been deprecated when i compile
> my policy files.
> Please suggest me any other alternative for "dominance" macro.
>
> Thanks and regards
> Harpreet
>
I am not that familiar with that part of policy.  I would open a
discussion on the selinux mailing list, where more of the RBAC/MLS
people hang out.

selinux@tycho.nsa.gov
