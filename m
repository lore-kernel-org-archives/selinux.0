Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F112C11DE
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979139; cv=pass; b=r2oDdK+XcnV1QlcjgWBJMS/m0nhlIUtREHZZ9aQZ1BHHhlWfRkBjlMQb2Fi6TkYaD5hAUYohBcWG9KYBh/rt9Aznzca5Wh1dGg7CSuYzOZTY60yfiM5BnQGPDbPAGDx373dPTdE7oYUNyzMjecFTheB76Y8VOahCoUE4UkaTMmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979139; c=relaxed/simple;
	bh=lkzuwXnzeKjRYkkpZD1XSG7uRjM+lTtfiJegEaKUCpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLb/6LOiG5MXNeP7hCjCjVDV7V0mG6uGcwofdDbCvOnRQGGngANwfwoE/uExgl0PzLYa7Rh49C0UapeHgJWfN40N6xmlawjsAg55bVZh66+i/CXrc1+Rx1g3V70E0xpuLXY/j/7Xik/67sNGD2nvMjYMYRzLO7kNhICkCiXVSaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMVpjisC; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMVpjisC"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so31651891fa.3
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 08:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786979135; cv=none;
        d=google.com; s=arc-20260327;
        b=LHQIdtajQm9v63yDHv8IiVRmlSG3e3K7C8NaNgkK9e+008ysu1GW9IPEcviaAecnQs
         5EnsToD2G4yVbqrVpgeL7+gGRyAu6hhODh+kU4nHhmfKF5F3KN18tkCuNxeXlb5Ykx6x
         bmIMvDlqItSC0dhEwvo8Y5DB+KXMDJ58KHKrkFmH3FAfxtsIF7kmWWdCIu4Yt+rzVQCJ
         2GbxtC5bhlxn/LPWp5h+eZtSrf29ul07ZuhAbvebyHzLj5Qw0xZtwP5MDjJ9EdCeM9q2
         HiRg9FyWpOWoiVmXd8RY8iWDdZJYj8nUip4pGIpaDvYoGjRfoGugpB74/P4SS3naJcH1
         hckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YTSUkB7bLy0mirR534QbN+5xp8HRcIjTGOFp21QPEpA=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=HXkpI0bMlDAUPWjF/QpxbSMAiUq1T8zDuPDba8HII0Mz0gagMs6J+SFK0QoZ72K1Kw
         gNni1U4yYI/vhF5wKVK1djksZ6MGFsho38RXgsJHnPOF2c/ljUtV6HCi6jVBTUZh3TqT
         aBX2IeXLNPEWbiUWZkC3Rs1dL2uRhRzxKwLWBoaRTGulA0sXxNthlXZHm+iA75qIddGC
         1E+jTfyIgHi51cY8LmxmFojAbrgPcvZ7qOOVbrna64GwytuOakZ7U9eR8C/ocJ6VsJqR
         LcRDEfjoP/GC0oaSFiZkR+nQB5JLuCL36GaG7AjYwYx7nC64F8D3OP7kl2hyP13D+TK2
         VmEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786979135; x=1787583935; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YTSUkB7bLy0mirR534QbN+5xp8HRcIjTGOFp21QPEpA=;
        b=dMVpjisCwR3dmlYoFUbxZyX0gjEXvX0jPU8hfr0s4vehpyIvGtMumaqWrFytoNoo3G
         rXnlcOrb0rXEwsSsmzPKJivu1hKNrEv3CtulxwSC+hrybomdtCHKBv1BJ/T4kw1oxx//
         UHNeHxei0nUiNybjgqHXlqHHUg1TSm82ANcYuocTo05rhRkaoeNcRQ8/ZBhcOP8GfAAx
         UimFDqxyX2RaWS9mSSBTcjGWJlLMY/qk/rI/miKSBUPfoaIj8ZJjgjfqdPG3EtgbvIJ7
         5uZWmBMajCflytUjOBI4DgpKRhFiYlAaZpygTSNAWPegXOEbq9OaKY0WjWK7FzEdDMWu
         6qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786979135; x=1787583935;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YTSUkB7bLy0mirR534QbN+5xp8HRcIjTGOFp21QPEpA=;
        b=TDfjzZwG0Ug6Tq5UEp6zpmijBm9OSzLq7gJ4sERTTezdw9bC06mZNnKAdvBhp8KKC9
         NHocDgX4mA9mmwso5GDSw+qatQR+LQH76djREIOY+19DxzVxsbymgmS8LXuIgCfmhqTW
         pZ9Ayp+qmwo5Svso5vF7KUAjYpLcHrz84boF9Fn1s6QsnHqhigfq+Bkbv1QaA0V9BSiw
         DZu9axShhy6XMIthSxe1Yulx1gmytZnw+/C/UTqZMw+2jG9bhumnba7lZ0cr1qtFCoH1
         89yiXfo3nFwZNd62RoRMNUuD+NUiTUV43f0CgooAGeJvn8v7yqLzVBrpOSK+zyXHpR98
         Lt5g==
