Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF925429CCF
	for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978249; cv=pass; b=Mc1PO9wG+M8l1Zpv4P6eanDbI2CJPuEhHtRhc5exWAmp6YzGLK2B6mgRK/knGfNTI+/lXIS2oGwyww4LUB432l2cfuSeLVQWORJypOq9pg3gsQQSuIyspCTP2Zn3UFLiA10jbAreK1b+2mSMxq/VX+sU4EIYDfV3JExA72M1Ugk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978249; c=relaxed/simple;
	bh=ivQceJIfWQDFnVHRB8300tfQ6LyIPoXaytOwlrqmWCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ed2wc/8+TmKrX+U+qKqIgj/A89ZROBp9gyVhgS6dHrg/AljELJz4r0apoCAesrKe+BI1osiXHiQPMTjShC02BWXQmiiP9h2TC7p46sUv9TX33VV9FFGzZ2+QK5MlDYXdzpGUxpPBAEJFdgXFzmFqnd2qD3osJMgJk4pZX8AEPvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is5tWU8o; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is5tWU8o"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c9452244aso27294881fa.3
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2026 07:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786978246; cv=none;
        d=google.com; s=arc-20260327;
        b=UU9R85xi+yWyJNQFTiNVPjgFSyxn0PKewTDwDB2r/HxIM3MqbZp/3VI8DT+mZgr0Y6
         Q9EJIFe5IpQYFmZCy8KonOQpaV6t5G9icCChGyh/as4qZC5oV/3fR6aC8Lt1k6QDNlG1
         1r3aO6G/VqaAbV8jJ7Ny0bd/nJx8EFh688+lex9QVGdjht8h/fA099a2KkOtCzu46/aP
         Al3aa0ApKcs9PQ9eKtiuGwthtG9uHgMaVLYyXg++XqDW0vDDg/AnT+0Z+OXwZoSXwUdt
         Kt6Y1mOTCkZHXzmMWXkO0HpHt6oJLc8WJpZxYV7ePhN0DeZ44a8oRtIeTUYzwUWdubkS
         /SCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n9kgps7QMLwpRImWJDA4PS5vPzprqmS9DBCq7impMVI=;
        fh=9qqehjuxnn2X0mJ7hQbZg99PSLTxs4BCAql4/69ZoU8=;
        b=L4ta02NNxmk2Cqw3bcW1dYvq71dQeOPu3mNduXbcTCAKoxahbQ4+H1Y0yHSJGynrh+
         5xY/yWdA/BC8pJAjoSY6JMQdYsM2uY6hAGtCsZUR6Cl0vq/bCH6GmHtM9BqvKXcB7xdW
         UF0DXrbVkGih5NcLmez5VJwT07zUAYV7PsCPeuAybtIg2JlCt8+YDtnR0r8WmoOapiVb
         UudI+n/bRKSvrv+z2wwEP0ULkskmQqfL18v8UwKJHecNQ9sWUfsGC68Qn+sqQTMVTOKx
         BCHpIzdtfs6Twbh0KvSdWU7zYGDLlNxv6btMdzSk9ho4sH7c4KIg1ocAqPx72y+BzLA0
         6V5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786978246; x=1787583046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n9kgps7QMLwpRImWJDA4PS5vPzprqmS9DBCq7impMVI=;
        b=is5tWU8oMUXxlbwPSc26Bm14/DwHx/b+2gLWP89kPzvCyhnaA4Qg1mjYta0S/PQ+8S
         cRh2yih0Drjr9NQSHQihjDwf6EjMa1uke2p2ufqkkKQfaO1JMiDHrmFdlWB9dVJrdzg+
         0Hg/qtnryadDEo/1Tvy61NsdWgB39tW3T/Nq/rzzSoGzDn3g3djlHD79ItA4WwwEKcmP
         LljJeVWXgnMlqVJd7WXGaL8Dw2bB/D3bCOoFhTttrQsA7mHuWDRuvGQ24FCC1E3ekP6j
         TLBnfn4unuJe7IKzXu8YX6bPvjf0BiWQd1VPxA6CsDKC0qQTPiVMQVE0i5hxj+9FvzPq
         S2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786978246; x=1787583046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n9kgps7QMLwpRImWJDA4PS5vPzprqmS9DBCq7impMVI=;
        b=WIxxm+P8n0dqG43Zy+JPy1K7uF8fbv2So9CtwwWatnVrieSMZUji+117C6zjT3zlFy
         jpBqtlBSTpVBWq3ORv3d+gc9rFXwJdrmL9khH7CYORq4wVSFy2S2/b/KKnDJBwaMf8Mq
         T1ZDCcIKEeupWAX9T4tK5lfGCycJ3oNg9L6gDh0ONkIWdiqBCISEN6e42D7exxbUpAf9
         wgR41xP875Lsj14MKf5zRyoF3KtMBggAOtEpNrISTTZ6KgKt+zgEw6l+zf3QmV5mDAj9
         ER9tRupTXZy6l1yjlU5Uc+hvAoomPfoR/N4dJ50FCjyjbEiAEuVnZPVFJDhW0iDhKCD4
         SCIg==
X-Gm-Message-State: AOJu0YxxWvLbKJYVU8gKdT1OaQBpkSULgEkJ5UNPH1nogT0VJcv8AmlP
	4NVZSRqdMDQs/br9h3gDJYhHJdPMTzIbYeDSh42OUULIEoSfNfvQ4Eqiotus0w0D4iMpGh+LZl/
	bURn38DdD7zQEW/KWVqacoPmjrT8O8DK5rY1H
X-Gm-Gg: AR+sD13zlcHpqods70QpislkGXlh63pA/IZPhdPfl+v2cskKgpFu0Xz6AX+9hT2KtAX
	zFS3P48BPOSyH8kgvIVOoTfhX2ZsFAFpcfr3H055R8AkOfc9w0RhIsR2BESgGd07PGn1jKormB5
	20JhDp4lgVkHk8rZfq80uaKL281pEvaCxUrcK5zDvRdwpwQivicwlXMaoXXFEjjOqELgh8H4vKE
	bjWyy50q92Bqd0KRr3zRqFViVgzaizg5+m9hJilsD14I8CVhI8AknG/oSEvlVi8oDNanmoTafmO
	JbK9oNzCGBjNh8cIILEgnsVqg0d1oDaLD664il73uA==
X-Received: by 2002:a2e:a99c:0:b0:39c:828a:ec34 with SMTP id
 38308e7fff4ca-3a1752683b0mr658561fa.17.1786978245599; Mon, 17 Aug 2026
 07:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813184129.186476-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260813184129.186476-1-stephen.smalley.work@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 17 Aug 2026 10:50:34 -0400
X-Gm-Features: AcwNN1WsKTjYgGYiEVtbcxFWRO_pWqdr0rPTL1KYrchAGCl8nnhWUc0vEEx1WxA
Message-ID: <CAP+JOzRMP0V5GeiFjUgwRAGzPn_3UO+3FDQyCpwFE+msAoRaYg@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: add missing socket template attributes
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 2:41=E2=80=AFPM Stephen Smalley
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

Acked-by: James Carter <jwcart2@gmail.com>

> ---
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
> index e26f5e2a..1504dabd 100644
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
> +fc_sock_file =3D fc_file
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
