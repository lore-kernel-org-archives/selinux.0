Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA2FHHlo006105
 for <selinux@tycho.nsa.gov>; Sun, 2 Nov 2014 10:17:17 -0500
Received: by mail-oi0-f43.google.com with SMTP id e131so7721220oig.16
 for <selinux@tycho.nsa.gov>; Sun, 02 Nov 2014 07:17:15 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <5451090B.2080107@tresys.com>
References: <5451090B.2080107@tresys.com>
Date: Sun, 2 Nov 2014 16:17:14 +0100
Message-ID: <CAPzO=NyRKK=jJ151W6xk_cs7dHKJQCwCxoJc2jZmTLZ_DaXPUA@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc5
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Steve Lawrence <slawrence@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Oct 29, 2014 at 4:34 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> The fifth release candidate for the next release of SELinux Userspace
> [1] is now available. The tarballs have been built and can be downloaded
> from the Releases wiki page [2]. Changes since rc4 include:
[...]
> Please give this a test and let us know if you find any problems.

Hi Steve

I notice a regression that I can't quite place yet.

I am running with a policy that does not have the unconfined module
loaded (so a strict environment). In the past (same policy, 2.3
utilities) that also prevented those "unconfined domains" to get their
privileges. For instance, initrc_t does not have the
files_unconfined_type assigned to it.

With the 2.4 series, this attribute is assigned to the domain. I
*think* that it is ignoring the gen_require(`type unconfined_t') that
is in unconfined_domain_noaudit() in the sense that the rules that do
not use unconfined_t are now loaded as well. In the past, this would
ignore the entire block.

Wkr,
  Sven Vermeulen
