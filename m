Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4E19D894
	for <selinux@vger.kernel.org>; Wed, 20 Nov 2024 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106941; cv=none; b=IAxWipKbapJLCIIbSwvSuN4qPmxQ7ZHarDzCupKyteQkb0z/sBjnuWIQGXWI6BmmZGXviUSxLpTapqNzZXN6jJjBWHjxU3bNruVnCrPS2Ash86oqfo229vq4ZAUcWM8ftjwjs1885JsMKJIqmNoIKz+flIAqJJ855bQatOg0c1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106941; c=relaxed/simple;
	bh=t/uoX/lVWotcQiacvoCedR+onGXioUhODAKqiN/rDxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hjgXncQFV1TZK7NQjIdZKU1StcgxwuzSSjJJBplP+PhGV5FuVf0g17wJnlWiG7/06nLJKs+H3ZpkJaxYlKTGUkVfnkjWre4GlkARlZcROTKKsWKiX4vQUNaDVUuI/28TWFjdB58fuRLd+iDbFAmkvhN8Z+1RQz4LBxiMqalkfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZ3izt8A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZ3izt8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732106938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=50cg2fYNIcg2QXiBucFuRwC8h0ZU4dgxziTypbiMlV4=;
	b=hZ3izt8AmjupxXtf+5EWg2MJ+j+oUEuVAkcdPxnT4yh3bz0kAaXK9dE4WSwOP47tNHQ4IU
	d4v6MOok4XynApdX/x4tTlL6Grkiq33+MsPVh5pUG35JkCOyWOKyyYIAlhfrYVx9UhF1ea
	4va7Sm4DZ7a+iCv8BVs5mYimhO/5s/Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-TGCaXSDAMI-IT6msc0gG2g-1; Wed, 20 Nov 2024 07:48:56 -0500
X-MC-Unique: TGCaXSDAMI-IT6msc0gG2g-1
X-Mimecast-MFC-AGG-ID: TGCaXSDAMI-IT6msc0gG2g
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ea5a0f7547so4471060a91.1
        for <selinux@vger.kernel.org>; Wed, 20 Nov 2024 04:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732106935; x=1732711735;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50cg2fYNIcg2QXiBucFuRwC8h0ZU4dgxziTypbiMlV4=;
        b=nQFzS1XSYDtgb7b0Gkqp3Cx6/VHaIsMWQELolaZH8UbjviMCMzaapFXKrfH6bcmkyz
         WapuqD+jn/6BUKe9LHxrqeqnjbDIXuGBMXu1Xwd5S3RmU00aNKvoYjnRZ2F0HYEVjuVE
         cHoVbvQYnOhkq3oGr5aa5/mibJHa+1j1lvde2zqeQ5W7i1bE00PINM87SnEX9njSyjna
         0SHUSV1JHGQcQlwSMS/oVx2ZE9gCmLhZ7Prk2F1esubSMPnCnabN8Gb40p4VOeauuv0N
         12TIymt15sf1ro5j3XOSSloy1wIA24WDQxMQ5NhTbs5h1uIbGWIyO3CaBMrxD/hme2UV
         rqBQ==
X-Gm-Message-State: AOJu0Yz8HrAbEmIqS4nmLqxRUmvcaYGTRXnmzhg8IXtVcgZBLr7lL9Qt
	ycKeb+rJ/qiQ7NmYSctJt5xcy+wEMz0XBfawxr8riULIQ71erHjlMjmRS6YeFiJseVTkWQ68r4Z
	cuASlt7wCRGJ6HYhAPdoUEOy7OZfHt9dgwGgQGJ6bA78KVZ7Y+POhMB3dh1rZUDTX07UBAcvqhM
	KkBwRND1nDfp3XyZnWRHRlVkez4asnevVnQLvDo5w5
X-Received: by 2002:a17:90b:1c08:b0:2ea:3f34:f19d with SMTP id 98e67ed59e1d1-2eaca72c6d2mr2691793a91.18.1732106935066;
        Wed, 20 Nov 2024 04:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcMQ0qWsba9sspLqfbh+tIzSZXblr5HdRrTSPCOMO+pnM1Q48twwCNT3xu/VUMKoBDQBefaXw1k1S482ENGmI=
