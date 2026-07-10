Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F3379C53
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706140; cv=pass; b=nyROKs4q6WZXQ5wg30chC+ujn/meLKBr7VmXi/0faHs4SFzA6gm4+G8gn7VX0xUSLB9XHtk0/aXX9rgRd/AjZCmt2lnq2RhorpYmXilq16GVHnOmx+MlpRWiP3NfvcIog76TlOP+a8Ar+krs7dQVoTQotFGEptBEez0tjn9AB58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706140; c=relaxed/simple;
	bh=vzMhparSDrB2p6c+I2eBm+KqpNcNof7UVzPc5gP4yZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlFqF8Le3TLAOfAaNQhBhnADj32Yq9H5llZNG9FHcwB8+tpWq3b50sYJTULTlOMCDz2rgFuekmErSReLFr5G+rtTyRd5HkC2Zvh/qW9L6IcZtASzrEPP9Of+MLwDXppxvIegtbOJJQ1eUU2TKis/M0Ig43p8+OgtA5WNnkBw3hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnW+7Uvz; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnW+7Uvz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so14847835ad.0
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 10:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783706138; cv=none;
        d=google.com; s=arc-20260327;
        b=ZsebZlVATdnHz4N7vG3PI0eNMuod+U7T/zvEuCFEyNv56rpwhaqpGDkuJZq+FT+t6p
         YJIkmd/ixJHluyPbgzPxnKeygEtPBTyaXA5l+FuoT4aytn/0/IJNR6ufVisKJ36Fwk90
         FUnndsqvOevTfDLww3q3ylBnpct4F+/Ov3uomCWnJ6/7zGyQa4TU2w0/QksTQzSjbQva
         X5e4xdQvAM04RYKBxYKzVuVhbkpdZZrk5YsGQgxknzrNXRJ1kdqzRNDLOC+Zla6MMAbH
         zDRSw61Mj6D27tnDlI8fTvTEaEcFvGOGznm8aWCN8Orx/mGIAycWyWGcyrd5FMrO3gxU
         lHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fUGd4vatW8z7c3zhr5frWaE18kNx3qi6d9tOqDuQ2us=;
        fh=7EGa+Ad4nwVFc/fgrpwqDdoR1x4Q8ILDSj4eyayybjk=;
        b=c1/ZFBM/OvhCCfQ63uUNwuKxBGHgtYyDtKQfLdQ+/8EiFWHRSSb/Hs3l7C3WzeeIBb
         QbH/f3ZLyx3wFSXtNYscEWDFExdnkKfbKFoDwCUcxZOxzPf1wkO7uePxIuJGagTLdq1M
         SlsjFvosIYhoNqY8YmIGfBNiITjDu0tijQDvkenDTayUYyaOiqGESk5SNgYIngepNxUL
         T8yvPrRHmg5v2cTGERU+UllyvaxDEOjNZ7NtErqcVgAtWb8r+siy+Yw1HSgixKTa11FU
         kibF5efn7pNbIpf7lZOtfG2St4gGFoBV2x3TKjsQFvKk4UNRWkKRbFO54fhVQ8v4aOt4
         Ye0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706138; x=1784310938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUGd4vatW8z7c3zhr5frWaE18kNx3qi6d9tOqDuQ2us=;
        b=EnW+7UvzM/Fask7Z1z1es6i6Pornm3iFBUUt0K51c/jFDyZsqlTTnIvdN2SpciaXh6
         MoYqswhVxvrk9fvBqxAE7TlLq78tGHFJLlR+KFnqUpjLMwG0Ae+fWpkgALv9Lf8h+I7E
         rEqW1PohRb2hp/v/M97GAdoDjZGie8cx1A7VBqtiSq94px2iBW8WYFQ1f5D79swwr+jD
         s1o/IgwkqeJHHsK1K/TpHBDPAZDtdVtNTUNPQYTHNk5Pt/oh6tD8d1SS6kbjOhyJiWR7
         o1upku2S/Aq1eYM6cEbbeA1yBBD1qrzVY7X+82p2MYgHghNY3pCWXX35mV0HfyU/HTuB
         f0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706138; x=1784310938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUGd4vatW8z7c3zhr5frWaE18kNx3qi6d9tOqDuQ2us=;
        b=jbL0T9Jbc7/dpeDyAYKi65ciglTEeaBCyBaY5OEsxBBJMRRI5+atubAvj7+Gdf3YJU
         +HdpSSsUMJNcrCtAQv/KrPTPUC8Ojot1IzeNk5H1XaFpYjFFCqygP91+JtqIgtXHQpeb
         VHl4G7PFsoFUTaYpbvsRHR1WdIhOUd0dI/JirK9lFLDCJY72yalXqtKs836Q2YkMvNWo
         hfEgJPJucoFlZ46UFaziiNzenINXnUUdBZmCdkFAOYcF/klQsn1BHIRsqoYrvJzD4gOk
         85qLRsLMOjLk6c7U+Qgm1U7Di1kgeKYlwiKxQMAeWM7TaFvlHkvsyEvmV0mjiiGh6+f7
         AbNw==
X-Gm-Message-State: AOJu0YyVbzv9GtMOBIXIN+TJnFxE8z9rYMEOfpeoXiHNdxpm2xPizrj/
	QoYVD3BYFXOpyh42AbSJDlYgX16j+vuK7Z/m2X7BMpF7hSX0j0j+7Y/yvFOntSHx06ytc0DRpeY
	+59RjY7MOMKDe6DVCMYhpF/+aZlwV78g=
X-Gm-Gg: AfdE7cneseFHwOZ+0Tbt4ZqaW00rK0I5wkwdwXjkWNlj17BWrfTKVkeMTSy9KZ5TgOE
	drPJ0PpCC7RK9GIoghbW7llXLZjnLb5kmkbWkGuGjHwQiM6SrTeOlMhsn5m7FUT2pZvao+0MzhI
	63Yu62HgQSDbQMMG5GXdNo662Z3mr5gRJ4g6soPDUH8mTFf7wwJ6cjmBxVImJsYqUmeU14z5hfA
	dff4jOfOOuDufKHogNY6rbtjeA687f+pLJVYiprexs5xlDyFkpFbuiV28lmnyTeCZ0HVffm/3h1
	ePd79No=
X-Received: by 2002:a17:902:e88b:b0:2cc:df15:91de with SMTP id
 d9443c01a7336-2ce9f15deebmr1880945ad.42.1783706137269; Fri, 10 Jul 2026
 10:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710082514.452700-1-jonderka@redhat.com>
