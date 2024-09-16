Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE31804E
	for <selinux@vger.kernel.org>; Mon, 16 Sep 2024 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726491897; cv=none; b=ofSVnAPwAKIb/trBMmMN7szF4Lumdi81aJNDohw7VRw+7EwbLbnq47kZWSM4cfzDpRAuL8R0LLo4mHuRZQ4tjUa8g8qt3uzFTBTiDXBg7GvMfPi49P95O53gpoB06EEt2svu6btmC/Li4S9OqX2WgHbyGbK1TjLz7HY0tmbqNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726491897; c=relaxed/simple;
	bh=JJpb4yAJRPV2vHQXEVK4AlDXd9VKdyYT2pL9CGNB2ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ar/yj55ipqCGRJnDNyKAxbhpFOGI4M8czaU9qb4T/3uXj5vKxXovH9BMbtAulr1je1Ykiq2qB14JX2QLHr56OhV2WH4fkXSoSbq9uRMK32DXi2oWm+Y70nYklDZGud3A0zvUFBFlZzvjEgJBu2qheb5TazIQB+KQGDPoxba78y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng9VtiuS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng9VtiuS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so2894457a12.3
        for <selinux@vger.kernel.org>; Mon, 16 Sep 2024 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726491894; x=1727096694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GLRBXIpRtMUUnHM7zMx2xuGyi1Xg4Qrk4pPEwc+h7U=;
        b=ng9VtiuSESDQx+4M8vB0ABUGuNWW9x6N7s/a4Gkjk5soXqwmgemuzVs5gtMACfYZrY
         tD8OjdUymUAJ2TZJdj0i1W5dw8Bmd7hQRTsYYrkr2cfu1gXQ7yOTDb3eLqbEJE0HDBYz
         pwwIVspHhXO96cPq8WZ0+KH3bZJxXToZcNxVJzOqAlstfCspieslhmq34jl0qQODVCnT
         0zxcI4cnz2fdAEeVm17JJ3+wlApY9RcX7WQdE5UmCh0ykDAteMc7UA2nDQHH25Drw0Gh
         2Iid2ked5zN3cu2BaiEdOL9IzGlCH/NWGjoTG3FHpd2nJxFxBAKrGJx87DzCCnnUlsMG
         rKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726491894; x=1727096694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GLRBXIpRtMUUnHM7zMx2xuGyi1Xg4Qrk4pPEwc+h7U=;
        b=JmKc8lv+EOQR1HSh5NIgnBuSDsQ3mdr+yECaIZqYmfkMNmKLjO2bSgzQ1flSAJCd7Y
         4hQuMaeLTXnYqY17M8ZnCgJDD4+411cNNK0tBD2GmSXKt1mGSdfAkwRfgD+0wp+y6ktC
         ZcJ25cHHnd4q2Y2CNGwhuphENkp0hp6fzCGn1qLGMUd1idcV115G4LlkIkxXT435N82Q
         xKTczfQyPxr55XmRHph2Tiy0mWKgRGUZQ/7h2ALWC3h3p9+X1ZcERd0zGE+DUyFKOtqr
         sDFVIqrNd1AkWyb4LydM19B2GicZIVXE/My3kqm+gPsinMMf7tMRFIeW05+B/R4XHTMk
         NpNg==
X-Gm-Message-State: AOJu0YwY8sI2VrMaDWaK42JXeh1TgsLT9z4iBYhFwQW5VzODdCNdxLVK
	1D+zAjzhI7pgp2hIBBHpcz0VWIRTlErKQZhsDRoVc2f+EExdFsO+OgdjqTn5dPR1Wj5DDIAFoUf
	N8kc5jqIpFSpUVHn9W4N26snGSgBIVg==
X-Google-Smtp-Source: AGHT+IFnKwOZYu9jejzWp/ZqHLkAoIeRjQR9V9s6e3xWFjSQVG+ENCzxNvzaqbJIWO9nm1dS+M1mZgeDu0OY8I/lvYI=
X-Received: by 2002:a17:90a:4b88:b0:2da:8c28:6561 with SMTP id
 98e67ed59e1d1-2db9ffb41ccmr17572426a91.22.1726491894013; Mon, 16 Sep 2024
 06:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828195755.19385-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20240828195755.19385-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 16 Sep 2024 09:04:42 -0400
Message-ID: <CAEjxPJ4MH_r36Oy4K1Mcg4isGRQ+TC3Yr86DJV9fFOe3oddmLw@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy,tests: add tests for netlink xperms
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com, tweek@google.com, 
	brambonne@google.com, jeffv@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 4:00=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Add tests for netlink xperms. Test program is based on an earlier test
