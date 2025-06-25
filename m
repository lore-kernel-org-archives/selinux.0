Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F38F4A
	for <selinux@vger.kernel.org>; Wed, 25 Jun 2025 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836235; cv=none; b=lpFZ00Lsnmcqqe62+A3r8VXIqH9kLumAlQpQto0WvFOw1qE/fUdmJELYI/4jFsUw1UMAw5BDkUVgQdQOqjhz7KSxXeQaWSs1RoynHbK/rvpAs8GTz3St+9UXMoIDftcUAofTnWTVt9Vg2lSSkQq4oVG1EGpRfRQux+BAcskDkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836235; c=relaxed/simple;
	bh=Map/X6qcjNdzWpVj6xyRE9M8e3e+QNSi7b66Evo7gg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSUK4pt/PwVdEUX5MNX3ZsIQ0r8SyWhufXEjgHTL/TbiVo5Z5qxBsu6vufqlCzHKPk5lxr28z9mhrAZsPrC9DyERRckGw21dMzRPTUDLtmWHL76n61E42iMUBlnpSmaIJPtd/KiNW6/sXUipaIRtUvVU6iy1jZMi3Eu50h5U+Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRBz7Zwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRBz7Zwx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750836233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sBwOQ616ZvfnqVoVfyhhRP4zvvwrJ28fFUG2nlNIVLY=;
	b=PRBz7ZwxEzSm+e4bZAeLbI/fZVu9fX5BakBoC/ZE0K+HknVrjPkm1x29obc3ix+AQMA0Z4
	9nKxbP2VEqdbsvjjWq3u0Uvop3YiEU05dZB+mu4DXfgszTQdWdwim8Y95Cz3zKihZksP4X
	o3yYD5Vjo/IsjxCSU0m8iefNJmzXumk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-EWJNBIuiPdaZHtDjmtziNw-1; Wed, 25 Jun 2025 03:23:51 -0400
X-MC-Unique: EWJNBIuiPdaZHtDjmtziNw-1
X-Mimecast-MFC-AGG-ID: EWJNBIuiPdaZHtDjmtziNw_1750836230
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2356ce66d7cso82239855ad.1
        for <selinux@vger.kernel.org>; Wed, 25 Jun 2025 00:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750836230; x=1751441030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBwOQ616ZvfnqVoVfyhhRP4zvvwrJ28fFUG2nlNIVLY=;
        b=qglLSB0IOc2L/RkWVtCK74M584uIJbQu88DSJZt/Hpm7nrXOmsiOFuVOmTCURgSPYE
         g9z0M43okMdRTQPla/AdmFMnXMGiUEhj9KAddI6VTpPt//XXwUYMyBdt0LHwEEVoOMjb
         w6pG4/Q9PSkN3/3SaMyq4l1Q+n3DgXBlOQhTrCYzNCVD5nD5Bk7anGJYj1sZRKY0qVxx
         3OiRVkua0YltJB8xLMcCYqBRtizZweMDe1OmT4RVN5eOeWG2RIRdMIfrvA+DWochNJOr
         WYSHownxFEf7gx5x8nI+EPnOCWTph748PNIWcJuA8AQ1L1qIEgotWm1YCYPewOUgFMGW
         /b9Q==
X-Gm-Message-State: AOJu0YxbyzeLLIvDnCZxDF23ajVaz1zlEM0hDHosgbt4DWOC3OX7kg3Z
	2PYNlzPtXGo+bBJJoHpl/FS58T+xfqIFHJJ9WTjQlvePLUrsSSmxKwST+qXUXo1iitGtb8qMPAi
	wP8sghhc/kL0yIviQSrlDg42Lhmilv5yUTg096WmVaGKZZYW8Hp5Nb5ggSsyRmxipp207jJOz1Y
	R+Ylg11/Dl+UCIod3OsAwGO79ZTZsHmDPt/61QwA0+70fP
X-Gm-Gg: ASbGnctsVWM0Y5IsdGSQAwsHFLklXAQXqimWhf4mo9obDsEf5+48bpUkTAHVk4/rLYL
	Oa2lQMi154iz4P2txgL9iVn1/u2GdXS2W9otqVlR3Oqsev7qqILYYHzhuFl5uSbP8vrn63YN8d8
	jWVg==
X-Received: by 2002:a17:903:2292:b0:237:ed38:a5b3 with SMTP id d9443c01a7336-23823f98035mr27433475ad.8.1750836229755;
        Wed, 25 Jun 2025 00:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnzdxl5nnFV7ylDZQYMr1X3ZKdW6LzTnlFvn8LYp4CSksto5q1uUCO9E84EKHO82Z5Lvq+W/0r3kZt9xyuRbg=
