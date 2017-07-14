Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6EMBx9V006275
 for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2017 18:11:59 -0400
Received: from mail-ua0-f174.google.com (mail-ua0-f174.google.com
 [209.85.217.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A27B22CC1
 for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2017 22:11:50 +0000 (UTC)
Received: by mail-ua0-f174.google.com with SMTP id g13so40667564uaj.0
 for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2017 15:11:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170714164647.6183-1-sds@tycho.nsa.gov>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 14 Jul 2017 15:11:28 -0700
Message-ID: <CALCETrXDFOx_obeVRCcE-04CrVtfQHi3mqD1Q31LD-h5006jwQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux-NSA <selinux@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid
 SELinux domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 14, 2017 at 9:46 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> As systemd ramps up enabling NNP (NoNewPrivileges) for system services,
> it is increasingly breaking SELinux domain transitions for those services
> and their descendants.  systemd enables NNP not only for services whose
> unit files explicitly specify NoNewPrivileges=yes but also for services
> whose unit files specify any of the following options in combination with
> running without CAP_SYS_ADMIN (e.g. specifying User= or a
> CapabilityBoundingSet= without CAP_SYS_ADMIN): SystemCallFilter=,
> SystemCallArchitectures=, RestrictAddressFamilies=, RestrictNamespaces=,
> PrivateDevices=, ProtectKernelTunables=, ProtectKernelModules=,
> MemoryDenyWriteExecute=, or RestrictRealtime= as per the systemd.exec(5)
> man page.
>
> The end result is bad for the security of both SELinux-disabled and
> SELinux-enabled systems.  Packagers have to turn off these
> options in the unit files to preserve SELinux domain transitions.  For
> users who choose to disable SELinux, this means that they miss out on
> at least having the systemd-supported protections.  For users who keep
> SELinux enabled, they may still be missing out on some protections
> because it isn't necessarily guaranteed that the SELinux policy for
> that service provides the same protections in all cases.
>
> commit 7b0d0b40cd78 ("selinux: Permit bounded transitions under
> NO_NEW_PRIVS or NOSUID.") allowed bounded transitions under NNP in
> order to support limited usage for sandboxing programs.  However,
> defining typebounds for all of the affected service domains
> is impractical to implement in policy, since typebounds requires us
> to ensure that each domain is allowed everything all of its descendant
> domains are allowed, and this has to be repeated for the entire chain
> of domain transitions.  There is no way to clone all allow rules from
> descendants to their ancestors in policy currently, and doing so would
> be undesirable even if it were practical, as it requires leaking
> permissions to objects and operations into ancestor domains that could
> weaken their own security in order to allow them to the descendants
> (e.g. if a descendant requires execmem permission, then so do all of
> its ancestors; if a descendant requires execute permission to a file,
> then so do all of its ancestors; if a descendant requires read to a
> symbolic link or temporary file, then so do all of its ancestors...).
> SELinux domains are intentionally not hierarchical / bounded in this
> manner normally, and making them so would undermine their protections
> and least privilege.
>
> We have long had a similar tension with SELinux transitions and nosuid
> mounts, albeit not as severe.  Users often have had to choose between
> retaining nosuid on a mount and allowing SELinux domain transitions on
> files within those mounts.  This likewise leads to unfortunate tradeoffs
> in security.
>
> Decouple NNP/nosuid from SELinux transitions, so that we don't have to
> make a choice between them. Introduce a nnp_nosuid_transition policy
> capability that causes the ability to transition under NNP/nosuid to
> be based on a nnp_nosuid_transition permission between the old and new
> contexts rather than typebounds.  Domain transitions can then be allowed
> in policy without requiring the parent to be a strict superset of all of
> its children.
>
> With this change, systemd unit files can be left unmodified from upstream.
> SELinux-disabled and SELinux-enabled users will benefit from retaining any
> of the systemd-provided protections.  SELinux policy will only need to
> be adapted to enable the new policy capability and to allow the
> new permission between domain pairs as appropriate.
>

I'm okay with this, so long as it's very clearly documented that, if
you allow the new transition type from domain A to B, you should
assume that domain A can compromise domain B.  If I get a bug report
complaining that seccomp or whatever allowed compromising a magic nnp
child domain, I will say "no, that's not a bug".

--Andy