X-Received: by 2002:a17:90b:1c08:b0:2ea:3f34:f19d with SMTP id
 98e67ed59e1d1-2eaca72c6d2mr2691778a91.18.1732106934804; Wed, 20 Nov 2024
 04:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106154454.1703327-1-omosnace@redhat.com>
In-Reply-To: <20241106154454.1703327-1-omosnace@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 20 Nov 2024 13:48:43 +0100
Message-ID: <CAFqZXNvnAtWP8UK4w9WdFAut93AB5yjE+RuZaf0C1USXF32faQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy/test_sctp.te: add missing
 corenet_inout_generic_if() calls
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:44=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.com=
> wrote:
>
> These are only needed when peer labeling is enabled, which is normally
> true only in some parts of the testsuite, but nothing prevents it from
> being enabled the whole time (either by configuration or policy
> capability), so better add the missing rules.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policy/test_sctp.te | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/policy/test_sctp.te b/policy/test_sctp.te
> index 8db84a3..fb057b9 100644
> --- a/policy/test_sctp.te
> +++ b/policy/test_sctp.te
> @@ -122,6 +122,7 @@ typeattribute test_sctp_connectx_t sctpsocketdomain;
>  allow test_sctp_connectx_t self:sctp_socket create_stream_socket_perms;
>  corenet_sctp_bind_all_nodes(test_sctp_connectx_t)
>  corenet_inout_generic_node(test_sctp_connectx_t)
> +corenet_inout_generic_if(test_sctp_connectx_t)
>
>  #
>  ############################# Deny Connectx ############################=
#####
> @@ -132,6 +133,7 @@ typeattribute test_sctp_deny_connectx_t sctpsocketdom=
ain;
>  allow test_sctp_deny_connectx_t self:sctp_socket { create listen accept =
bind ioctl read getattr write getopt setopt };
>  corenet_sctp_bind_all_nodes(test_sctp_deny_connectx_t)
>  corenet_inout_generic_node(test_sctp_deny_connectx_t)
> +corenet_inout_generic_if(test_sctp_deny_connectx_t)
>
>  #
>  ############################## Bindx ###################################=
##
> @@ -142,6 +144,7 @@ typeattribute test_sctp_bindx_t sctpsocketdomain;
>  allow test_sctp_bindx_t self:sctp_socket create_stream_socket_perms;
>  corenet_sctp_bind_all_nodes(test_sctp_bindx_t)
>  corenet_inout_generic_node(test_sctp_bindx_t)
> +corenet_inout_generic_if(test_sctp_bindx_t)
>
>  #
>  ############################## Deny Bindx ##############################=
#####
> @@ -152,6 +155,7 @@ typeattribute test_sctp_deny_bindx_t sctpsocketdomain=
;
>  allow test_sctp_deny_bindx_t self:sctp_socket { create ioctl read getatt=
r write getopt setopt };
>  corenet_sctp_bind_all_nodes(test_sctp_deny_bindx_t)
>  corenet_inout_generic_node(test_sctp_deny_bindx_t)
> +corenet_inout_generic_if(test_sctp_deny_bindx_t)
>
>  #
>  ############################# ASCONF Server ############################=
##
> @@ -162,6 +166,7 @@ typeattribute sctp_asconf_params_server_t sctpsocketd=
omain;
>  allow sctp_asconf_params_server_t self:sctp_socket { create listen bind =
ioctl read getattr write getopt setopt };
>  corenet_sctp_bind_all_nodes(sctp_asconf_params_server_t)
>  corenet_inout_generic_node(sctp_asconf_params_server_t)
> +corenet_inout_generic_if(sctp_asconf_params_server_t)
>
>  #
>  ############################# ASCONF Client ############################=
##
> --
> 2.47.0
>

This patch is now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/000b2bf26254ff26=
07d3b13aba87ac2c998a2386

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

