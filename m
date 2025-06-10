Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59B235897
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573045; cv=none; b=dcxkRbIVE19l2jQtPbW0fuTxaEkb/nJMrtJ7SiBa58UqkJPQQZ5k/pAJxBDQ9zNzZyfe/6GAMOv2RZX3zPHt1lz4iazBHarQC+RB4zSG+1PrDaPIqErcPhSUOfGA2SUcVrctIc7zuN7fRLUBdN9BjOHjDuoHB4MQI1WIb+i3a44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573045; c=relaxed/simple;
	bh=hHnztKM94gmZQp8tnm82FtiHkQSm64/j+dxVaPNP7AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgzqLWzvVwS9P5+MlTDHT1yBxO5pyAeA1EqnTqT17GrdqF637mjqiLHj7gpaMN3NEghx7mgkMqIwyEiCV9tRiTyD4mW+77cbHq/nHzykKGqNf73WX/ycaisincBXfWmrxJwoMJ9/pifb1WYh+SSU7I9rx3fusNCm7IGYe3hTBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXUDk093; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXUDk093"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e58d28ebb0so2032498137.3
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749573042; x=1750177842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G469/XYjHpdOUrv/ac8AiupzzdaJd/O2lt52UE4vui8=;
        b=BXUDk093u7zV5qC8lNtDOfbIhxkZduiql3DuCS01SyBLT3/TPnKnZOJf25vYDzK54h
         oK0RpzxYSD0rDQ6l2yYs0qO56mDS/v+f7EhB7S485HD6Wscmb+BmLQ+rpj++hi69aoOq
         35lkJPi+pJ9qGIxbuBJtVxXo8eJLUxA1d6lzfaqaYJzoAbsL+TQY5/UYejYokwAa5iXc
         oK0WkytAVWEe9Es/yqm095jyM0frWaLeqryh7Tr/0SdQLrUQ7x86lMg57XF+hPsfoOZk
         Cm/kdrTUsbPboQeFWvzJKo0//3ljECHnH956do4viKRSyZ32nJiWJ7fwcTPdW8DrDEXr
         +A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749573042; x=1750177842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G469/XYjHpdOUrv/ac8AiupzzdaJd/O2lt52UE4vui8=;
        b=oBvU9aoemQV7/ptNkvsDkV05bWPqQ0yACIM6BOFgT3P7Zbmo0Pa4c0Q1MgTPPzeZSz
         Q8NnZrg3T1+2+lGjSbPsAOJxV7EbOK9AS8dvmBhkfNZe59lJBc4GY8+acxNxiIj3tGS7
         H5bcsgquuJqX6srnVeqUa7fueWgNWAKDUr2p+EBzHDu5ZQ6QasaEK/3ZWvC2fMQI64Dd
         Nsr4KoTpDD48ygMPQNEkeTu+5dJmdWQwyfDAHvU47Zm2pZmFHRE9s0UhVfg6+VBPluZb
         6hTiZxBwuegGcggA48boqUsIOG2TRh6D8NaKdvnz9582C4fuX7sJ/hGmz30aPUpDB8g8
         9L8g==
X-Gm-Message-State: AOJu0Yydrr4bDkFnmc6sKdKOhYGNzZq2/iiw39DP9nzX80rVYOfyvYsF
	vhs48Fc/0vQib5sqcP3tN7HyYMcW3MuF5ix/AdUS14Rj4ugQN0sgbDlqCm4rdrQI1uZ4ucHEs4G
	LNd2+8EQiwND15jvAnX6W5w1xDiJ2J+U=
X-Gm-Gg: ASbGncuzzV4g9mFpRNrjZ2EAM7T+rOUhRGPyCKDPHVW0oAXC9A1gYwA7+VYFZbCfk+j
	tNm05RKonTgKqIl648/geMdnGqWq4T2j6doya+punybazTjU8eaIsqpePFEdSkaJAlJr4gXEvEv
	4wdSZ6by/aV5sGrH8KXznn2+2X0hJNXZNuPK1NwPDz8Ir8TXFRQR4o+g==
X-Google-Smtp-Source: AGHT+IEQ+XF9mT5tp8F+lEMLUmOEcCxOB3CDoCPxRu6S+M9u0O95GmawzWlTOuxQdVcrxildYz5EcCJJiydBUgo1zE0=
X-Received: by 2002:a05:6102:3e8a:b0:4e5:9c06:39d6 with SMTP id
 ada2fe7eead31-4e7728ce265mr15810890137.2.1749573038773; Tue, 10 Jun 2025
 09:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530114836.30643-1-cgoettsche@seltendoof.de> <20250530114836.30643-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250530114836.30643-3-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 10 Jun 2025 12:30:26 -0400
