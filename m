Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FED25B312
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562891; cv=none; b=iCDVAHNnCf/o4EMwjC7sMyVvG2+oIML6E817rkpEluItEtERelBrh9OdOPfF1MB2yIeh9q5OpkCxtiXaKEXd8n0igCeNMXB4zovp1LlwlDzr9FdQWxdTnRdMDCJr0nkN8/W4kYNZ1vEgN0iZQWNcRsWVinphUSMWZxHa/CiXDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562891; c=relaxed/simple;
	bh=cdkH9ARdKqOefODVdtD+TzfswDDBItas9c3cjP+tDMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwBdzcevY6AYYqf6bH+9duJPqM746DPLzySpPUPTJRpSo1lcUeW9FI9Luhi7LTdU2z/nGNAdScp/KzIz5W98CVP4r6mpI5qp1Y1GXDT4mHy67IaJSnHPiHccheWuF3JeEcwwHgnh/GGXbFNozkfz1IoVWNY8Xg6zeb36wVGEKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqZJJj7e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqZJJj7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749562889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75qfon3NWmXbVK34+QFfpmVsMKuMPAoTdJIWOnlAZ4M=;
	b=UqZJJj7eN6UFsy/HcXcR+fTRxVZ/D6+ezboWMi5D2okGp25q4LLSnmhprM4FjCrHRydM7J
	iRj9zb1Hb6UfIwgLvJVjj9ywIiW29wj2ls8bYs4AhpXarvJVY15aFgM78OA/cZ7GEjkt//
	0F1PP2Di0r1c58mKYdSXlyOWRY1OrMI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-CsO1IYP7Mwmg2CfZUoDmGg-1; Tue, 10 Jun 2025 09:41:26 -0400
X-MC-Unique: CsO1IYP7Mwmg2CfZUoDmGg-1
X-Mimecast-MFC-AGG-ID: CsO1IYP7Mwmg2CfZUoDmGg_1749562886
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b0e0c573531so3359849a12.3
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 06:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749562885; x=1750167685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75qfon3NWmXbVK34+QFfpmVsMKuMPAoTdJIWOnlAZ4M=;
        b=Xb8SPny6veXX2fvrjOdqTFuBrayYqpuFd1lKZ75kh3ttK3ZYjupruC9Rg3kYkcp6V2
         mBEbOvKCbykDqcFk/Qm21rTuhuNQcZokXX8LDWChZrTuqlVgd1/5XQkyi4A3ARuNE3h2
         DiI6DRTKhHa6MB6v0jJv1M6viclCGD3k9DLB+xtiI4y1t+NuCfydL7I3xVTP3KBwIkoa
         FSfDM7NWn6xmQgFCpyGdrLOP8uMUyS2U6x4mgwGdWpGvAry9cUmjfE68O4Wf+erfiKor
         ZOsM5/4X7nPU4Ni3AO16ZxtML9/5nfge6rAGUdOuQxt4kBSF4LFZonVQQPkB88qRb3f6
         rTVQ==
X-Gm-Message-State: AOJu0Yybxe1kLO8n/r8Tj4Fg33TmU7pagZF7eTNncxpPswVcOYh+kjzI
	oTFe8uc0lJAR9+AwDQ2g2bIyGU4rQ8rPedzPSH5zpUPRvfTyB213t2EADcid2mWK2EZTjFkfGhB
	zfOhmxBC56VSeDBlspfZh7TkEdRqHSHz748/n+oe7HwpSkNQXQ9eyc6L4kW8/fi8K6sR0DNkecW
	dfmLjg9Tcpc1dIu0HthVwWrDoy65Ar77Ss1A==
X-Gm-Gg: ASbGnctsTgeEBsI6sE/9rpVE0GOYyJLDnpGN4WXN83wAcxNltb5VYLZH6ZwH4g+yFnE
	6uD7BpcYp08i7IMY08sDKbKXaO//gK58vyRJuGNc8i188G4MxD2Rj6Xu6ZtfWj+mrgVdVcEcq71
	ygbQ==
X-Received: by 2002:a17:90b:28cc:b0:311:fde5:e225 with SMTP id 98e67ed59e1d1-313a157cf8bmr4309123a91.14.1749562885396;
        Tue, 10 Jun 2025 06:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFptg3R8yw68VoblEt05Pb7tj5atIqqWi4y+ctGBba2BAMmpK+TxFjNMU4Pt+BaalxFCws5OLf/fz3Z6pnk5+c=
X-Received: by 2002:a17:90b:28cc:b0:311:fde5:e225 with SMTP id
 98e67ed59e1d1-313a157cf8bmr4309083a91.14.1749562884965; Tue, 10 Jun 2025
 06:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606123615.1029847-1-lautrbach@redhat.com> <20250606123615.1029847-2-lautrbach@redhat.com>