In-Reply-To: <20260710082514.452700-1-jonderka@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Jul 2026 13:55:25 -0400
X-Gm-Features: AVVi8CdAtbZZoGAz5YXzvq6UfHe3ndzT-gPsC1blTQwqZG4nvaUP8bM2zENFpZM
Message-ID: <CAEjxPJ67=Wc6HqAfu9e1J42zV01stN3yrN0r5cKVc1Aw5FegkQ@mail.gmail.com>
Subject: Re: [PATCH] tests: make IPv6 subtests optional on IPv4-only systems
To: Jan Onderka <jonderka@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 4:37=E2=80=AFAM Jan Onderka <jonderka@redhat.com> w=
rote:
>
> Skip or adapt IPv6-dependent subtests when the running system does not
> have usable IPv6 on loopback.
>
> Problem
> -------
> Several subtests assume IPv6 is available: they bind or connect to ::1,
> load ip6tables/nftables IPv6 rules, or create AF_INET6/SCTP IPv6 sockets.
> On IPv4-only systems (for example RHIVOS kernels built without usable
> IPv6, or hosts with net.ipv6.conf.*.disable_ipv6=3D1), these subtests
> hang or fail in ways that block the entire make test run.
>
> Change
> ------
> - Add tests/has_ipv6 helper that checks /proc/net/if_inet6 and the
>   net.ipv6.conf.all/lo.disable_ipv6 sysctls.
> - Wrap IPv6-only cases in inet_socket, extended_socket_class, and sctp
>   Perl tests behind $test_ipv6 / ipv6_enabled() checks and reduce test
>   counts accordingly.
> - Make inet_socket/server.c fall back to AF_INET when IPv6 is absent.
> - Split IPv6 firewall/load script rules into nftables-ipv6.load and only
>   invoke ip6tables/nftables IPv6 setup from load scripts when has_ipv6
>   succeeds.
> - Add ipv6_enabled() to sctp_common for C helpers and SCTP bindx paths.
>
> Justification
> -------------
> IPv6 is optional in many deployment targets. The testsuite should detect
> runtime IPv6 usability and skip only the affected subtests instead of
> assuming ::1 and ip6tables always work. This mirrors how other optional
> features are handled in the tree and keeps the fix self-contained in
> selinux-testsuite.
>
> Testing
> -------
> Verified on RHIVOS (no /proc/net/if_inet6):
>
>   - inet_socket/tcp and inet_socket/udp complete successfully
>   - extended_socket_class IPv6 cases are skipped
>   - make test progresses past former IPv6 hang points
>
> Verified on a host with IPv6 enabled:
>
>   - IPv6 subtests still run and pass
>
> Signed-off-by: Jan Onderka <jonderka@redhat.com>

I haven't looked into the cause yet but this breaks the tests on Fedora 44,
and it also isn't formatted properly via tools/check-syntax -f.

inet_socket/tcp/test ........ 21/34 connect: Connection refused

#   Failed test at inet_socket/tcp/test line 357.
inet_socket/tcp/test ........ 25/34 connect: Operation now in progress
inet_socket/tcp/test ........ 26/34
#   Failed test at inet_socket/tcp/test line 412.
inet_socket/tcp/test ........ 28/34 connect: Operation now in progress
inet_socket/tcp/test ........ 30/34
#   Failed test at inet_socket/tcp/test line 412.
connect: Connection refused

#   Failed test at inet_socket/tcp/test line 454.
connect: Connection refused

#   Failed test at inet_socket/tcp/test line 459.
inet_socket/tcp/test ........ 34/34 # Looks like you failed 5 tests of 34.
inet_socket/tcp/test ........ Dubious, test returned 5 (wstat 1280, 0x500)
Failed 5/34 subtests
inet_socket/udp/test ........ 13/25
#   Failed test at inet_socket/udp/test line 365.
read: Connection refused
inet_socket/udp/test ........ 15/25
#   Failed test at inet_socket/udp/test line 379.
inet_socket/udp/test ........ 17/25 read: Connection refused

#   Failed test at inet_socket/udp/test line 412.

#   Failed test at inet_socket/udp/test line 417.
inet_socket/udp/test ........ 21/25
/home/test/selinux-testsuite/tests/inet_socket/udp/client: no reply
from server
inet_socket/udp/test ........ 22/25
#   Failed test at inet_socket/udp/test line 412.
inet_socket/udp/test ........ 23/25 read: Connection refused

#   Failed test at inet_socket/udp/test line 473.

#   Failed test at inet_socket/udp/test line 479.
# Looks like you failed 7 tests of 25.
inet_socket/udp/test ........ Dubious, test returned 7 (wstat 1792, 0x700)
Failed 7/25 subtests

