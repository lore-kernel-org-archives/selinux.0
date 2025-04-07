Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653418D649
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034240; cv=none; b=l1VK371NiDA+43dZowdJQFCl/btxX0wZmDRD6PrrQQ8ga4JnkKWCblomDRvRc82LG3amy6ZFePv5aj9X+A8aO8z6SWRupJhe8wl0zYgJexk09zh1W5rSea9Tbt1SM9KlbUP9Qmt/9nMkmfmpMYbfp43Q99K3EmNWnM7PsYWlA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034240; c=relaxed/simple;
	bh=PqPIdlY/2n2j6NUsiEOlE+JVF5qYTbavv5UlRgcALVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBNP7XsGWhy8ly0cACtqy98a+ZAMur0tgnl3Z+r5osN6iasJX/XPnDl8rXgZSnBLrR4gvuCoNsjuafTeTn5NleJLUh9pVbwFBq/omaT7Px3MFy8F7Va8ZH8fdKaoPHyvqdg+rlq3qHhiu7BuSQM9hXEjRKsiccmGEJSFgm/IGS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiAiGnoH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiAiGnoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744034237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhWSn4pBrHgy/oCigv1D+j804DPeDZNDdEV7wD4LG5w=;
	b=PiAiGnoH27UtOV0ybnZbCoiRS3yq6akjFyVre5FHNAg7RYEg+fwP/ABVwiw3hcGBBoXk/L
	cNX6iJrwsaC+qzEbrT5TsFFZBR4F9Kmt3XZ3E6fDUShb7N56eizZOcM542EHIPAeWOegRs
	0Ctsw0fvEAOSsYu87ZqOQdZaGbO8dng=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-4CA6Z4BpMHyjDRda59Vmgw-1; Mon, 07 Apr 2025 09:57:16 -0400
X-MC-Unique: 4CA6Z4BpMHyjDRda59Vmgw-1
X-Mimecast-MFC-AGG-ID: 4CA6Z4BpMHyjDRda59Vmgw_1744034235
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso3310640a91.0
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 06:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744034235; x=1744639035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhWSn4pBrHgy/oCigv1D+j804DPeDZNDdEV7wD4LG5w=;
        b=rt+9trxfaoES5Lt9APNIdbq2xqbNbAMWmfYYfD3tZx0o+DMrx5zk+9gqb8hr5fpBaw
         f6gmKcX1Jt/A6RtoSVj2c/3LSDt8FaOxiLKYgsokAjRz5MMpqa/TKsRNODm6eHuJDrjh
         tidgLMQj8PFDfbf/ynSrbPXtz5MJQtoeMCZ925IbRlvJlu3jBWXWSIPAW9s+rG4SGQHe
         IZAIQ4yr6RuqKvYkG210KWzJCh/kK+yyai+U236oYrC/bKBf7Hi64V1p2zcPw4gxCsha
         /AzE3qQG+yWs04VkbQX3RiqMsUDeX7lGN66uz1UddYCzw/dZjwowhfF8on/2RprxpwIH
         AwPw==
X-Gm-Message-State: AOJu0Yy//JJ7rCaf7UcDSenlMGzdBdhS2TGeBA/WYNTTCK5h5fzuuNek
	/DS9gdjhOZZdTcKwmIPqyyVgUWWswdeVmxeJGPmhX6JwFLGHbb93dZTE4cEX6OpNicYpbm5da3r
	klIXZs1KnUTSp8ChIN55EJahnGxPWf5YZ/UiSiAJpDoi6OtvpXShkC0wuNK/OakjQvwLLiFneXs
	2SvPaj0MRguFIju5QhqHDsABCJFS2lNfR98M3rEd/U
X-Gm-Gg: ASbGncsMMmCtUjEQcqSr66k6qgyHT4+izKYAEX/mDrdEqNqGfWlDXkFF0wbyQ96loOH
	14XiHpgoVzSjwXkAAvaGsr/LEHPjIVKzGqQa+NZ3KuZcPZjkAs+MqhRlQtYtZldqEqBEkYnc=
X-Received: by 2002:a17:90b:540d:b0:2ee:5c9b:35c0 with SMTP id 98e67ed59e1d1-306a4e88e42mr15251164a91.9.1744034234715;
        Mon, 07 Apr 2025 06:57:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8oEPJaxJIrpdHBZ+fmLgpPbzODSZtwEJZqWXXhBG99E3uDlpjXw+GE0XkbD2UNJQIpmfv33vFLT1TF9+8jc0=
X-Received: by 2002:a17:90b:540d:b0:2ee:5c9b:35c0 with SMTP id
 98e67ed59e1d1-306a4e88e42mr15251144a91.9.1744034234445; Mon, 07 Apr 2025
 06:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404133318.9589-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250404133318.9589-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 7 Apr 2025 15:57:03 +0200
X-Gm-Features: ATxdqUH8r9WXR0Eb9nJuZgLZd1wMCV34qxBdHYjhIocfrf30capz0tgBx0Fg5jg
Message-ID: <CAFqZXNsCpCGDbJ46RkwKAnZoc=z+Oa=M38xn457Rmj1FW_Hkwg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/capable_file: fix fsetid test
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 3:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The current test for the SELinux fsetid capability check tries to
> set the setgid bit on a file with a different group ownership and
> compares the file mode before and after to determine success/failure.
> However, for reasons unknown, the current test runs chmod g+rs
> which tries to set both the read bit and setgid bit, and will change
> the read bit if not already set, causing the test to fail if the umask
> doesn't allow group read by default. Fix the test to only run chmod g+s.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  tests/capable_file/test | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/capable_file/test b/tests/capable_file/test
> index 8d0acc9..1b2d1d0 100755
> --- a/tests/capable_file/test
> +++ b/tests/capable_file/test
> @@ -40,7 +40,7 @@ ok( $result eq 0 );
>  # CAP_FSETID
>  $fn   =3D "$basedir/temp_file";
>  $mode =3D ( stat($fn) )[2];
> -system "runcon -t test_fcap_t -- chmod g+rs $basedir/temp_file 2>&1";
> +system "runcon -t test_fcap_t -- chmod g+s $basedir/temp_file 2>&1";
>  $result =3D 1;
>  if ( $mode eq ( stat($fn) )[2] ) {
>      $result =3D 0;
> @@ -82,7 +82,7 @@ ok($result);
>  $fn   =3D "$basedir/temp_file";
>  $mode =3D ( stat($fn) )[2];
>  $result =3D
> -  system "runcon -t test_resfcap_t -- chmod g+rs $basedir/temp_file 2>&1=
";
> +  system "runcon -t test_resfcap_t -- chmod g+s $basedir/temp_file 2>&1"=
;
>  $result =3D 1;
>  if ( $mode eq ( stat($fn) )[2] ) {
>      $result =3D 0;
> --
> 2.47.1
>

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/832fccf1da26bf8f=
ec40b3b7b9b2d80fe51697a6

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