X-Gm-Message-State: AOJu0Yw2YNU8fHYsdZg69W25MX2ArBaJfx1rN27p/vGUmcb9gG7ZKzTo
	QshR8mHiUT5OrddMWaPzHEwdWvv967U686p9fwNxE+y4D/OS7MY3sPJO2T7jtOSwoeyNvEasTDq
	3Lu4Mq8+Oho6huQuy9M/rzmlsf9cqvls=
X-Gm-Gg: AR+sD13VZ6CLv0Wvm6ZkVbS2q6NH9if1LJgoITNB/h26Cgd0sICwPxh6rYYHe2D+qyM
	KYrLVsHfy4/X5hWXslab4eM5Zos8xCp4DGPSTAok0YJNBPKuBsfP9Uj15SXfOrJi5JG2uNHrqPP
	kUzvxEFUS+V0/+QKkIuBIpYsVeyCgAzvl9wel3VJuWnqPZxUnUqOVHUsD05p6PHn4oTVmFumA4r
	S2zJVX+sFqsqpElsy17RqmxMoO84VRnBTx2ziUmshkAGC2NIf1pgSAAe4jR8rCvswpUxeOTtFWB
	n+pX7HF4KgH/dlRnZlnrR8Fae8QN2T0m/5may4pmwQ==
X-Received: by 2002:a2e:be90:0:b0:394:1254:10d2 with SMTP id
 38308e7fff4ca-3a131fff876mr26308001fa.0.1786979135387; Mon, 17 Aug 2026
 08:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814142717.204397-3-stephen.smalley.work@gmail.com>