> program for netlink_send checking by Paul Moore. Exercising these
> tests depends on the corresponding kernel patch, userspace patches,
> and updating the base policy to define the new nlmsg permissions
> and to enable the new netlink_xperm policy capability.
>
> For testing purposes, you can update the base policy by manually
> modifying your base module and tweaking /usr/share/selinux/devel
> (latter only required due to writing the test policy as a .te file
> rather than as .cil in order to use the test macros) as follows:
>     sudo semodule -c -E base
>     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" base.cil
>     sudo semodule -i base.cil
>     echo "(policycap netlink_xperm)" > netlink_xperm.cil
>     sudo semodule -i netlink_xperm.cil
>     sudo sed -i.orig "s/nlmsg_read/nlmsg nlmsg_read/" \
>         /usr/share/selinux/devel/include/support/all_perms.spt
>
> When finished testing, you can semodule -r base netlink_xperm to
> undo the two module changes and restore your all_perms.spt file
> from the saved .orig file.
>
> NB The above may lead to unexpected denials of the new nlmsg permission
> for existing domains on your system and prevent new ssh sessions from
> being created. Recommend only inserting the netlink_xperm.cil module
> just prior to running the testsuite and removing immediately thereafter.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Now that the kernel and userspace patches have been accepted, can we
get this testsuite patch merged please? The test will only be enabled
when the underlying policy defines the new nlmsg permission and
enables the new netlink_xperm policy capability, so it won't break
anything in the interim. We will need to separately submit a patch for
refpolicy and/or Fedora policy to add these.



> ---
>  policy/Makefile        |  5 +++++
>  policy/test_nlmsg.te   | 34 ++++++++++++++++++++++++++++
>  tests/Makefile         |  5 +++++
>  tests/nlmsg/.gitignore |  1 +
>  tests/nlmsg/Makefile   |  5 +++++
>  tests/nlmsg/nlmsg.c    | 50 ++++++++++++++++++++++++++++++++++++++++++
>  tests/nlmsg/test       | 28 +++++++++++++++++++++++
>  7 files changed, 128 insertions(+)
>  create mode 100644 policy/test_nlmsg.te
>  create mode 100644 tests/nlmsg/.gitignore
>  create mode 100644 tests/nlmsg/Makefile
>  create mode 100644 tests/nlmsg/nlmsg.c
>  create mode 100755 tests/nlmsg/test
>
> diff --git a/policy/Makefile b/policy/Makefile
> index f18e15d..32d7ede 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -158,6 +158,11 @@ TARGETS +=3D test_userfaultfd.te
>  endif
>  endif
>
> +# nlmsg test dependencies: policy >=3D 30, nlmsg permission, netlink_xpe=
rm capability
> +ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] =
&& [ -f /sys/fs/selinux/class/netlink_route_socket/perms/nlmsg ] && grep -q=
 1 $(SELINUXFS)/policy_capabilities/netlink_xperm && echo true),true)
> +TARGETS +=3D test_nlmsg.te
> +endif
> +
>  ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
>  TARGETS:=3D$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te,=
 $(TARGETS))
>  endif
> diff --git a/policy/test_nlmsg.te b/policy/test_nlmsg.te
> new file mode 100644
> index 0000000..9e1e2a4
> --- /dev/null
> +++ b/policy/test_nlmsg.te
> @@ -0,0 +1,34 @@
> +########################################
> +#
> +# Policy for testing the nlmsg extended permissions.
> +
> +define(`RTM_GETLINK', `18')
> +define(`RTM_SETLINK', `19')
> +define(`RTM_GETADDR', `22')
> +
> +attribute nlmsgtestdomain;
> +
> +# Domain that is allowed the nlmsg extended permissions.
> +type test_nlmsg_xperm_t;
> +typeattribute test_nlmsg_xperm_t nlmsgtestdomain;
> +testsuite_domain_type(test_nlmsg_xperm_t)
> +allow test_nlmsg_xperm_t self:netlink_route_socket create_socket_perms;
> +# Also allow the legacy nlmsg_read/write permissions to ensure no false =
positives.
> +allow test_nlmsg_xperm_t self:netlink_route_socket { nlmsg nlmsg_read nl=
msg_write };
> +allowxperm test_nlmsg_xperm_t self:netlink_route_socket nlmsg { RTM_GETL=
INK RTM_SETLINK RTM_GETADDR };
> +
> +# Domain that is not allowed the nlmsg extended permissions.
> +type test_nlmsg_noxperm_t;
> +typeattribute test_nlmsg_noxperm_t nlmsgtestdomain;
> +testsuite_domain_type(test_nlmsg_noxperm_t)
> +allow test_nlmsg_noxperm_t self:netlink_route_socket create_socket_perms=
;
> +# Also allow the legacy nlmsg_read/write permissions to ensure no false =
positives.
> +allow test_nlmsg_noxperm_t self:netlink_route_socket { nlmsg nlmsg_read =
nlmsg_write };
> +allowxperm test_nlmsg_noxperm_t self:netlink_route_socket nlmsg ~{ RTM_G=
ETLINK RTM_SETLINK RTM_GETADDR };
> +
> +#
> +# Common rules for all nlmsg test domains.
> +#
> +
> +# Trigger kernel module auto-loading of the protocol implementations.
> +kernel_request_load_module(nlmsgtestdomain)
> diff --git a/tests/Makefile b/tests/Makefile
> index db4cb38..35bb358 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -153,6 +153,11 @@ ifneq ($(shell ./kvercmp $$(uname -r) 6.5),-1)
>  SUBDIRS +=3D inet_socket/mptcp
>  endif
>
> +# nlmsg test dependencies: policy >=3D 30, nlmsg permission, netlink_xpe=
rm capability
> +ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] =
&& [ -f /sys/fs/selinux/class/netlink_route_socket/perms/nlmsg ] && grep -q=
 1 $(SELINUXFS)/policy_capabilities/netlink_xperm && echo true),true)
