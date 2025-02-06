Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F309225404
	for <selinux@vger.kernel.org>; Thu,  6 Feb 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738830202; cv=none; b=N/jJ+lySmt4pHLxyve/iW1dXk2sEvuObvGiuMiWDyGFLoW0q3FnxhYx/LCnGQxBhgZPfZsGEV/WcuaPu8WD1LfedKJIQ837GHbP18jBH3UHxpW5l6hDBL1YyPNJuKbTQzdoXuXfwrViQ4RhnGKjtImuiPDT7isUA+sx8zH9E7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738830202; c=relaxed/simple;
	bh=kbinpm6EjpVBnHf9D+rZO+K/ZjB874zSSU3l821KiYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=WseZaOmT6BIB/FaLFTFYTT+kHpPbyfkByESqmlzXS33lMShw1vJzeuGbvmBoHqxNlgzDBjG5oIu76X1/TnwJ/j0Bmn+1E3RUtjNMezuDUAIOW5cxISGxzNjT89mfhS8PbCVslMXuQs2xux8oVoow1sugugfgzrRm+0voACPs9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffh285JQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffh285JQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738830199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bSUld+qymXILC7ikHY7pNZeDTjjWVmJiDBZ5aRYDzo=;
	b=ffh285JQzT80IhW/2di+k6gPry4+j08MKb7BvY3lf2JtIiw4V5Zt+r9WEK/pQ4ptpBkuRO
	35c6di23xudLITxojx+YyNXl0HIWl02rWCb5NmJxlMCALmhxucxonny0/n9T2OWotECM2o
	g77NJfTND7Jl9nUHgrfNYXNP6pgzHu8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-eQyjNe0nNTCwSgFLQXc75A-1; Thu, 06 Feb 2025 03:23:17 -0500
X-MC-Unique: eQyjNe0nNTCwSgFLQXc75A-1
X-Mimecast-MFC-AGG-ID: eQyjNe0nNTCwSgFLQXc75A
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f9c1b95ed9so2019502a91.2
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2025 00:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738830196; x=1739434996;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bSUld+qymXILC7ikHY7pNZeDTjjWVmJiDBZ5aRYDzo=;
        b=OowX+0Mdf3rybIJwqZ0EofFLRemeiKO4j8m2D38CLzs4yh1qdfh+/qRmmK80tucaL1
         6xpslawwPG3CRcry9X8X662Qma0XSja4QrBniTJGdr8vMqGXZuz5NyJ24qcFYXY992zX
         S3UmoSxgb9woMiN4NukjHwBc/b4zSjAWOcKi+7/wYdaCQuHF7oGfGNdcenFbCsO5Vek9
         w6T3ew7nfiRuTTyWI+7bdgjYLPdmDeJlXlFKDBSB9ldzpv9ipkSznFXgPiTLRaPWzgNT
         wWTppI0Kdpbm7vMJqoRB/25aOLvT7YGm38feyqsDt2NB/eOpKqsJY7dCgJylnlUgdqxd
         LK0w==
X-Gm-Message-State: AOJu0Yy7MLDrrAtBw3b+QRwk7Or+m/sbdkm1osUmPnE+nd7UI0Wzo7G0
	lrLQaHBHn2AXEn2eIl9LsrjBZPsk9R3PLlD0psbJNL2EbHexy/88p/MqFWtnBGPTD83jW0LLFRX
	LGxdOtWCdI037q1FUhzlHv8v8Ay6N4Y4tizZEAqj09BpCFIi76UDgpiBHPk1NBNoHV1WsEMgfjm
	GGvh1CbWXkpejvFJbX2+39Yb6mfHMYsacWr6wrB+bF
X-Gm-Gg: ASbGncvko6jPimeZR5OdSAftvFpRmIjcDv9Yr3WGZknyj1dJze4VXQq7/67UTGHxePC
	20PCjCBADMt8dwSkpfo7dlXbaEKMcKTWFzWU9tzPfLebNP2JLdDqEHa+MB3xpPP+9Jnj2hE6uFX
	uES1MuKWai0GcCflNDymE=
X-Received: by 2002:a17:90b:5109:b0:2ee:b0b0:8e02 with SMTP id 98e67ed59e1d1-2f9e080f2femr9144072a91.28.1738830195787;
        Thu, 06 Feb 2025 00:23:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExxZbnWfHsPHJu1vNLqrA9jjmaMtKWVlU1yPT8F6VMUIQFp8aBTaWyX3/tbpZzR6U09CqIv/I8eEDuEzfSxSs=
X-Received: by 2002:a17:90b:5109:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2f9e080f2femr9144056a91.28.1738830195517; Thu, 06 Feb 2025
 00:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131152122.1452103-1-omosnace@redhat.com>
In-Reply-To: <20250131152122.1452103-1-omosnace@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 6 Feb 2025 09:23:04 +0100
X-Gm-Features: AWEUYZmNdYvSjg5Rw1KrXe1x9Epcrni646JTmX76uZAtyd5LJjcG7WjeR7QL5pI
Message-ID: <CAFqZXNswtA-ABhv=GOYK9grJROuzyZwnd57ZGZ_OdpSeuLB1fQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: enable MPTCP if it's
 disabled via sysctl
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 4:21=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> In CentOS Stream 10 (and possibly other environments) the
> net.mptcp.enabled sysctl will be set to 0 by default. The testuite
> currently doesn't detect this and hangs when trying to run the MPTCP
> tests. Adjust the test to temporarily enable MPTCP during the test so
> that it can succeed in these conditions.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/inet_socket/test | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tests/inet_socket/test b/tests/inet_socket/test
> index 08c7b1d..ae06ae7 100755
> --- a/tests/inet_socket/test
> +++ b/tests/inet_socket/test
> @@ -91,6 +91,16 @@ sub server_end {
>      system("rm -f $basedir/flag");
>  }
>
> +if ( $proto eq "mptcp" ) {
> +
> +    # Temporarily enable MPTCP if it's disabled by default
> +    $mptcp_enabled =3D `sysctl -n net.mptcp.enabled`;
> +    chomp($mptcp_enabled);
> +    if ( $mptcp_enabled ne "1" ) {
> +        system("sysctl -w net.mptcp.enabled=3D1");
> +    }
> +}
> +
>  # Load NetLabel configuration for full CIPSO/IPv4 labeling over loopback=
.
>  system "/bin/sh $basedir/cipso-fl-load";
>
> @@ -445,4 +455,10 @@ if ($test_calipso) {
>      system "/bin/sh $basedir/calipso-flush";
>  }
>
> +if ( $proto eq "mptcp" and $mptcp_enabled ne "1" ) {
> +
> +    # Reset net.mptcp.enabled if it was 0 before test
> +    system("sysctl -w net.mptcp.enabled=3D0");
> +}
> +
>  exit;
> --
> 2.48.1
>

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/6aba9eb5ba78bcab=
e8abb5e3809f3680dc0403a1

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