In-Reply-To: <20260814142717.204397-3-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 17 Aug 2026 11:05:23 -0400
X-Gm-Features: AcwNN1U81W6lQJ0EhenQTTt1V9LvVNcdXeAZWa2nK6F9Juzx9TqRnp5zUpd9__s
Message-ID: <CAP+JOzSLLAAWHbQFvj53F0uN1B0VYn2ZM=b3=jF+n3dXfx3LPw@mail.gmail.com>
Subject: Re: [PATCH v2] python/sepolicy: add missing socket template attributes
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 10:29=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> generate_fc() unconditionally reads template.fc_sock_file for any
> path that stat()s as a socket, but only var_run, var_lib and rw
> define it, so selecting a socket under /tmp, /etc, /var/cache,
> /var/spool, /var/log or a systemd unit directory in the GUI raises
>
>   AttributeError: module 'sepolicy.templates.tmp' has no
>   attribute 'fc_sock_file'
>
> The tmp template has no fc_* attributes at all, so any explicitly
> added file or directory under /tmp fails the same way on fc_file /
> fc_dir.  generate_te() and generate_if() likewise read
> te_stream_rules / if_stream_rules for a socket path, which var_log
> and unit_file lack.
>
> Add fc_sock_file to every template that already has fc_file (using
> the -s file class), give tmp a full fc_file / fc_sock_file / fc_dir
> set for TEMPLATETYPE_tmp_t, and add empty stream-rule strings to
> var_log and unit_file so a stray socket there no longer takes the
> whole generator down.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/379
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Oops, Ack'd the wrong patch.

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2 changes the fc_sock_file definition in the
> unit_file template to the empty string since there shouldn't
> be any sockets with those types.
>
>  python/sepolicy/sepolicy/templates/etc_rw.py    |  4 ++++
>  python/sepolicy/sepolicy/templates/tmp.py       | 13 +++++++++++++
>  python/sepolicy/sepolicy/templates/unit_file.py |  6 ++++++
>  python/sepolicy/sepolicy/templates/var_cache.py |  4 ++++
>  python/sepolicy/sepolicy/templates/var_log.py   |  8 ++++++++
>  python/sepolicy/sepolicy/templates/var_spool.py |  4 ++++
>  6 files changed, 39 insertions(+)
>
> diff --git a/python/sepolicy/sepolicy/templates/etc_rw.py b/python/sepoli=
cy/sepolicy/templates/etc_rw.py
> index dcf445e0..c78d64a2 100644
> --- a/python/sepolicy/sepolicy/templates/etc_rw.py
> +++ b/python/sepolicy/sepolicy/templates/etc_rw.py
> @@ -134,6 +134,10 @@ fc_file=3D"""\
>  FILENAME               --      gen_context(system_u:object_r:TEMPLATETYP=
E_etc_rw_t,s0)
>  """
>
> +fc_sock_file=3D"""\
> +FILENAME               -s      gen_context(system_u:object_r:TEMPLATETYP=
E_etc_rw_t,s0)
> +"""
> +
>  fc_dir=3D"""\
>  FILENAME(/.*)?         gen_context(system_u:object_r:TEMPLATETYPE_etc_rw=
_t,s0)
>  """
> diff --git a/python/sepolicy/sepolicy/templates/tmp.py b/python/sepolicy/=
sepolicy/templates/tmp.py
> index c000a75e..54ed1803 100644
> --- a/python/sepolicy/sepolicy/templates/tmp.py
> +++ b/python/sepolicy/sepolicy/templates/tmp.py
> @@ -127,3 +127,16 @@ if_admin_rules=3D"""
>         files_search_tmp($1)
>         admin_pattern($1, TEMPLATETYPE_tmp_t)
>  """
> +
> +########################### File Context ###############################=
###
> +fc_file=3D"""\
> +FILENAME               --      gen_context(system_u:object_r:TEMPLATETYP=
E_tmp_t,s0)
> +"""
> +
> +fc_sock_file=3D"""\
> +FILENAME               -s      gen_context(system_u:object_r:TEMPLATETYP=
E_tmp_t,s0)
> +"""
> +
> +fc_dir=3D"""\
> +FILENAME(/.*)?         gen_context(system_u:object_r:TEMPLATETYPE_tmp_t,=
s0)
> +"""
> diff --git a/python/sepolicy/sepolicy/templates/unit_file.py b/python/sep=
olicy/sepolicy/templates/unit_file.py
> index e26f5e2a..6d72dcd3 100644
> --- a/python/sepolicy/sepolicy/templates/unit_file.py
> +++ b/python/sepolicy/sepolicy/templates/unit_file.py
> @@ -66,9 +66,15 @@ if_admin_rules=3D"""
>         allow $1 TEMPLATETYPE_unit_file_t:service all_service_perms;
>  """
>
> +te_stream_rules =3D ""
> +
> +if_stream_rules =3D ""
> +
>  ########################### File Context ###############################=
###
>  fc_file=3D"""\
>  FILENAME               --      gen_context(system_u:object_r:TEMPLATETYP=
E_unit_file_t,s0)
>  """
>
> +fc_sock_file =3D ""
> +
>  fc_dir=3D""
> diff --git a/python/sepolicy/sepolicy/templates/var_cache.py b/python/sep=
olicy/sepolicy/templates/var_cache.py
> index 37897231..5a147896 100644
> --- a/python/sepolicy/sepolicy/templates/var_cache.py
> +++ b/python/sepolicy/sepolicy/templates/var_cache.py
> @@ -152,6 +152,10 @@ fc_file=3D"""\
>  FILENAME               --      gen_context(system_u:object_r:TEMPLATETYP=
E_cache_t,s0)
>  """
>
> +fc_sock_file=3D"""\
> +FILENAME               -s      gen_context(system_u:object_r:TEMPLATETYP=
E_cache_t,s0)
> +"""
> +
>  fc_dir=3D"""\
>  FILENAME(/.*)?         gen_context(system_u:object_r:TEMPLATETYPE_cache_=
t,s0)
>  """
> diff --git a/python/sepolicy/sepolicy/templates/var_log.py b/python/sepol=
icy/sepolicy/templates/var_log.py
> index 371dd7e4..051a0f1e 100644
> --- a/python/sepolicy/sepolicy/templates/var_log.py
> +++ b/python/sepolicy/sepolicy/templates/var_log.py
> @@ -106,10 +106,18 @@ if_admin_rules=3D"""
>  """
>
>  ########################### File Context ###############################=
###
> +te_stream_rules =3D ""
> +
> +if_stream_rules =3D ""
> +
>  fc_file=3D"""\
>  FILENAME               --      gen_context(system_u:object_r:TEMPLATETYP=
E_log_t,s0)
>  """
>
> +fc_sock_file=3D"""\
> +FILENAME               -s      gen_context(system_u:object_r:TEMPLATETYP=
E_log_t,s0)
> +"""
> +
>  fc_dir=3D"""\
>  FILENAME(/.*)?         gen_context(system_u:object_r:TEMPLATETYPE_log_t,=
s0)
>  """
> diff --git a/python/sepolicy/sepolicy/templates/var_spool.py b/python/sep=
olicy/sepolicy/templates/var_spool.py
> index dccb5f16..84933f50 100644
> --- a/python/sepolicy/sepolicy/templates/var_spool.py
> +++ b/python/sepolicy/sepolicy/templates/var_spool.py
> @@ -151,6 +151,10 @@ fc_file=3D"""\
>  FILENAME               --      gen_context(system_u:object_r:TEMPLATETYP=
E_spool_t,s0)
>  """
>
> +fc_sock_file=3D"""\
> +FILENAME               -s      gen_context(system_u:object_r:TEMPLATETYP=
E_spool_t,s0)
> +"""
> +
>  fc_dir=3D"""\
>  FILENAME(/.*)?         gen_context(system_u:object_r:TEMPLATETYPE_spool_=
t,s0)
>  """
> --
> 2.55.0
>
