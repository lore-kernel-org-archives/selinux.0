Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B12045B7
	for <selinux@vger.kernel.org>; Mon, 29 Sep 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136257; cv=none; b=mjiBHkbllhPW0IyGN1mK1GZx92NHI+60dzlHFRF9+ePh2UIyAZnSy6XfoPPWDtXKCs4tA614keN28cNznsJAx4hHwoL6p8aslWT9dCMvtlOIn4rSlhN6j2XnvfZmSCCAPsIhMityKZfbFRlh44hxGhZWWdwJk4wz672UyTEwpCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136257; c=relaxed/simple;
	bh=HqBEsMLC8vEhjtSYC7eNTa0IPUZmvmIR8WKUJUK0NCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKEEhbvpBt283NBrH5wzxS4ZMYE7u3l+Wqv2jj2IuGdjWJ+uA/jzPNoEU1UfUNRLXctq08RYdHnmP98Wr36MWCe4hkjtNYUj8aHSdf840AblmRXScqvYtKKCFvxYilYbaobzYqad2YR3m2yzz5uRkkl48gXtnmU4UuUmoIfQh3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPsrbp41; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPsrbp41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759136254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmKF6Ul49dvvRnQkVOrVO2X4NrqfNSLRmm/oHYIkxHA=;
	b=iPsrbp41JsS2y44kQvTDI7uKhl9e1gbwbp31k6lUKXcvVFGciWJ+aG8mCCx0wH5As3ciLw
	kohay5wZLv3YHLIjfDbob0DAnDZlqb87/lCGvCteAOksZ2NBIuXrHdk52LYMzxoBqUDOk5
	KoTfmZoS3JMGexM/cDxUXF9T7IwdCA8=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-9AxXsNRKMyicf66XQ1mvrA-1; Mon, 29 Sep 2025 04:57:32 -0400
X-MC-Unique: 9AxXsNRKMyicf66XQ1mvrA-1
X-Mimecast-MFC-AGG-ID: 9AxXsNRKMyicf66XQ1mvrA_1759136252
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6360e9f4efaso5596526d50.3
        for <selinux@vger.kernel.org>; Mon, 29 Sep 2025 01:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759136252; x=1759741052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmKF6Ul49dvvRnQkVOrVO2X4NrqfNSLRmm/oHYIkxHA=;
        b=czrk4DmGjc6kem2IZuOUWqXx/gMkTU/31zYTxxvgCawwPNTTDZqypLkoR0kS+JZmgg
         MpuvtBtgVpKHwp7QyBPuGZABzf82F1E/+0WHBRlNvZJ8wLEHfo9zTC1RU5ksGfL4vK9k
         KlB+KgwWAZvHfBzgVrc/eyB5vfR+UwI75mBgRcjNROmBr2vH6V4dL90KlTag02MQEtRC
         D5jFbbih9S16br9eafogS45N8Pyyc+5+AmsoLV5acWPm5rIoThOLSu8iRVNxlb/kLPmX
         bjUYvBRA+owBHlTGTVnX/CV4pZ8HsT9LVk0n/eTIXK2MKYWpQRAxzpDNBwlwTLLO9YtD
         hobw==
X-Gm-Message-State: AOJu0YwYweF+rUEMMJEk20obSBdvwe1P9cdyOh42aWnHLLaa/MzNJKFo
	KqjeHlBH3vpGKXqO2/P5hk5a+96tL6BuNF3furLQ8En8hNydQZj7EzQuP8k/WWvyYumHOm28AhH
	o8p7f1Xo0nYH6MPJ0WMlzlztYrl/03cM5fi7HrEUtdDbHVYeRoxAqdsdj6vevuNYPs17hSbXNQq
	LAmzjLJE2b1ie9SSKwRGTVpmtrlLDvOJCJ4E+dr27VZrjK
X-Gm-Gg: ASbGncv3Rx7LTeIZo1bnG0R9oD1+nbbRJuijWkpLYs7gN32q6Z15PuT754SOVozOrqk
	yOiJLvX++fRYntBIaaLeb9sidAbre5NQo8HoeOIH+g0aFJX8gjkC+Uh2DllpzPaKHpVglLuZ4u5
	pmBejclmVN6fmvE96aC5o6nUtDNZdbw38VngM81xYuK55DX8OgtQXO0Q==
X-Received: by 2002:a05:690e:2411:b0:635:4ecd:5fd1 with SMTP id 956f58d0204a3-6361a89b63fmr12768145d50.46.1759136251938;
        Mon, 29 Sep 2025 01:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEixXLn2mjx4D416XeE9Dc0/klLawqP60FugEA6EYE2gotCX/96GQqqNykVKIT+9pqKNS1SuNdT8KFoYYhPL8k=
X-Received: by 2002:a05:690e:2411:b0:635:4ecd:5fd1 with SMTP id
 956f58d0204a3-6361a89b63fmr12768133d50.46.1759136251584; Mon, 29 Sep 2025
 01:57:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJp=TCGK-KUja2M9kxt5_SXC8P2=WSxN_-VjFJa96Luc2JSmCA@mail.gmail.com>
In-Reply-To: <CAJp=TCGK-KUja2M9kxt5_SXC8P2=WSxN_-VjFJa96Luc2JSmCA@mail.gmail.com>
From: Pranav Lawate <plawate@redhat.com>
Date: Mon, 29 Sep 2025 14:26:55 +0530
X-Gm-Features: AS18NWDNwGdgVd6m0tdy5c9AcyFRA0bpR5kK2Tkakf7IgUyWd9six-U42LyUTpg
Message-ID: <CAJp=TCGo=dNMi65xc89p8Oiyn2ecuLAL_5rQz38J8Lhij1D_pQ@mail.gmail.com>
Subject: Re: [PATCH] semanage man pages: Add examples for -r RANGE flag usage
To: selinux@vger.kernel.org
Cc: Pranav Lawate <pran.lawate@gmail.com>, Vit Mojzis <vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

