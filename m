Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3L81A4n004541
 for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2014 04:01:10 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so3302613yha.30
 for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2014 01:01:08 -0700 (PDT)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <5353BC31.3070404@gmail.com>
References: <5353BC31.3070404@gmail.com>
Date: Mon, 21 Apr 2014 10:01:08 +0200
Message-ID: <CAPzO=Nzkn13La7VDcFjCah8CGmhW7R6Vm+zoMFR80DhPNgD3wg@mail.gmail.com>
Subject: Re: Why is SELINUXTYPE policy specific?
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: dE <de.techno@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Apr 20, 2014 at 2:23 PM, dE <de.techno@gmail.com> wrote:
> There are 3 security models in which SELinux can work -- TE, RBAC and MLS.
>
> And there are 6 types of SELinux policies --
>
> targeted, mls, mcs, standard, strict or minimum.
>
> Each security model requires it's own set of policies and the policies can
> be 1 of the 6 types. So can all the 3 security modles and 6 types be
> intermixed? Won't there be conflicts like with MLS and RBAC?

The SELINUXTYPE value should be seen as the name given to a policy
store. The contents (the actual policy, the features it supports, the
fact that it is MLS-enabled or not) have nothing to do with the name
of the store per se. It is just a matter of convenience that policy
stores are named in a particular way so that, cross-distributions,
security administrators can deduce the type and features of the policy
based on the name.

For instance, on RHEL6, "targeted" is the name given to the policy
store that contains an MCS policy with support for unconfined domains.
On Gentoo, this name is rather used for non-MCS policy with support
for unconfined domains.

Afaik, there is no conflict between RBAC and MLS. With MLS, the
SELinux subsystem allows or denies access based on the dominance rules
between the domains' security clearance and the resource sensitivity
level. RBAC instead allows or denies a SELinux role to be associated
with a particular domain.

Wkr,
  Sven Vermeulen