X-Gm-Features: AX0GCFtjXqeS3sIAJA0nRbZ832D032IL2vNBQa3mAQY5FJDsTnR-6U_PKeJkS7Y
Message-ID: <CAP+JOzT0fQCU5cuupP7hESNTeYaphJjiYUkubwwyhkDjpXtEVA@mail.gmail.com>
Subject: Re: [PATCH 3/4] checkpolicy: add support for wildcard netifcon names
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 7:54=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Support network interface names containing wildcards.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/policy_parse.y                         | 8 +++++++-
>  checkpolicy/policy_scan.l                          | 1 +
>  checkpolicy/tests/policy_allonce.conf              | 4 ++++
>  checkpolicy/tests/policy_allonce.expected.conf     | 4 ++++
>  checkpolicy/tests/policy_allonce.expected_opt.conf | 4 ++++
>  5 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index 7e117222..f9181eaf 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -153,6 +153,7 @@ typedef int (* require_func_t)(int pass);
>  %token POLICYCAP
>  %token PERMISSIVE
>  %token FILESYSTEM
> +%token NETIFNAME
>  %token DEFAULT_USER DEFAULT_ROLE DEFAULT_TYPE DEFAULT_RANGE
>  %token LOW_HIGH LOW HIGH GLBLUB
>  %token INVALID_CHAR
> @@ -748,7 +749,7 @@ opt_netif_contexts      : netif_contexts
>  netif_contexts         : netif_context_def
>                         | netif_contexts netif_context_def
>                         ;
> -netif_context_def      : NETIFCON identifier security_context_def securi=
ty_context_def
> +netif_context_def      : NETIFCON netifname security_context_def securit=
y_context_def
>                         {if (define_netif_context()) YYABORT;}
>                         ;
>  opt_node_contexts       : node_contexts
> @@ -901,6 +902,11 @@ path               : PATH
>  filename               : FILENAME
>                         { yytext[strlen(yytext) - 1] =3D '\0'; if (insert=
_id(yytext + 1,0)) YYABORT; }
>                         ;
> +netifname              : NETIFNAME
> +                       { if (insert_id(yytext,0)) YYABORT; }
> +                        | IDENTIFIER
> +                       { if (insert_id(yytext,0)) YYABORT; }
> +                        ;
>  number                 : NUMBER
>                         { unsigned long x;
>                           errno =3D 0;
> diff --git a/checkpolicy/policy_scan.l b/checkpolicy/policy_scan.l
> index 7bdea427..0076062d 100644
> --- a/checkpolicy/policy_scan.l
> +++ b/checkpolicy/policy_scan.l
> @@ -298,6 +298,7 @@ GLBLUB                              { return(GLBLUB);=
 }
>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*  { return(IPV6_ADDR); }
>  {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|[:.])*"/"{digit}{1,3}        {=
 return(IPV6_CIDR); }
>  {digit}+(\.({alnum}|[_.])*)?    { return(VERSION_IDENTIFIER); }
> +({alnum}({alnum}|[\*\?_]){0,15}|[\*\?]({alnum}|[\*\?_]){1,15}) { return(=
NETIFNAME); }

Overall, this patch series looks good. The sorting all seems to work
as expected.

There are a few issues with the handling of netif names.
CIL will accept both "*" and "?" as the netif name, but checkpolicy
does not. I don't know if this is desired or not. Might need to add a
function in cil_verify.c to check that the netif name is legal.
Also, checkpolicy gives a syntax error for any netif name that starts
with a number but does not have "*" or "?" in it. My guess is that it
is matching something other than NETIFNAME.

Thanks,
Jim

>  #line[ ]{digit}+[ ]\"[^\n]*\"  { set_source_line_and_file(yytext+6); }
>  #line[ ]{digit}+               {
>                                   errno =3D 0;
> diff --git a/checkpolicy/tests/policy_allonce.conf b/checkpolicy/tests/po=
licy_allonce.conf
> index 95a0f265..469eb9b6 100644
> --- a/checkpolicy/tests/policy_allonce.conf
> +++ b/checkpolicy/tests/policy_allonce.conf
> @@ -74,6 +74,10 @@ genfscon proc "/file1" -- USER1:ROLE1:TYPE1
>  genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
>  portcon tcp 80 USER1:ROLE1:TYPE1
>  portcon udp 100-200 USER1:ROLE1:TYPE1
> +netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
>  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
>  nodecon 192.168.42.0 255.255.0.0 USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce.expected.conf b/checkpolicy=
/tests/policy_allonce.expected.conf
> index 79d62319..b3a51bef 100644
> --- a/checkpolicy/tests/policy_allonce.expected.conf
> +++ b/checkpolicy/tests/policy_allonce.expected.conf
> @@ -80,6 +80,10 @@ genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
>  portcon tcp 80 USER1:ROLE1:TYPE1
>  portcon udp 100-200 USER1:ROLE1:TYPE1
>  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
>  nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
> diff --git a/checkpolicy/tests/policy_allonce.expected_opt.conf b/checkpo=
licy/tests/policy_allonce.expected_opt.conf
> index fa4e319b..a7914c64 100644
> --- a/checkpolicy/tests/policy_allonce.expected_opt.conf
> +++ b/checkpolicy/tests/policy_allonce.expected_opt.conf
> @@ -80,6 +80,10 @@ genfscon proc "/path/to/file" USER1:ROLE1:TYPE1
>  portcon tcp 80 USER1:ROLE1:TYPE1
>  portcon udp 100-200 USER1:ROLE1:TYPE1
>  netifcon lo USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon net USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon netx* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon net? USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
> +netifcon net* USER1:ROLE1:TYPE1 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.1 255.255.255.255 USER1:ROLE1:TYPE1
>  nodecon 127.0.0.0 255.255.255.0 USER1:ROLE1:TYPE1
>  nodecon 192.168.0.0 255.255.0.0 USER1:ROLE1:TYPE1
> --
> 2.49.0
>
>
