Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4AC1Okd007532
 for <selinux@tycho.nsa.gov>; Sat, 10 May 2014 08:01:24 -0400
Received: by mail-ee0-f46.google.com with SMTP id t10so3322123eei.19
 for <selinux@tycho.nsa.gov>; Sat, 10 May 2014 05:01:24 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Sat, 10 May 2014 14:00:49 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Victor Porton <porton@narod.ru>
Subject: Re: Refactor installation of policies and modules
Message-ID: <20140510120049.GA6338@siphos.be>
References: <3092401399659544@web23g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <3092401399659544@web23g.yandex.ru>
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, May 09, 2014 at 09:19:04PM +0300, Victor Porton wrote:
> First we need to create a base (entirely permissive) policy for Debian, because the default Debian policy is buggy or may be unwanted in any other reason (as for performance).
> 
> Suppose then I install and configure this permissive policy.
> 
> The next thing I want, is to create a "sandbox" Debian package which installs its own SELinux module. Sandbox should allow running programs with limited filesystem and network access as for usage of untrusted programs downloaded from the Web. It is required for a real project: http://freesoft.portonvictor.org/namespaces.xml (which I may implement as a proxy server which uses the "sandbox" binary from "sandbox" package, probably and/or as a command line program).
> 
> Next, suppose I decide that the default policy is no more buggy and switch the policy.
> 
> What does happen in this case? A disaster! The "sandbox" module installed for the permissive policy is not installed for the default policy. So "sandbox" may not work and allow access of untrusted programs to my files.

Actually, you can perfectly install modules in multiple policy stores so
that, if you switch, then the policy you added is there as well.

> Manual editing of /etc/selinux/config should be deprecated.
> 
> Instead there should be a command which:
> 
> - allows to choose a policy from several installed policies (and also to enable/disable SELinux).
> 
> - when it is requested to change a policy, it should be recompiled with all installed SELinux modules. If compilation fails, the policy should not be changed (a security requirement!) (this may require compilation into a temporary directory before actual installation of the modules)

This is in place already. Some distributions might work differently than
others, but with Gentoo for instance, you can define which policy stores
need to be kept up to date.

See also the "--store" option to semodule.

> When installed, non-base modules should be kept say in /etc/selinux/modules/ so that they could be reinstalled when switching policy.

This isn't always possible. Some policy module binaries are not compatible
with other policy stores, for instance when one policy store has an
MLS-enabled policy and the other one doesn't.

> An other benefit of editing the configuration such as /etc/selinux/config only with a special command, is that the FS can be automatically relabeled when policy is switched or enabled after being disabled.

Relabeling the file system is indeed a long process. But if such a command
would be built, it has to take into account that both mounted file systems
as well as mount points themselves need to be relabeled. Just relabeling the
entire file system like "restorecon -RF /" won't be sufficient.

Wkr,
	Sven Vermeulen
