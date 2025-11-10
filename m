Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E2031D750
	for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792927; cv=none; b=Gr6aW/5dQdlxq+nUOZImxJh0HulMJphC4urvMXR7lMtVaWzd+uBU+bZxhNQhV/6u26eERAAuHupkwvkguOsIJphBB6H3L8Wy4TXKl3537L1kIrz0Ov292T7959xpkAb5mRQPSV6JYe65EeK80Defr+/rnLOlSGqDY8GrDArN/Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792927; c=relaxed/simple;
	bh=zyGxe51rJgWHdRl6iTLIq1WFZVGSbT6GS9bJOW7ioBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKmUZ4r0/RwPEVSrKx9Ct0emzrlRbkBvSGgLzjOSywkkRxeqynQpVd/r+R6CrNVNnB4WwzgAtztHz6UuxdWYpzOQxpKxjTC9vN0QNLYFOemwM6f4p0xGGft21qdQmSPO+mLZBDhrEZpybkMmx0f7N3NlxBdi4Q0YgQn2O+uNPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YcRAr8n6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wpp1yAX1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcRAr8n6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wpp1yAX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762792924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VyYspHQMUcTLZk4HKgQ6PYqIj0PNIlI6/6MbeiSzyJY=;
	b=YcRAr8n6xtk5VYpA9dhcdKyZJ8pWZlxhtN9qjnJgcBwkt18olHtqEZHBC2rRvZRWYnZC54
	lJFgCoKIpSlgxpq1z1BsvgGfaRjE6cJ7b99L0vDDmKYeG3BW4gWRyrcaLqkB1oBH8FiGjv
	lSIF9ZomJoOEGIWPBcaZI7hN5La6WqU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-ALj7uoCAP0qysbthMW4r1g-1; Mon, 10 Nov 2025 11:42:02 -0500
X-MC-Unique: ALj7uoCAP0qysbthMW4r1g-1
X-Mimecast-MFC-AGG-ID: ALj7uoCAP0qysbthMW4r1g_1762792922
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2954d676f9dso28225455ad.0
        for <selinux@vger.kernel.org>; Mon, 10 Nov 2025 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762792922; x=1763397722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyYspHQMUcTLZk4HKgQ6PYqIj0PNIlI6/6MbeiSzyJY=;
        b=Wpp1yAX1cpMim1mCD35qaU2AVI+1zBZm0YHRz2YcaP5NIcE55fR1AYsPE7pZb6Rt1P
         O/fZJ087FqCW7lcF4rN3oIYPX5SQNSunzj9OTQ8way/aZ4+KoRKNtVTtGX8i9Ir3Xd2X
         bJAr3Jy8NsuQudXudfGUQ3eHrXHoFYLML2S2m9kAJo/ZuU/ieYI58j899EANqg0HvGuI
         rE65SZB8ZqLqlKU4NZzXDHC0bCwKPk+D0YWQPm3uiqmjvPH2bt4C/gWu28yzfRNByEpH
         9aVc8y6UhuUQohmAg9UVRM+vrE0ZdPFi1nhiF+m3XixPKoIhTRuFiHxF/w5X2UkyftUu
         o07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792922; x=1763397722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VyYspHQMUcTLZk4HKgQ6PYqIj0PNIlI6/6MbeiSzyJY=;
        b=BLS8KqvhSGRFuhz2BXUxihMb0PQpNf51/gNmta7xWpCw0ZVD88PTZbu1xBuHfjSojy
         lAqz9uS4T95WuOZwftKiMbWsTcWQWsnShWXHHPIitOL9QMXsDGf38Zv3jzMwMBzPRLfA
         JVwOyg+F3g6EW2ZJhMCc1UhUonPZtJyvOXYv9gf2bTi78N61QlVpID251XSccl1yXLmh
         j9C9edHViv903oiCSjDK43x71SKhCbdCjPzyh32KhPI2LwNIVcZwTQrUrPr+uac1+8+t
         dSv67MPNDuu1qcYpKjyBueqUQhtA/mfgNlSo6Ey1/QYdjklCvmM8+FSqm0qZX8W4M72o
         5Vtw==
X-Gm-Message-State: AOJu0YzuMTMCCe0zud9WBSeFDtr2n6evYVu7kJEFZmp1Bu+V1ikQ08GM
	rCx65DBblOx+v3L8rUoso+Id0jxcAZ2/KbObIR2ucGM6fZuArIvrZKTJN9BYlAjt04gWtywNVRC
	w/wpegHG3KTmhyTqX4FhU7dtmmytDCvFf0KnS8WwfoYtCE2Q6pFjpoWiy0525Pq8ceEsHktUi4A
	vaL+IgQgS/a6Nipb7qmWZHcv53HpAnduHQpQ==
X-Gm-Gg: ASbGncvnTFmcLuAgkOvlBeo1YAGGUVgmGQWoXtDObPfq6tQh+9C3wU7+i8UcRq8zxWS
	FxT+5LBiXVFQTsiGXqWB3pu3j653ZEtajrBpuS1Ep4YSCW/jHo+iKcBJF3q4So9pr+ETrlwuS12
	qwNVXkJrKEdKGZ/8KEkRerxm1sQyhku2fgaRc3OMUQILDpUhs1fCS7iuiDyaPlKcuqVnfBPOrbY
	AUqAL3LW7LiDRPZ
X-Received: by 2002:a17:903:2409:b0:297:ef11:b504 with SMTP id d9443c01a7336-297ef11b93cmr116523265ad.24.1762792921808;
        Mon, 10 Nov 2025 08:42:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6IMbcjUl/gDpAAauj816aHNc/zpjc00oNDBkfhNOruYWkJUk4GuajT+QU4VXRy7VoY5g7PUpoKriB39zcDTE=
