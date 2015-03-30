Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2UDHd4C017612
 for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2015 09:17:39 -0400
Message-ID: <55194CD4.2010308@tycho.nsa.gov>
Date: Mon, 30 Mar 2015 09:17:08 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Policy Constraints
References: <1427230458-23667-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhSLgS4pDE3488A7Xm1eqDXnX0R3wFsVSjfxB04ynQzEVA@mail.gmail.com>
 <20150330123706.GA9321@localhost.localdomain>
In-Reply-To: <20150330123706.GA9321@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/30/2015 08:37 AM, Dominick Grift wrote:
> I vaguely recall me touching on the following before. I forgot what, if any, outcome there was. Consider the following:
> 
> I have a constraint like this:
> 
>         (constrain (process (sigchld sigkill sigstop signull signal ptrace
>             getsched setsched getsession getpgid setpgid getcap setcap
>             share getattr setrlimit))
>             (or (or (or (or (or (eq u1 u2)
>                 (eq u1 system_u))
>                 (eq u1 staff_u))
>                 (eq u1 sysadm_u))
>                 (eq u2 system_u))
>                 (neq t1 ubac_constrained_subject_type)))
> 
> The sysadm_u and staff_u identities are supposed to be optional and so I change the above to this:
> 
>         (constrain (process (sigchld sigkill sigstop signull signal ptrace
>             getsched setsched getsession getpgid setpgid getcap setcap
>             share getattr setrlimit))
>             (or (or (or (eq u1 u2)
>                 (eq u1 system_u))
>                 (eq u2 system_u))
>                 (neq t1 ubac_constrained_subject_type)))
> 
>         (optional staff
>             (constrain (process (sigchld sigkill sigstop signull signal ptrace
>                 getsched setsched getsession getpgid setpgid getcap setcap
>                 share getattr setrlimit))
>                     (eq u1 staff_u)))
> 
>         (optional sysadm
>             (constrain (process (sigchld sigkill sigstop signull signal ptrace
>                 getsched setsched getsession getpgid setpgid getcap setcap
>                 share getattr setrlimit))
>                     (eq u1 sysadm_u)))
> 
> The above builds and seinfo shows the three blocks, but for some reason it is not honored. Eg. The First example works but the latter does not.
> 
> Is this a known issue , or known limitation? Should this work?
> 
> We have roleattributes, typeattributes but not identityattributes. Identityattributes would help with this requirement.

I can't speak to the CIL aspects of this, but as far as kernel policy is
concerned, if you write multiple constraints on a single
class/permission, then each constraint must evaluate to true in order
for the permission to be allowed, i.e. they are ANDed, not ORed.
