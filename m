Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAEL9qwn027164
 for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2014 16:09:52 -0500
Received: by mail-oi0-f52.google.com with SMTP id u20so12378301oif.25
 for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2014 13:09:42 -0800 (PST)
MIME-Version: 1.0
Sender: sven.j.vermeulen@gmail.com
In-Reply-To: <5463658D.7050702@tresys.com>
References: <5463658D.7050702@tresys.com>
Date: Fri, 14 Nov 2014 22:09:42 +0100
Message-ID: <CAPzO=NwUXpiQxFSkCjcZ6Z2Oh-q7bC=RSP32dHoF8+0AnGYRbg@mail.gmail.com>
Subject: Re: SELinux Userspace Release: 20140826-rc6
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: Steve Lawrence <slawrence@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 12, 2014 at 2:50 PM, Steve Lawrence <slawrence@tresys.com> wrote:
> The sixth release candidate for the next release of SELinux Userspace
> [1] is now available. The tarballs have been built and can be downloaded
> from the Releases wiki page [2]. Changes since rc5 include:
>
> - updates to pp2cil compiler to mimic 'requires' in CIL, fixing a bug
> that prevented a small set of optional blocks from being correctly
> disabled [4]
> - updates to pp2cil compiler to correctly scope type aliases, fixing a
> bug that causes errors if a type alias referenced a type in a disabled
> optional block [5]
>
> As with the previous rc, action after installing the release candidate
> is required to migrate the policy store from /etc/selinux to
> /var/lib/selinux if it has not already been migrated. Detailed
> information about this process can be found on the Policy Store
> Migration wiki page [3].
>
> Also, because the pp2cil compiler has been updated, any cached CIL
> modules must be rebuilt. This can be done with the --ignore-module-cache
> semodule option.
>
> Please give this a test and let us know if you find any problems.

Hi Steve

As discussed on #selinux a few minutes ago, one of the issues we got
(and I think it is also in rc5, but I'm not sure why I didn't catch
that earlier - might forgot rebuilds or reloads or so) is that some of
the role type assignments (like "role staff_r types xauth_t") which
should result in CIL's "(roletype staff_r xauth_t)" are not being
generated (and hence not used either). As a result, many domains are
not able to transition to other domains (with the "invalid context"
messages in the audit logs as a result).

If you do find this issue and a fix, I can happily apply just this so
we can do more testing before a next version bump.

Wkr,
  Sven Vermeulen