> +SUBDIRS +=3D nlmsg
> +endif
> +
>  ifeq ($(DISTRO),RHEL4)
>      SUBDIRS:=3D$(filter-out bounds dyntrace dyntrans inet_socket mmap nn=
p_nosuid overlay unix_socket, $(SUBDIRS))
>  endif
> diff --git a/tests/nlmsg/.gitignore b/tests/nlmsg/.gitignore
> new file mode 100644
> index 0000000..d4bea66
> --- /dev/null
> +++ b/tests/nlmsg/.gitignore
> @@ -0,0 +1 @@
> +nlmsg
> diff --git a/tests/nlmsg/Makefile b/tests/nlmsg/Makefile
> new file mode 100644
> index 0000000..1edab98
> --- /dev/null
> +++ b/tests/nlmsg/Makefile
> @@ -0,0 +1,5 @@
> +TARGETS=3Dnlmsg
> +
> +all: $(TARGETS)
> +clean:
> +       rm -f $(TARGETS)
> diff --git a/tests/nlmsg/nlmsg.c b/tests/nlmsg/nlmsg.c
> new file mode 100644
> index 0000000..a976b95
> --- /dev/null
> +++ b/tests/nlmsg/nlmsg.c
> @@ -0,0 +1,50 @@
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <asm/types.h>
> +#include <sys/socket.h>
> +#include <linux/netlink.h>
> +#include <linux/rtnetlink.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       int i, rc;
> +       int fd;
> +       unsigned char data[512];
> +       struct nlmsghdr *nh[3];
> +       struct sockaddr_nl sa;
> +       struct iovec iov;
> +       struct msghdr msg;
> +
> +       memset(&sa, 0, sizeof(sa));
> +       sa.nl_family =3D AF_NETLINK;
> +
> +       memset(data, 0, sizeof(data));
> +       iov.iov_base =3D data;
> +       iov.iov_len =3D 3 * NLMSG_SPACE(0);
> +
> +       for (i =3D 0; i < 3; i++) {
> +               nh[i] =3D (struct nlmsghdr *)(data + (i * NLMSG_SPACE(0))=
);
> +               nh[i]->nlmsg_len =3D NLMSG_HDRLEN;
> +       }
> +       nh[0]->nlmsg_type =3D RTM_GETLINK; // nlmsg_read
> +       nh[1]->nlmsg_type =3D RTM_SETLINK; // nlmsg_write
> +       nh[2]->nlmsg_type =3D RTM_GETADDR; // nlmsg_read
> +
> +       memset(&msg, 0, sizeof(msg));
> +       msg.msg_name =3D &sa;
> +       msg.msg_namelen =3D sizeof(sa);
> +       msg.msg_iov =3D &iov;
> +       msg.msg_iovlen =3D 1;
> +
> +       fd =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> +       rc =3D sendmsg(fd, &msg, 0);
> +
> +       if (rc < 0) {
> +               perror("sendmsg");
> +               exit(-1);
> +       }
> +       exit(0);
> +}
> +
> diff --git a/tests/nlmsg/test b/tests/nlmsg/test
> new file mode 100755
> index 0000000..18bb794
> --- /dev/null
> +++ b/tests/nlmsg/test
> @@ -0,0 +1,28 @@
> +#!/usr/bin/perl
> +#
> +# This test exercises the netlink extended perms support
> +#
> +
> +use Test;
> +
> +BEGIN {
> +    $test_count =3D 2;
> +    plan tests =3D> $test_count;
> +}
> +
> +$basedir =3D $0;
> +$basedir =3D~ s|(.*)/[^/]*|$1|;
> +
> +#
> +# Attempt to send the netlink messages from the allowed domain.
> +#
> +$result =3D system "runcon -t test_nlmsg_xperm_t -- $basedir/nlmsg 2>&1"=
;
> +ok( $result, 0 );
> +
> +#
> +# Attempt to send the netlink messages from the not-allowed domain.
> +#
> +$result =3D system "runcon -t test_nlmsg_noxperm_t -- $basedir/nlmsg 2>&=
1";
> +ok($result);
> +
> +exit;
> --
> 2.40.1
>