X-Received: by 2002:a17:903:2409:b0:297:ef11:b504 with SMTP id
 d9443c01a7336-297ef11b93cmr116522945ad.24.1762792921396; Mon, 10 Nov 2025
 08:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110145531.69069-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20251110145531.69069-2-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 10 Nov 2025 17:41:49 +0100
X-Gm-Features: AWmQ_bl2mMA1wf1VId33E6C-y0BO8sEWcMOUdRRvoYf5YkxG5LUnoYmACM-jjJI
Message-ID: <CAFqZXNsgs_xPjj2o-AkA9pa_5UBO64omYy03J4EWnpg-jro3YQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: do not modify the allow_domain_fd_use boolean
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 3:56=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Modifying the allow_domain_fd_use boolean value during testsuite
> execution is increasingly triggering breakage on Fedora since its
> policy defaults to 1/true, to the point that you can't ssh or even
> console login to a VM while the testsuite is running or even afterward
> if the testsuite encounters any failures. Instead of modifying this
> boolean, just update the relevant test domains to use the _minimal
> interface so they do not inherit this rule by default and add any
> required allowed rules to them.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  policy/Makefile          | 6 ------
>  policy/test_binder.te    | 3 ++-
>  policy/test_fdreceive.te | 4 +++-
>  policy/test_global.te    | 2 ++
>  policy/test_inherit.te   | 3 ++-
>  5 files changed, 9 insertions(+), 9 deletions(-)

I like this idea! Needs one small tweak to not break running the suite
from sysadm_t, though (see below).

>
> diff --git a/policy/Makefile b/policy/Makefile
> index 520f891..0446f87 100644
> --- a/policy/Makefile
> +++ b/policy/Makefile
> @@ -219,16 +219,10 @@ build: $(TARGETS)
>
>  load: expand_check all
>         # General policy load
> -       @if /usr/sbin/getsebool allow_domain_fd_use 2> /dev/null; then \
> -               /usr/sbin/setsebool allow_domain_fd_use=3D0; \
> -       fi
>         $(SEMODULE) -i test_policy/test_policy.pp $(CIL_TARGETS)
>
>  unload:
>         # General policy unload
> -       @if /usr/sbin/getsebool allow_domain_fd_use 2> /dev/null; then \
> -               /usr/sbin/setsebool allow_domain_fd_use=3D1; \
> -       fi
>         $(SEMODULE) -r test_policy $(subst .cil,,$(CIL_TARGETS))
>
>  clean:
> diff --git a/policy/test_binder.te b/policy/test_binder.te
> index 4c7974a..a267a85 100644
> --- a/policy/test_binder.te
> +++ b/policy/test_binder.te
> @@ -42,7 +42,8 @@ allow test_binder_provider_no_fd_t test_file_t:fifo_fil=
e rw_file_perms;
>  ################################# Client ###############################=
#####
>  #
>  type test_binder_client_t;
> -testsuite_domain_type(test_binder_client_t)
> +# Must use _minimal interface to avoid granting domain fd use permission
> +testsuite_domain_type_minimal(test_binder_client_t)
>  typeattribute test_binder_client_t binderdomain;
>  allow test_binder_client_t test_binder_provider_t:binder { call imperson=
ate };
>  allow test_binder_client_t test_binder_mgr_t:binder { call };
> diff --git a/policy/test_fdreceive.te b/policy/test_fdreceive.te
> index df9e974..805e04e 100644
> --- a/policy/test_fdreceive.te
> +++ b/policy/test_fdreceive.te
> @@ -27,7 +27,9 @@ typeattribute test_fdreceive_client2_t fdreceivedomain;
>  # Can receive fds from client, not from client2.
>  # Can access test file, not second test file.
>  type test_fdreceive_server_t;
> -testsuite_domain_type(test_fdreceive_server_t);
> +# Use the _minimal interface to avoid allowing fd use by default
> +testsuite_domain_type_minimal(test_fdreceive_server_t)
> +allow test_fdreceive_server_t self:unix_stream_socket create_stream_sock=
et_perms;
>  typeattribute test_fdreceive_server_t fdreceivedomain;
>
>  # Grant the necessary permissions for the server domain.
> diff --git a/policy/test_global.te b/policy/test_global.te
> index 0078485..4978993 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -23,6 +23,8 @@ optional_policy(`
>
>         # Transition from the caller to the test domain.
>         allow unconfined_t testsuite_domain:process transition;
> +       # Kill the test domain as needed.
> +       allow unconfined_t testsuite_domain:process sigkill;

This actually needs to be:

allow testsuite_caller_domain testsuite_domain:process sigkill;

...otherwise running the testsuite under sysadm_t becomes broken.

>         role unconfined_r types testsuite_domain;
>         # Report back from the test domain to the caller.
>         allow testsuite_domain unconfined_t:fd use;
> diff --git a/policy/test_inherit.te b/policy/test_inherit.te
> index da26ea3..7e09534 100644
> --- a/policy/test_inherit.te
> +++ b/policy/test_inherit.te
> @@ -22,7 +22,8 @@ typeattribute test_inherit_child_t inheritdomain;
>  # Domain for child process that cannot inherit from parent due to lack
>  # of fd use permission.
>  type test_inherit_nouse_t;
> -testsuite_domain_type(test_inherit_nouse_t)
> +# Use the _minimal interface to avoid allowing fd use by default
> +testsuite_domain_type_minimal(test_inherit_nouse_t)
>  typeattribute test_inherit_nouse_t inheritdomain;
>
>  # Domain for child process that cannot inherit r/w fd to test file
> --
> 2.51.1
>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