> ---
>  tests/extended_socket_class/test      | 17 ++++++++++
>  tests/has_ipv6                        | 19 +++++++++++
>  tests/inet_socket/ipsec-load          |  4 +++
>  tests/inet_socket/iptables-flush      |  9 +++--
>  tests/inet_socket/iptables-load       |  5 +++
>  tests/inet_socket/nftables-flush      |  1 -
>  tests/inet_socket/nftables-ipv6-flush |  1 +
>  tests/inet_socket/nftables-ipv6.load  | 35 +++++++++++++++++++
>  tests/inet_socket/nftables-load       | 35 ++-----------------
>  tests/inet_socket/server.c            | 19 ++++++++++-
>  tests/inet_socket/test                | 49 +++++++++++++++++++++------
>  tests/sctp/fb-deny-label-flush        |  5 +++
>  tests/sctp/fb-deny-label-load         |  7 ++++
>  tests/sctp/fb-label-flush             |  5 +++
>  tests/sctp/fb-label-load              |  7 ++++
>  tests/sctp/iptables-flush             |  5 +++
>  tests/sctp/iptables-load              |  9 +++++
>  tests/sctp/nftables-flush             |  1 -
>  tests/sctp/nftables-ipv6-flush        |  1 +
>  tests/sctp/nftables-ipv6.load         | 33 ++++++++++++++++++
>  tests/sctp/nftables-load              | 33 ++----------------
>  tests/sctp/sctp_bindx.c               | 46 +++++++++++++++++--------
>  tests/sctp/sctp_common.c              | 15 ++++++++
>  tests/sctp/sctp_common.h              |  2 ++
>  tests/sctp/sctp_peeloff_server.c      |  2 +-
>  tests/sctp/sctp_server.c              |  2 +-
>  tests/sctp/test                       | 42 +++++++++++++++++++++++
>  27 files changed, 312 insertions(+), 97 deletions(-)
>  create mode 100755 tests/has_ipv6
>  create mode 100644 tests/inet_socket/nftables-ipv6-flush
>  create mode 100644 tests/inet_socket/nftables-ipv6.load
>  create mode 100644 tests/sctp/nftables-ipv6-flush
>  create mode 100644 tests/sctp/nftables-ipv6.load
>
> diff --git a/tests/extended_socket_class/test b/tests/extended_socket_cla=
ss/test
> index 1e6299f..9a6ea16 100755
> --- a/tests/extended_socket_class/test
> +++ b/tests/extended_socket_class/test
> @@ -26,6 +26,17 @@ BEGIN {
>          $test_smc =3D 1;
>      }
>
> +    # Determine if IPv6 is enabled on loopback.
> +    my $testdir =3D $0;
> +    $testdir =3D~ s|(.*)/[^/]*|$1|;
> +    $test_ipv6 =3D system("$testdir/../has_ipv6") =3D=3D 0 ? 1 : 0;
> +    if ( !$test_ipv6 ) {
> +        $test_count -=3D 2;
> +        if ($test_sctp) {
> +            $test_count -=3D 4;
> +        }
> +    }
> +
>      plan tests =3D> $test_count;
>  }
>
> @@ -46,6 +57,8 @@ $result =3D system(
>  );
>  ok($result);
>
> +if ($test_ipv6) {
> +
>  # Verify that test_icmp_socket_t can create an ICMPv6 socket.
>  $result =3D system(
>  "runcon -t test_icmp_socket_t -- $basedir/sockcreate inet6 dgram icmpv6 =
2>&1"
> @@ -57,6 +70,7 @@ $result =3D system(
>  "runcon -t test_no_icmp_socket_t -- $basedir/sockcreate inet6 dgram icmp=
v6 2>&1"
>  );
>  ok($result);
> +}
>
>  # Restore to the kernel defaults - no one allowed to create ICMP sockets=
.
>  system("echo 1 0 > /proc/sys/net/ipv4/ping_group_range");
> @@ -87,6 +101,8 @@ if ($test_sctp) {
>      );
>      ok($result);
>
> +    if ($test_ipv6) {
> +
>      # Verify that test_sctp_socket_t can create an IPv6 stream SCTP sock=
et.
>      $result =3D system(
>  "runcon -t test_sctp_socket_t -- $basedir/sockcreate inet6 stream sctp 2=
>&1"
> @@ -110,6 +126,7 @@ if ($test_sctp) {
>  "runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet6 seqpacket =
sctp 2>&1"
>      );
>      ok($result);
> +    }
>  }
>
>  if ($test_bluetooth) {
> diff --git a/tests/has_ipv6 b/tests/has_ipv6
> new file mode 100755
> index 0000000..21f12e7
> --- /dev/null
> +++ b/tests/has_ipv6
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +#
> +# Return 0 if IPv6 is enabled and usable on loopback, 1 otherwise.
> +#
> +# IPv6 may be absent (ipv6.disable=3D1 on the kernel command line), disa=
bled
> +# globally (net.ipv6.conf.all.disable_ipv6=3D1), or disabled on loopback
> +# (net.ipv6.conf.lo.disable_ipv6=3D1).  Following the LTP tst_net.sh app=
roach,
> +# check /proc/net/if_inet6 and the disable_ipv6 sysctls rather than modu=
le
> +# parameters that may be blocked by SELinux policy.
> +
> +[ -f /proc/net/if_inet6 ] || exit 1
> +
> +disabled=3D$(sysctl -n net.ipv6.conf.all.disable_ipv6 2>/dev/null) || ex=
it 1
> +[ "$disabled" =3D 1 ] && exit 1
> +
> +disabled=3D$(sysctl -n net.ipv6.conf.lo.disable_ipv6 2>/dev/null) || exi=
t 1
> +[ "$disabled" =3D 1 ] && exit 1
> +
> +exit 0
> diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
> index 21e2dfe..e286de3 100644
> --- a/tests/inet_socket/ipsec-load
> +++ b/tests/inet_socket/ipsec-load
> @@ -10,8 +10,12 @@ ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah=
 spi 0x250 ctx $badclientc
>  ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx "sy=
stem_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
>  ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto udp dir out ctx "sy=
stem_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
>
> +SCRIPT_DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +HAS_IPV6=3D"$SCRIPT_DIR/../has_ipv6"
> +if "$HAS_IPV6"; then
>  # IPv6 loopback
>  ip xfrm state add src ::1 dst ::1 proto ah spi 0x200 ctx $goodclientcon =
auth sha1 0123456789012345
>  ip xfrm state add src ::1 dst ::1 proto ah spi 0x250 ctx $badclientcon a=
uth sha1 0123456789012345
>  ip xfrm policy add src ::1 dst ::1 proto tcp dir out ctx "system_u:objec=
t_r:test_spd_t:s0" tmpl proto ah mode transport level required
>  ip xfrm policy add src ::1 dst ::1 proto udp dir out ctx "system_u:objec=
t_r:test_spd_t:s0" tmpl proto ah mode transport level required
> +fi
> diff --git a/tests/inet_socket/iptables-flush b/tests/inet_socket/iptable=
s-flush
> index c168d89..198bb85 100644
> --- a/tests/inet_socket/iptables-flush
> +++ b/tests/inet_socket/iptables-flush
> @@ -1,6 +1,11 @@
>  #!/bin/sh
> +SCRIPT_DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +HAS_IPV6=3D"$SCRIPT_DIR/../has_ipv6"
> +
>  # Flush the security table.
>  iptables -t security -F
> -iptables -t security -X NEWCONN
> +iptables -t security -X NEWCONN 2>/dev/null
> +if "$HAS_IPV6"; then
>  ip6tables -t security -F
> -ip6tables -t security -X NEWCONN
> +ip6tables -t security -X NEWCONN 2>/dev/null
> +fi
> diff --git a/tests/inet_socket/iptables-load b/tests/inet_socket/iptables=
-load
> index 5be94f4..d097ed7 100644
> --- a/tests/inet_socket/iptables-load
> +++ b/tests/inet_socket/iptables-load
> @@ -8,6 +8,9 @@
>  # - Specified the interface since the tests are only performed over loop=
back.
>  # - Set the port number and context to the values used by the test scrip=
t and policy.
>
> +SCRIPT_DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +HAS_IPV6=3D"$SCRIPT_DIR/../has_ipv6"
> +
>  # Flush the security table.
>  iptables -t security -F
>
> @@ -28,6 +31,7 @@ iptables -t security -A OUTPUT -m state --state ESTABLI=
SHED,RELATED -j CONNSECMA
>  iptables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --se=
lctx system_u:object_r:test_server_packet_t:s0
>  iptables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --s=
elctx system_u:object_r:test_server_packet_t:s0
>
> +if "$HAS_IPV6"; then
>  ##### IPv6 entries
>  ip6tables -t security -F
>
> @@ -47,3 +51,4 @@ ip6tables -t security -A OUTPUT -m state --state ESTABL=
ISHED,RELATED -j CONNSECM
>  # Label UDP packets similarly.
>  ip6tables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --s=
elctx system_u:object_r:test_server_packet_t:s0
>  ip6tables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --=
selctx system_u:object_r:test_server_packet_t:s0
> +fi
> diff --git a/tests/inet_socket/nftables-flush b/tests/inet_socket/nftable=
s-flush
> index 7d62b8d..d0fee0c 100644
> --- a/tests/inet_socket/nftables-flush
> +++ b/tests/inet_socket/nftables-flush
> @@ -1,2 +1 @@
>  delete table ip security
> -delete table ip6 security
> diff --git a/tests/inet_socket/nftables-ipv6-flush b/tests/inet_socket/nf=
tables-ipv6-flush
> new file mode 100644
> index 0000000..0c9b69a
> --- /dev/null
> +++ b/tests/inet_socket/nftables-ipv6-flush
> @@ -0,0 +1 @@
> +delete table ip6 security
> diff --git a/tests/inet_socket/nftables-ipv6.load b/tests/inet_socket/nft=
ables-ipv6.load
> new file mode 100644
> index 0000000..6116343
> --- /dev/null
> +++ b/tests/inet_socket/nftables-ipv6.load
> @@ -0,0 +1,35 @@
> +# IPv6 secmark rules for inet_socket tests (loaded only when IPv6 is ena=
bled).
> +
> +add table ip6 security
> +
> +table ip6 security {
> +
> +       secmark inet_server {
> +               "system_u:object_r:test_server_packet_t:s0"
> +       }
> +
> +       map secmapping_in_out {
> +               type inet_service : secmark
> +               elements =3D { 65535 : "inet_server" }
> +       }
> +
> +       chain input {
> +               type filter hook input priority 0;
> +
> +               ct state new meta secmark set tcp dport map @secmapping_i=
n_out
> +               ct state new meta secmark set udp dport map @secmapping_i=
n_out
> +               ct state new ct secmark set meta secmark
> +
> +               ct state established,related meta secmark set ct secmark
> +       }
> +
> +       chain output {
> +               type filter hook output priority 0;
> +
> +               ct state new meta secmark set tcp dport map @secmapping_i=
n_out
> +               ct state established meta secmark set udp dport map @secm=
apping_in_out
> +               ct state new ct secmark set meta secmark
> +
> +               ct state established,related meta secmark set ct secmark
> +       }
> +}
> diff --git a/tests/inet_socket/nftables-load b/tests/inet_socket/nftables=
-load
> index 11ec382..14d6efe 100644
> --- a/tests/inet_socket/nftables-load
> +++ b/tests/inet_socket/nftables-load
> @@ -1,7 +1,8 @@
>  # Based on NFT project example. Requires kernel >=3D 4.20 and nft >=3D 0=
.9.3
> +#
> +# IPv6 rules are in nftables-ipv6.load and loaded only when IPv6 is enab=
led.
>
>  add table ip security
> -add table ip6 security
>
>  table ip security {
>
> @@ -40,35 +41,3 @@ table ip security {
>                 ct state established,related meta secmark set ct secmark
>         }
>  }
> -
> -table ip6 security {
> -
> -       secmark inet_server {
> -               "system_u:object_r:test_server_packet_t:s0"
> -       }
> -
> -       map secmapping_in_out {
> -               type inet_service : secmark
> -               elements =3D { 65535 : "inet_server" }
> -       }
> -
> -       chain input {
> -               type filter hook input priority 0;
> -
> -               ct state new meta secmark set tcp dport map @secmapping_i=
n_out
> -               ct state new meta secmark set udp dport map @secmapping_i=
n_out
> -               ct state new ct secmark set meta secmark
> -
> -               ct state established,related meta secmark set ct secmark
> -       }
> -
> -       chain output {
> -               type filter hook output priority 0;
> -
> -               ct state new meta secmark set tcp dport map @secmapping_i=
n_out
> -               ct state established meta secmark set udp dport map @secm=
apping_in_out
> -               ct state new ct secmark set meta secmark
> -
> -               ct state established,related meta secmark set ct secmark
> -       }
> -}
> diff --git a/tests/inet_socket/server.c b/tests/inet_socket/server.c
> index 63b6849..c4e4432 100644
> --- a/tests/inet_socket/server.c
> +++ b/tests/inet_socket/server.c
> @@ -10,6 +10,8 @@
>  #include <stdio.h>
>  #include <stdbool.h>
>
> +#include <unistd.h>
> +
>  #ifndef SO_PEERSEC
>  #define SO_PEERSEC 31
>  #endif
> @@ -36,6 +38,21 @@ void usage(char *progname)
>         exit(1);
>  }
>
> +static bool ipv6_enabled(void)
> +{
> +       int fd;
> +
> +       if (access("/proc/net/if_inet6", F_OK) !=3D 0)
> +               return false;
> +
> +       fd =3D socket(AF_INET6, SOCK_DGRAM, 0);
> +       if (fd < 0)
> +               return false;
> +
> +       close(fd);
> +       return true;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         int sock, result, opt, sockprotocol, on =3D 1;
> @@ -64,7 +81,7 @@ int main(int argc, char **argv)
>
>         memset(&hints, 0, sizeof(struct addrinfo));
>         hints.ai_flags =3D AI_PASSIVE;
> -       hints.ai_family =3D AF_INET6;
> +       hints.ai_family =3D ipv6_enabled() ? AF_INET6 : AF_INET;
>
>         if (!strcmp(argv[optind], "tcp")) {
>                 hints.ai_socktype =3D SOCK_STREAM;
> diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> index 4cc3852..01acf8a 100755
> --- a/tests/inet_socket/test
> +++ b/tests/inet_socket/test
> @@ -63,6 +63,25 @@ BEGIN {
>          $test_nft =3D 1;
>      }
>
> +    # Determine if IPv6 is enabled on loopback.
> +    $test_ipv6 =3D system("$basedir/../has_ipv6") =3D=3D 0 ? 1 : 0;
> +
> +    if ( !$test_ipv6 ) {
> +        if ($test_ipsec) {
> +            $test_count -=3D 2;
> +        }
> +        if ($test_calipso) {
> +            $test_count -=3D $is_stream ? 3 : 2;
> +            $test_calipso =3D 0;
> +        }
> +        if ($test_iptables) {
> +            $test_count -=3D 2;
> +        }
> +        if ($test_nft) {
> +            $test_count -=3D 2;
> +        }
> +    }
> +
>      plan tests =3D> $test_count;
>  }
>
> @@ -329,7 +348,7 @@ if ($test_ipsec) {
>  "runcon -t test_inet_bad_client_t -- $basedir/client $proto 127.0.0.1 65=
535 2>&1";
>      ok( $result >> 8 eq $fail_value2 );
>
> -    if ($is_stream) {
> +    if ($is_stream && $test_ipv6) {
>
>          # Verify that authorized client can communicate with the server.
>          $result =3D
> @@ -338,15 +357,18 @@ if ($test_ipsec) {
>          ok( $result eq 0 );
>      }
>
> -    # Verify that unauthorized client cannot communicate with the server=
.
> -    $result =3D system
> +    if ($test_ipv6) {
> +
> +        # Verify that unauthorized client cannot communicate with the se=
rver.
> +        $result =3D system
>  "runcon -t test_inet_bad_client_t -- $basedir/client $proto ::1 65535 2>=
&1";
> -    ok( $result >> 8 eq $fail_value2 );
> +        ok( $result >> 8 eq $fail_value2 );
> +    }
>
>      # Kill the server.
>      server_end($pid);
>
> -    if ( not $is_stream ) {
> +    if ( not $is_stream && $test_ipv6 ) {
>
>     # Start the server for IPSEC test using IPv6 but do not request peer =
context.
>          $pid =3D server_start( "-t test_inet_server_t", "-n $proto 65535=
" );
> @@ -382,15 +404,18 @@ sub test_tables {
>  "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer $proto 12=
7.0.0.1 65535 2>&1";
>      ok( $result >> 8 eq $fail_value2 );
>
> -    # Verify that authorized client can communicate with the server.
> -    $result =3D system
> +    if ($test_ipv6) {
> +
> +        # Verify that authorized client can communicate with the server.
> +        $result =3D system
>  "runcon -t test_inet_client_t -- $basedir/client -e nopeer $proto ::1 65=
535";
> -    ok( $result eq 0 );
> +        ok( $result eq 0 );
>
> -    # Verify that unauthorized client cannot communicate with the server=
.
> -    $result =3D system
> +        # Verify that unauthorized client cannot communicate with the se=
rver.
> +        $result =3D system
>  "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer $proto ::=
1 65535 2>&1";
> -    ok( $result >> 8 eq $fail_value2 );
> +        ok( $result >> 8 eq $fail_value2 );
> +    }
>
>      # Kill the server.
>      server_end($pid);
> @@ -406,7 +431,9 @@ if ($test_iptables) {
>  if ($test_nft) {
>      print "Testing nftables (IPv4/IPv6).\n";
>      system "nft -f $basedir/nftables-load";
> +    system "nft -f $basedir/nftables-ipv6.load" if $test_ipv6;
>      test_tables();
> +    system "nft -f $basedir/nftables-ipv6-flush" if $test_ipv6;
>      system "nft -f $basedir/nftables-flush";
>  }
>
> diff --git a/tests/sctp/fb-deny-label-flush b/tests/sctp/fb-deny-label-fl=
ush
> index 059e0b7..41e76e6 100644
> --- a/tests/sctp/fb-deny-label-flush
> +++ b/tests/sctp/fb-deny-label-flush
> @@ -1,6 +1,11 @@
>  #!/bin/sh
>
> +SCRIPT_DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +HAS_IPV6=3D"$SCRIPT_DIR/../has_ipv6"
> +
>  netlabelctl map del default
>  netlabelctl map add default protocol:unlbl
>  netlabelctl unlbl del interface:lo address:127.0.0.0/8 label:system_u:ob=
ject_r:netlabel_sctp_peer_t:s0
> +if "$HAS_IPV6"; then
>  netlabelctl unlbl del interface:lo address:::1/128 label:system_u:object=
_r:deny_assoc_sctp_peer_t:s0
> +fi
> diff --git a/tests/sctp/fb-deny-label-load b/tests/sctp/fb-deny-label-loa=
d
> index 7c0bd87..647399b 100644
> --- a/tests/sctp/fb-deny-label-load
> +++ b/tests/sctp/fb-deny-label-load
> @@ -1,7 +1,14 @@
>  #!/bin/sh
>
> +SCRIPT_DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +HAS_IPV6=3D"$SCRIPT_DIR/../has_ipv6"
> +
>  netlabelctl map del default
>  netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> +if "$HAS_IPV6"; then
>  netlabelctl map add default address:::/0 protocol:unlbl
> +fi
>  netlabelctl unlbl add interface:lo address:127.0.0.0/8 label:system_u:ob=
ject_r:netlabel_sctp_peer_t:s0
> +if "$HAS_IPV6"; then
>  netlabelctl unlbl add interface:lo address:::1/128 label:system_u:object=
_r:deny_assoc_sctp_peer_t:s0
> +fi
> diff --git a/tests/sctp/fb-label-flush b/tests/sctp/fb-label-flush
> index 13573a8..c1ceeb5 100644
> --- a/tests/sctp/fb-label-flush
> +++ b/tests/sctp/fb-label-flush
> @@ -1,6 +1,11 @@
>  #!/bin/sh
>
> +SCRIPT_DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +HAS_IPV6=3D"$SCRIPT_DIR/../has_ipv6"
> +
>  netlabelctl map del default
>  netlabelctl map add default protocol:unlbl
>  netlabelctl unlbl del interface:lo address:127.0.0.0/8 label:system_u:ob=
ject_r:netlabel_sctp_peer_t:s0
> +if "$HAS_IPV6"; then
>  netlabelctl unlbl del interface:lo address:::1/128 label:system_u:object=
_r:netlabel_sctp_peer_t:s0
> +fi
> diff --git a/tests/sctp/fb-label-load b/tests/sctp/fb-label-load
> index a501515..065ec34 100644
> --- a/tests/sctp/fb-label-load
> +++ b/tests/sctp/fb-label-load
> @@ -1,8 +1,15 @@
>  #!/bin/sh
>
> +SCRIPT_DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +HAS_IPV6=3D"$SCRIPT_DIR/../has_ipv6"
> +
>  netlabelctl map del default
>  netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> +if "$HAS_IPV6"; then
>  netlabelctl map add default address:::/0 protocol:unlbl
> +fi
>  netlabelctl unlbl add interface:lo address:127.0.0.0/8 label:system_u:ob=
ject_r:netlabel_sctp_peer_t:s0
> +if "$HAS_IPV6"; then
>  netlabelctl unlbl add interface:lo address:::1/128 label:system_u:object=
_r:netlabel_sctp_peer_t:s0
> +fi
>  #netlabelctl -p unlbl list
> diff --git a/tests/sctp/iptables-flush b/tests/sctp/iptables-flush
> index e74271a..112ae79 100644
> --- a/tests/sctp/iptables-flush
> +++ b/tests/sctp/iptables-flush
> @@ -1,4 +1,9 @@
>  #!/bin/sh
>  # Flush the security table after IPv4 and IPv6 tests.
> +SCRIPT_DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +HAS_IPV6=3D"$SCRIPT_DIR/../has_ipv6"
> +
>  iptables -t security -F
> +if "$HAS_IPV6"; then
>  ip6tables -t security -F
> +fi
> diff --git a/tests/sctp/iptables-load b/tests/sctp/iptables-load
> index 9dac576..1a91e19 100644
> --- a/tests/sctp/iptables-load
> +++ b/tests/sctp/iptables-load
> @@ -1,9 +1,14 @@
>  #!/bin/sh
>  ############################ SECMARK IPTABLE ENTRIES ###################=
#####
>  #
> +SCRIPT_DIR=3D$(CDPATH=3D cd -- "$(dirname -- "$0")" && pwd)
> +HAS_IPV6=3D"$SCRIPT_DIR/../has_ipv6"
> +
>  # Flush the security table first:
>  iptables -t security -F
> +if "$HAS_IPV6"; then
>  ip6tables -t security -F
> +fi
>
>  #-------------- INPUT IP Stream --------------------#
>  # These rules will replace the above context if sctp ports 1024:1035 are=
 found in the packets:
> @@ -11,9 +16,11 @@ iptables -t security -A INPUT -i lo -p sctp -m multipo=
rt --port 1024:1035 -j SEC
>
>  iptables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CO=
NNSECMARK --save
>
> +if "$HAS_IPV6"; then
>  ip6tables -t security -A INPUT -i lo -p sctp -m multiport --port 1024:10=
35 -j SECMARK --selctx system_u:object_r:test_sctp_server_packet_t:s0
>
>  ip6tables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j C=
ONNSECMARK --save
> +fi
>
>  #-------------- OUTPUT IP Stream --------------------#
>  # These rules will replace the above context if sctp ports 1024:1035 are=
 found in the packets:
> @@ -21,7 +28,9 @@ iptables -t security -A OUTPUT -o lo -p sctp -m multipo=
rt --port 1024:1035 -j SE
>
>  iptables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j C=
ONNSECMARK --save
>
> +if "$HAS_IPV6"; then
>  ip6tables -t security -A OUTPUT -o lo -p sctp -m multiport --port 1024:1=
035 -j SECMARK --selctx system_u:object_r:test_sctp_server_packet_t:s0
>
>  ip6tables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j =
CONNSECMARK --save
> +fi
>
> diff --git a/tests/sctp/nftables-flush b/tests/sctp/nftables-flush
> index 7d62b8d..d0fee0c 100644
> --- a/tests/sctp/nftables-flush
> +++ b/tests/sctp/nftables-flush
> @@ -1,2 +1 @@
>  delete table ip security
> -delete table ip6 security
> diff --git a/tests/sctp/nftables-ipv6-flush b/tests/sctp/nftables-ipv6-fl=
ush
> new file mode 100644
> index 0000000..0c9b69a
> --- /dev/null
> +++ b/tests/sctp/nftables-ipv6-flush
> @@ -0,0 +1 @@
> +delete table ip6 security
> diff --git a/tests/sctp/nftables-ipv6.load b/tests/sctp/nftables-ipv6.loa=
d
> new file mode 100644
> index 0000000..1268140
> --- /dev/null
> +++ b/tests/sctp/nftables-ipv6.load
> @@ -0,0 +1,33 @@
> +# IPv6 secmark rules for SCTP tests (loaded only when IPv6 is enabled).
> +
> +add table ip6 security
> +
> +table ip6 security {
> +
> +       secmark sctp_server {
> +               "system_u:object_r:test_sctp_server_packet_t:s0"
> +       }
> +
> +       map secmapping_in_out {
> +               type inet_service : secmark
> +               elements =3D { 1035 : "sctp_server" }
> +       }
> +
> +       chain input {
> +               type filter hook input priority 0;
> +
> +               ct state new meta secmark set sctp dport map @secmapping_=
in_out
> +               ct state new ct secmark set meta secmark
> +
> +               ct state established,related meta secmark set ct secmark
> +       }
> +
> +       chain output {
> +               type filter hook output priority 0;
> +
> +               ct state new meta secmark set sctp dport map @secmapping_=
in_out
> +               ct state new ct secmark set meta secmark
> +
> +               ct state established,related meta secmark set ct secmark
> +       }
> +}
> diff --git a/tests/sctp/nftables-load b/tests/sctp/nftables-load
> index 2cac3bb..56803b6 100644
> --- a/tests/sctp/nftables-load
> +++ b/tests/sctp/nftables-load
> @@ -1,7 +1,8 @@
>  # Based on NFT project example. Requires kernel >=3D 4.20 and nft >=3D 0=
.9.3
> +#
> +# IPv6 rules are in nftables-ipv6.load and loaded only when IPv6 is enab=
led.
>
>  add table ip security
> -add table ip6 security
>
>  table ip security {
>
> @@ -36,33 +37,3 @@ table ip security {
>                 ct state established,related meta secmark set ct secmark
>         }
>  }
> -
> -table ip6 security {
> -
> -       secmark sctp_server {
> -               "system_u:object_r:test_sctp_server_packet_t:s0"
> -       }
> -
> -       map secmapping_in_out {
> -               type inet_service : secmark
> -               elements =3D { 1035 : "sctp_server" }
> -       }
> -
> -       chain input {
> -               type filter hook input priority 0;
> -
> -               ct state new meta secmark set sctp dport map @secmapping_=
in_out
> -               ct state new ct secmark set meta secmark
> -
> -               ct state established,related meta secmark set ct secmark
> -       }
> -
> -       chain output {
> -               type filter hook output priority 0;
> -
> -               ct state new meta secmark set sctp dport map @secmapping_=
in_out
> -               ct state new ct secmark set meta secmark
> -
> -               ct state established,related meta secmark set ct secmark
> -       }
> -}
> diff --git a/tests/sctp/sctp_bindx.c b/tests/sctp/sctp_bindx.c
> index 74bf985..2240404 100644
> --- a/tests/sctp/sctp_bindx.c
> +++ b/tests/sctp/sctp_bindx.c
> @@ -1,4 +1,5 @@
>  #include "sctp_common.h"
> +#include <errno.h>
>
>  static void usage(char *progname)
>  {
> @@ -22,6 +23,7 @@ int main(int argc, char **argv)
>         unsigned short port;
>         bool rem =3D false;
>         bool verbose =3D false;
> +       bool ipv6_bound =3D false;
>         char *context;
>
>         while ((opt =3D getopt(argc, argv, "rv")) !=3D -1) {
> @@ -58,7 +60,7 @@ int main(int argc, char **argv)
>                 free(context);
>         }
>
> -       sock =3D socket(PF_INET6, type, IPPROTO_SCTP);
> +       sock =3D socket(ipv6_enabled() ? PF_INET6 : PF_INET, type, IPPROT=
O_SCTP);
>         if (sock < 0) {
>                 perror("socket");
>                 exit(1);
> @@ -88,27 +90,41 @@ int main(int argc, char **argv)
>         ipv6.sin6_port =3D htons(port);
>         ipv6.sin6_addr =3D in6addr_loopback;
>
> +       if (ipv6_enabled()) {
>         result =3D sctp_bindx(sock, (struct sockaddr *)&ipv6, 1,
>                             SCTP_BINDX_ADD_ADDR);
>         if (result < 0) {
> -               perror("sctp_bindx ADD - ipv6");
> -               close(sock);
> -               exit(3);
> +               if (verbose)
> +                       printf("sctp_bindx ADD - ipv6 not available\n");
> +       } else {
> +               ipv6_bound =3D true;
> +               if (verbose)
> +                       printf("sctp_bindx ADD - ipv6\n");
> +       }
>         }
> -
> -       if (verbose)
> -               printf("sctp_bindx ADD - ipv6\n");
>
>         if (rem) {
> -               result =3D sctp_bindx(sock, (struct sockaddr *)&ipv6, 1,
> -                                   SCTP_BINDX_REM_ADDR);
> -               if (result < 0) {
> -                       perror("sctp_bindx - REM");
> -                       close(sock);
> -                       exit(4);
> +               if (ipv6_bound) {
> +                       result =3D sctp_bindx(sock, (struct sockaddr *)&i=
pv6, 1,
> +                                           SCTP_BINDX_REM_ADDR);
> +                       if (result < 0) {
> +                               perror("sctp_bindx - REM");
> +                               close(sock);
> +                               exit(4);
> +                       }
> +                       if (verbose)
> +                               printf("sctp_bindx REM - ipv6\n");
> +               } else {
> +                       result =3D sctp_bindx(sock, (struct sockaddr *)&i=
pv4, 1,
> +                                           SCTP_BINDX_REM_ADDR);
> +                       if (result < 0) {
> +                               perror("sctp_bindx - REM");
> +                               close(sock);
> +                               exit(4);
> +                       }
> +                       if (verbose)
> +                               printf("sctp_bindx REM - ipv4\n");
>                 }
> -               if (verbose)
> -                       printf("sctp_bindx REM - ipv6\n");
>         }
>
>         close(sock);
> diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
> index d10225c..3adce02 100644
> --- a/tests/sctp/sctp_common.c
> +++ b/tests/sctp/sctp_common.c
> @@ -344,3 +344,18 @@ int handle_event(void *buf, char *cmp_addr, sctp_ass=
oc_t *assoc_id,
>
>         return EVENT_OK;
>  }
> +
> +bool ipv6_enabled(void)
> +{
> +       int fd;
> +
> +       if (access("/proc/net/if_inet6", F_OK) !=3D 0)
> +               return false;
> +
> +       fd =3D socket(AF_INET6, SOCK_DGRAM, 0);
> +       if (fd < 0)
> +               return false;
> +
> +       close(fd);
> +       return true;
> +}
> diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
> index 3a2545a..9f21d3e 100644
> --- a/tests/sctp/sctp_common.h
> +++ b/tests/sctp/sctp_common.h
> @@ -36,3 +36,5 @@ void print_ip_option(int fd, bool ipv4, char *text);
>  int set_subscr_events(int fd, int data_io, int assoc, int addr, int shut=
d);
>  int handle_event(void *buf, char *cmp_addr, sctp_assoc_t *assoc_id,
>                  bool verbose, char *text);
> +
> +bool ipv6_enabled(void);
> diff --git a/tests/sctp/sctp_peeloff_server.c b/tests/sctp/sctp_peeloff_s=
erver.c
> index 3e48df7..e7b33c5 100644
> --- a/tests/sctp/sctp_peeloff_server.c
> +++ b/tests/sctp/sctp_peeloff_server.c
> @@ -59,7 +59,7 @@ int main(int argc, char **argv)
>         if (ipv4)
>                 hints.ai_family =3D AF_INET;
>         else
> -               hints.ai_family =3D AF_INET6;
> +               hints.ai_family =3D ipv6_enabled() ? AF_INET6 : AF_INET;
>
>         /* sctp_peeloff(3) must be from 1 to Many style socket */
>         hints.ai_socktype =3D SOCK_SEQPACKET;
> diff --git a/tests/sctp/sctp_server.c b/tests/sctp/sctp_server.c
> index a7832eb..6edadcf 100644
> --- a/tests/sctp/sctp_server.c
> +++ b/tests/sctp/sctp_server.c
> @@ -74,7 +74,7 @@ int main(int argc, char **argv)
>         if (ipv4)
>                 hints.ai_family =3D AF_INET;
>         else
> -               hints.ai_family =3D AF_INET6;
> +               hints.ai_family =3D ipv6_enabled() ? AF_INET6 : AF_INET;
>
>         if (!strcmp(argv[optind], "stream"))
>                 hints.ai_socktype =3D SOCK_STREAM;
> diff --git a/tests/sctp/test b/tests/sctp/test
> index 5626ab8..1e547a3 100755
> --- a/tests/sctp/test
> +++ b/tests/sctp/test
> @@ -104,6 +104,27 @@ BEGIN {
>              $test_count +=3D 8;
>              $test_nft =3D 1;
>          }
> +
> +        # Determine if IPv6 is enabled on loopback.
> +        $test_ipv6 =3D system("$basedir/../has_ipv6") =3D=3D 0 ? 1 : 0;
> +
> +        if ( !$test_ipv6 ) {
> +            $test_count -=3D 12;
> +
> +            if ($test_calipso) {
> +                $test_count -=3D 13;
> +                if ($test_clpeeloff) {
> +                    $test_count -=3D 6;
> +                }
> +                $test_calipso =3D 0;
> +            }
> +            if ($test_iptables) {
> +                $test_count -=3D 4;
> +            }
> +            if ($test_nft) {
> +                $test_count -=3D 4;
> +            }
> +        }
>      }
>
>      plan tests =3D> $test_count;
> @@ -164,6 +185,8 @@ $result =3D system
>  "runcon -t test_sctp_client_t $basedir/sctp_client $v -n -e nopeer seq 1=
27.0.0.1 1035";
>  ok( $result eq 0 );
>
> +if ($test_ipv6) {
> +
>  # Verify that authorized client can communicate with the server SEQ->STR=
EAM.
>  $result =3D system
>    "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::=
1 1035";
> @@ -174,6 +197,7 @@ ok( $result eq 0 );
>  $result =3D system
>  "runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e nopeer strea=
m ::1 1023 2>&1";
>  ok( $result >> 8 eq 8 );
> +}
>
>  # Kill the stream server.
>  server_end($pid);
> @@ -194,6 +218,7 @@ $result =3D system
>  "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v stream 127.0.0=
.1 1035";
>  ok( $result eq 0 );
>
> +if ($test_ipv6) {
>  $result =3D
>    system
>    "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v seq ::1 1035=
";
> @@ -203,6 +228,7 @@ $result =3D
>    system
>  "runcon -t test_sctp_deny_connectx_t $basedir/sctp_connectx $v seq ::1 1=
035 2>&1";
>  ok( $result >> 8 eq 7 );
> +}
>
>  #
>  ########################### SCTP_SENDMSG_CONNECT #######################=
######
> @@ -215,10 +241,12 @@ $result =3D
>  "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v -n seq 127.0.0=
.1 1035";
>  ok( $result eq 0 );
>
> +if ($test_ipv6) {
>  $result =3D
>    system
>  "runcon -t test_sctp_deny_connectx_t $basedir/sctp_connectx $v -n seq ::=
1 1035 2>&1";
>  ok( $result >> 8 eq 8 );
> +}
>
>  #
>  ################################ BINDX #################################=
######
> @@ -351,6 +379,8 @@ server_end($pid);
>  # Start seq server.
>  $pid =3D server_start( "-t test_sctp_server_t", "sctp_server", "$v seq 1=
035" );
>
> +if ($test_ipv6) {
> +
>  # Verify that authorized client can communicate with the server SEQ->SEQ=
.
>  $result =3D system
>  "runcon -t test_sctp_client_t $basedir/sctp_client $v -e system_u:object=
_r:netlabel_sctp_peer_t:s0 seq ::1 1035";
> @@ -375,6 +405,7 @@ ok( $result >> 8 eq 6 );
>  $result =3D system
>  "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -n -e=
 system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
>  ok( $result >> 8 eq 13 );
> +}
>
>  # Kill the seq server.
>  server_end($pid);
> @@ -396,10 +427,13 @@ $result =3D system
>  "runcon -t test_sctp_client_t $basedir/sctp_client $v -e system_u:object=
_r:netlabel_sctp_peer_t:s0 stream 127.0.0.1 1035";
>  ok( $result eq 0 );
>
> +if ($test_ipv6) {
> +
>  # Verify that the server is denied this association as the client will t=
imeout on connect.
>  $result =3D system
>  "runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e system_u:obj=
ect_r:deny_assoc_sctp_peer_t:s0 stream ::1 1035 2>&1";
>  ok( $result >> 8 eq 6 );
> +}
>
>  # Kill the seq server.
>  server_end($pid);
> @@ -1141,6 +1175,8 @@ sub test_tables {
>  "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e no=
peer stream 127.0.0.1 1035 2>&1";
>      ok( $result >> 8 eq 6 );
>
> +    if ($test_ipv6) {
> +
>   # Verify that authorized client can communicate with the server STREAM-=
>STREAM.
>      $result =3D system
>  "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream :=
:1 1035";
> @@ -1150,6 +1186,7 @@ sub test_tables {
>      $result =3D system
>  "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e no=
peer stream ::1 1035 2>&1";
>      ok( $result >> 8 eq 6 );
> +    }
>
>      # Kill the stream server.
>      server_end($pid);
> @@ -1168,6 +1205,8 @@ sub test_tables {
>  "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e no=
peer seq 127.0.0.1 1035 2>&1";
>      ok( $result >> 8 eq 6 );
>
> +    if ($test_ipv6) {
> +
>      # Verify that authorized client can communicate with the server SEQ-=
>SEQ.
>      $result =3D system
>  "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 =
1035";
> @@ -1177,6 +1216,7 @@ sub test_tables {
>      $result =3D system
>  "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e no=
peer seq ::1 1035 2>&1";
>      ok( $result >> 8 eq 6 );
> +    }
>
>      # Kill the seq server.
>      server_end($pid);
> @@ -1192,7 +1232,9 @@ if ($test_iptables) {
>  if ($test_nft) {
>      print "# Testing nftables (IPv4/IPv6).\n";
>      system "nft -f $basedir/nftables-load";
> +    system "nft -f $basedir/nftables-ipv6.load" if $test_ipv6;
>      test_tables();
> +    system "nft -f $basedir/nftables-ipv6-flush" if $test_ipv6;
>      system "nft -f $basedir/nftables-flush";
>  }
>
> --
> 2.55.0
>
>