This is a gentle reminder mail to check if there was any progress.
It's been around 17 days now, just wanted to check if someone has time
to consider this patch.

Regards,
Pranav Lawate
Software Maintenance Engineer, RHCE
Red Hat India Pvt. Ltd.
plawate@redhat.com IRC: Pranav
@RedHat   Red Hat  Red Hat

Pranav Lawate

Software Maintenance Engineer, RHCE


Red Hat India Pvt. Ltd.

plawate@redhat.com IRC: Pranav

@RedHat   Red Hat  Red Hat



On Fri, Sep 12, 2025 at 12:18=E2=80=AFAM Pranav Lawate <plawate@redhat.com>=
 wrote:
>
> Hello,
>  This patch adds missing examples to the semanage-port and
> semanage-fcontext man pages showing the correct usage of the -r RANGE
> flag for MLS/MCS systems. Currently, users who try to use the -r flag
> without proper examples often encounter unclear error messages when
> they provide invalid range formats.
>
> For example, Here is a command with wrong range string value:
> ~~~
> # semanage fcontext -a -t admin_home_t -r s0.c0 /root/test
> libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or dire=
ctory).
> libsepol.mls_from_string: could not construct mls context structure
> (No such file or directory).
> libsepol.context_from_record: could not create context structure
> (Invalid argument).
> libsemanage.validate_handler: invalid context
> system_u:object_r:admin_home_t:s0.c0 specified for /root/test [all
> files] (Invalid argument).
> libsemanage.dbase_llist_iterate: could not iterate over records
> (Invalid argument).
> OSError: Invalid argument
> ~~~
> Similarly for port
> ~~~
> # semanage port -a -t http_port_t -p tcp -r s0.c0 8888
> libsepol.mls_from_string: invalid MLS context s0.c0 (No such file or dire=
ctory).
> libsepol.mls_from_string: could not construct mls context structure
> (No such file or directory).
> libsepol.context_from_record: could not create context structure
> (Invalid argument).
> libsepol.port_from_record: could not create port structure for range
> 8888:8888 (tcp) (Invalid argument).
> libsepol.sepol_port_modify: could not load port range 8888 - 8888
> (tcp) (Invalid argument).
> libsemanage.dbase_policydb_modify: could not modify record value
> (Invalid argument).
> libsemanage.semanage_base_merge_components: could not merge local
> modifications into policy (Invalid argument).
> OSError: Invalid argument
> ~~~
>
> My main motive is to come up with a logic to handle this error better
> but before undertaking that big of a change I wanted to push a small
> improvement to the code and so I have added correct example strings of
> MLS range into man pages for semanage-fcontext and semanage-port which
> I have tested to work properly on my RHEL 9.5 VM.
>
> This is my first contribution to the SELinux project.
>
>   The added examples demonstrate:
>   - Correct MLS range format: s0:c0.c255
>   - Complete command syntax with the -r flag for both port and
> fcontext operations
>   - Clear indication that this is for MLS/MCS systems only
>   - Practical use cases (HTTPS port and secure directory)
>
>   This should help users avoid common mistakes with range formatting
> and reduce support requests related to unclear error messages.
>
>   Signed-off-by: Pranav Lawate <pran.lawate@gmail.com>
>   ---
>    python/semanage/semanage-fcontext.8 | 4 ++++
>    python/semanage/semanage-port.8     | 2 ++
>    2 files changed, 6 insertions(+)
>
>   diff --git a/python/semanage/semanage-fcontext.8
> b/python/semanage/semanage-fcontext.8
>   index 3a96c62f..3e7a1d8b 100644
>   --- a/python/semanage/semanage-fcontext.8
>   +++ b/python/semanage/semanage-fcontext.8
>   @@ -100,6 +100,10 @@ execute the following commands.
>    # semanage fcontext \-a \-e /home /disk6/home
>    # restorecon \-R \-v /disk6
>
>   +Add file-context with MLS range s0:c0.c255 for /secure directory
> (MLS/MCS systems only)
>   +# semanage fcontext \-a \-t admin_home_t \-r s0:c0.c255 "/secure(/.*)?=
"
>   +# restorecon \-R \-v /secure
>   +
>    .SH "SEE ALSO"
>    .BR selinux (8),
>    .BR semanage (8),
>   diff --git a/python/semanage/semanage-port.8 b/python/semanage/semanage=
-port.8
>   index c6048660..217fa398 100644
>   --- a/python/semanage/semanage-port.8
>   +++ b/python/semanage/semanage-port.8
>   @@ -61,6 +61,8 @@ Allow Apache to listen on tcp port 81 (i.e. assign
> tcp port 81 label http_port_t
>    # semanage port \-a \-t http_port_t \-p tcp 81
>    Allow sshd to listen on tcp port 8991 (i.e. assign tcp port 8991
> label ssh_port_t, which sshd is
>   allowed to listen on)
>    # semanage port \-a \-t ssh_port_t \-p tcp 8991
>   +Allow Apache to listen on tcp port 443 with MLS range s0:c0.c255
> (MLS/MCS systems only)
>   +# semanage port \-a \-t http_port_t \-p tcp \-r s0:c0.c255 443
>
>    .SH "SEE ALSO"
>    .BR selinux (8),
>   --
>
> Looking forward to your positive response.
>
> Regards,
> Pranav Lawate
> Software Maintenance Engineer, RHCE
> Red Hat India Pvt. Ltd.
> plawate@redhat.com IRC: Pranav
> @RedHat   Red Hat  Red Hat