In-Reply-To: <20250606123615.1029847-2-lautrbach@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 10 Jun 2025 15:41:13 +0200
X-Gm-Features: AX0GCFtXlN8ZfbL8uySgHbqgBicju_YpujeQHOpqKPWMNndPB-ZcW6HMkoMZiXE
Message-ID: <CAFqZXNtZCgw1q3RGzoUhJcVkKZBqzs76WBnBBWmLPFvD=RfW=g@mail.gmail.com>
Subject: Re: [PATCH selinux-testsuite v3 2/2] Add tests for checkpoint_restore
 in cap2_userns
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 2:36=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> According to pid_namespaces(7) CAP_CHECK_RESTORE is required to write to
> /proc/sys/kernel/ns_last_pid
> Check whether a process in user and pid namespace is able to write there
> when it has cap2_userns checkpoint_restore allowed.
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
>
> v3 - redirect stderr to stdout
>
>  policy/test_cap_userns.te | 15 +++++++++++++++
>  tests/cap_userns/test     | 36 +++++++++++++++++++++++++++++++++---
>  2 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
> index 6f444871bcf0..402675b2eb7e 100644
> --- a/policy/test_cap_userns.te
> +++ b/policy/test_cap_userns.te
> @@ -4,6 +4,7 @@
>  #
>
>  attribute capusernsdomain;
> +attribute cap2usernsdomain;
>
>  # Domain for process that is allowed non-init userns capabilities
>  type test_cap_userns_t;
> @@ -22,3 +23,17 @@ typeattribute test_no_cap_userns_t capusernsdomain;
>  allow_userns_create(capusernsdomain)
>  # linux >=3D v5.12 needs setfcap to map UID 0
>  allow capusernsdomain self:capability setfcap;
> +
> +# Domain for process that is allowed to use cap_checkpoint_restore
> +type test_cap2_userns_t;
> +testsuite_domain_type(test_cap2_userns_t)
> +typeattribute test_cap2_userns_t cap2usernsdomain;
> +allow test_cap2_userns_t self:cap2_userns checkpoint_restore;
> +
> +# Domain for process that is not to use cap_checkpoint_restore
> +type test_no_cap2_userns_t;
> +testsuite_domain_type(test_no_cap2_userns_t)
> +typeattribute test_no_cap2_userns_t cap2usernsdomain;
> +
> +# Rules common to both domains.
> +kernel_rw_kernel_ns_lastpid_sysctl(cap2usernsdomain)
> diff --git a/tests/cap_userns/test b/tests/cap_userns/test
> index 917da00e4805..ba7b089435be 100755
> --- a/tests/cap_userns/test
> +++ b/tests/cap_userns/test
> @@ -6,15 +6,28 @@ BEGIN {
>      $basedir =3D $0;
>      $basedir =3D~ s|(.*)/[^/]*|$1|;
>
> +    $test_checkpoint =3D 0;
> +
>      if ( -e '/proc/sys/kernel/unprivileged_userns_clone' ) {
>          system(
>              "echo 1 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev=
/null");
>      }
> -    if ( system("$basedir/userns_child_exec -t -U > /dev/null 2>&1") =3D=
=3D 0 ) {
> -        plan tests =3D> 2;
> +    if ( system("$basedir/userns_child_exec -t -U > /dev/null 2>&1") !=
=3D 0 ) {
> +        plan skip_all =3D> "CLONE_NEWUSER not supported";
>      }
>      else {
> -        plan skip_all =3D> "CLONE_NEWUSER not supported";
> +        $test_count =3D 2;
> +
> +        # CAP_CHECKPOINT_RESTORE is supported since 5.9
> +        $kvercur =3D `uname -r`;
> +        chomp($kvercur);
> +
> +        if ( `$basedir/../kvercmp $kvercur 5.9` > 0 ) {
> +            $test_checkpoint =3D 1;
> +            $test_count +=3D 2;
> +        }
> +
> +        plan tests =3D> $test_count;
>      }
>  }
>
> @@ -32,6 +45,23 @@ $result =3D system(
>  );
>  ok($result);
>
> +if ($test_checkpoint) {
> +
> +    # Verify that test_cap2_userns_t can use cap_checkpoint_restore
> +
> +    $result =3D system(
> +"$basedir/userns_child_exec -p -U -M '0 0 1' -G '0 0 1' -- runcon -t tes=
t_cap2_userns_t -- sh -c 'echo 1000 > /proc/sys/kernel/ns_last_pid' 2>&1"
> +    );
> +    ok( $result eq 0 );
> +
> +    # Verify that test_no_cap_userns_t cannot use cap_checkpoint_restore
> +
> +    $result =3D system(
> +"$basedir/userns_child_exec -p -U -M '0 0 1' -G '0 0 1' -- runcon -t tes=
t_no_cap2_userns_t -- sh -c 'echo 1000 > /proc/sys/kernel/ns_last_pid' 2>&1=
"
> +    );
> +    ok($result);
> +}
> +
>  if ( -e '/proc/sys/kernel/unprivileged_userns_clone' ) {
>      system("echo 0 > /proc/sys/kernel/unprivileged_userns_clone 2> /dev/=
null");
>  }
> --
> 2.49.0
>
>

Applied with minor tweaks to make the policy buildable on older
distributions (e.g. RHEL 7):
https://github.com/SELinuxProject/selinux-testsuite/commit/44b6ba364eddeb19=
1893b1ce080357c8b338cf70
https://github.com/SELinuxProject/selinux-testsuite/commit/f24939eedb09dee7=
5962cbee48460b435f59266b

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