X-Received: by 2002:a17:903:2292:b0:237:ed38:a5b3 with SMTP id
 d9443c01a7336-23823f98035mr27433405ad.8.1750836229432; Wed, 25 Jun 2025
 00:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624173319.23880-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250624173319.23880-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 25 Jun 2025 09:23:38 +0200
X-Gm-Features: AX0GCFtavcKRkgXPBdBSKlYXSoyWXAXuZlsG_qU8JUCwEs1iGdfww5j05TkwC60
Message-ID: <CAFqZXNswEP1sGhc2O3D7GaL_wZ94RHeHMDZS2W2+mV2Cj+-GMg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/mac_admin: skip all tests on NFS
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 7:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> NFS does not truly support setting / getting of undefined
> contexts. While some of the tests currently pass,
> they trigger kernel error messages like the ones below:
>
> nfs_setsecurity() system_u:object_r:UNDEFINED:s0 31 security_inode_notify=
secctx() -22
> nfs_setsecurity() system_u:object_r:UNDEFINED:s0 31 security_inode_notify=
secctx() -22
> nfs_setsecurity() unconfined_u:object_r:UNDEFINED:s0 35 security_inode_no=
tifysecctx() -22
>
> If we wanted this to work over NFS, we would need further changes to
> the kernel. For now, skip all the mac_admin tests to avoid log spam.
> This is similar to handling in other test scripts like
> tests/capable_file/test.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  tests/mac_admin/test | 38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
>
> diff --git a/tests/mac_admin/test b/tests/mac_admin/test
> index 8ecb48b..973fac3 100755
> --- a/tests/mac_admin/test
> +++ b/tests/mac_admin/test
> @@ -1,17 +1,18 @@
>  #!/usr/bin/perl
>
> -use Test;
> +use Test::More;
>
>  BEGIN {
>      $basedir =3D $0;
>      $basedir =3D~ s|(.*)/[^/]*|$1|;
>
>      $isnfs =3D `stat -f --print %T $basedir`;
> -    if ( $isnfs ne "nfs" ) {
> -        plan tests =3D> 8;
> +
> +    if ( $isnfs eq "nfs" ) {
> +        plan skip_all =3D> "undefined contexts not supported over NFS";
>      }
>      else {
> -        plan tests =3D> 6;
> +        plan tests =3D> 8;
>      }
>  }
>
> @@ -19,18 +20,18 @@ BEGIN {
>  system("rm -f $basedir/test_file; touch $basedir/test_file");
>  $result =3D system(
>      "runcon -t test_mac_admin_t -- chcon -t UNDEFINED $basedir/test_file=
 2>&1");
> -ok( $result, 0 );    # we expect this to succeed.
> +ok( $result eq 0 );    # we expect this to succeed.
>
>  # Verify that test_mac_admin_t sees the undefined context.
>  $result =3D `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_fil=
e 2>&1`;
>  chomp($result);
> -ok( $result, "UNDEFINED" );
> +ok( $result eq "UNDEFINED" );
>
>  # Verify that test_no_mac_admin_t sees the unlabeled context
>  $result =3D
>    `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_file 2>&1`=
;
>  chomp($result);
> -ok( $result, "unlabeled_t" );
> +ok( $result eq "unlabeled_t" );
>
>  # Delete the test file.
>  system("rm -f $basedir/test_file");
> @@ -40,22 +41,17 @@ system("rm -rf $basedir/test_dir");
>  $result =3D system(
>  "runcon -t test_mac_admin_t -- mkdir --context=3Dsystem_u:object_r:UNDEF=
INED:s0 $basedir/test_dir 2>&1"
>  );
> -ok( $result, 0 );    # we expect this to succeed.
> -
> -if ( $isnfs ne "nfs" ) {
> +ok( $result eq 0 );    # we expect this to succeed.
>
> -    # Verify that test_mac_admin_t sees the undefined label value.
> -    $result =3D
> -      `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`=
;
> -    chomp($result);
> -    ok( $result, "UNDEFINED" );
> +# Verify that test_mac_admin_t sees the undefined label value.
> +$result =3D `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir=
 2>&1`;
> +chomp($result);
> +ok( $result eq "UNDEFINED" );
>
> -    # Verify that test_no_mac_admin_t sees the unlabeled context.
> -    $result =3D
> -      `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_dir 2>=
&1`;
> -    chomp($result);
> -    ok( $result, "unlabeled_t" );
> -}
> +# Verify that test_no_mac_admin_t sees the unlabeled context.
> +$result =3D `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_=
dir 2>&1`;
> +chomp($result);
> +ok( $result eq "unlabeled_t" );
>
>  # Delete the test directory
>  system("rm -rf $basedir/test_dir");
> --
> 2.49.0
>

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/a69e30e244e32aba=
ff26472324767039311d703b

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

