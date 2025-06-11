Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B46C8FE
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667909; cv=none; b=XiqbDCTV9GTlwOJ3CRfCvaTqEuj6H8itzqFzROrFs9FuPiuzMyF1rINfDsp3MzIS9wfK9GRYug1zGS8uwkk8Og8cIl49vtHGXKa7FSTqqzgj+yCNPuOaU4adryvnVbsJfYWD6hb8IxDyc/7i8td08CHwiUgTqimpAMc+KY9nP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667909; c=relaxed/simple;
	bh=ny8OvdtP/Fu2V37SS6SYK6o/ecV2ffim7ma7Z9fu9qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bdos8akc6PFxMLu5Bf5Y17Nnvd68g1FayuCLJpAkNHSecttXlDb777At7tpj88oHQIdH1Qs8KNopR/OKr1GD6enIbxV9spmTo4vLGjLFYR3n/mq7GCNC24fus2C55l+4fWub7PfqztDjPbgWiB65q7Hm1lJlJ1nQDDl0ZZ8HsIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eq8xW48Z; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq8xW48Z"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c4e46a89fso60728a12.2
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749667907; x=1750272707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUPAbRPiUzqY1oNeAlTQO4uXXLPO8eAmtegaTiyZxtQ=;
        b=eq8xW48Z5FTbV/llQqjOsujcSITDRLYG8+LVpTM0CgdwEAxqzGGVZCbQOsr8bzdRUW
         +LHpBHvjn1SDvKCKv4InbONOlf6fGG7cAf0dSG/KdHbAe+a8Fx+WDhPnpLnefPWFkNAi
         eOLrimsAUlT9Uv8lYlr+sieitJ9UyBmKGSqWE//wW5mRtUYP9vrZrxmDTlm1oM9lhmzH
         kz88CwDLNLGXPpG66KI4kwGlyT1B7kJc+klN627kZnhsj4DuCxZ6CJ6BkbEqlvYLljIo
         vOJ2Zq8rsR69i5jyjByVYr2Qv/72pqh1UzfYVM1bSXoit3zWmAtDBkwsGvN9rq4WaEvv
         mZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749667907; x=1750272707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUPAbRPiUzqY1oNeAlTQO4uXXLPO8eAmtegaTiyZxtQ=;
        b=MrvSG83U10bL0UOr6qjPX8cESetx2mZi78EBlqroreCBHWIiFvWQkACQ9dtsitPPuK
         fdHKO4KzdgulDwSlpP08ivQNMG5W58xF/pyNVhdgXIWoz7OV6pzwGjZOi30MWiA0jzII
         Bk19S4RbxZ7h2O8Pp51H+fJSt7n27Jw8KRl1ZjZ5CQJ5r/WLqTX6me7ua9xdiPX1CY+v
         fSfzPM5qxTDZWwY2cEaPezIni3waaWhyFoqzDLvGMXrw+NVQ38YW/dL8dZy/WKKuVoZl
         Qar+LlPMSbDKHFwANrNESH4qHdJ6KGEMmvh4i/My/ufo4zcxqOLGX0q39Ia0yDgE51i8
         yOjg==
X-Gm-Message-State: AOJu0YyjFLR36bPw0GAfDNk+Yi4IkG1CqMikuwQOZVCOYyjq1nXR9tYI
	Snzd3TpZaq99l+IV5a6oMGJOkkiOr2SK2hvclX/okctyXAzRR41i9gLtll6A9P6i3OovH+YiGFP
	yduUovaLELhaoA3HYfBUCMX4jCflS/mnjlw==
X-Gm-Gg: ASbGnct8rPNeB0Gj1OyPZ78YW9ea7aig5jQ1IwEzM2fc+vGNMzx7xBXipkLd3fAm6g3
	jPNDrBxxoBd7FjISh6HMR9MB+GArNIESZ9rE/J/hkBexTccHKJCDnGyOngl9r+OwIeNhrj1E4V5
	O8n7qkQPzUx1+fGbJqxs9fBq9Saa0zNCrjl/UibfBlKb4=
X-Google-Smtp-Source: AGHT+IHUu+ucUwLdlhpm6NiA/ETO0QMzSZO4BKLfEZlgYXHZyiDwE/8RVRF5gPk0aN9RWQcd91nBVK0k4XHz8EckWeE=
X-Received: by 2002:a17:90b:5866:b0:311:fde5:c4be with SMTP id
 98e67ed59e1d1-313bfc2687dmr871675a91.35.1749667906579; Wed, 11 Jun 2025
 11:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 11 Jun 2025 14:51:35 -0400
X-Gm-Features: AX0GCFsuWslai5TMvxkpWesHIqBQb3Ec8ADA_4Drasj7SJr_-dUMGmGM-TvH7DQ
Message-ID: <CAEjxPJ7gJJX+PvorLd5tHYZV1vhUFdnY3TevC-bAMR+5Ua1JYQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On F42, iptables and ip6tables are no longer provided; check
> to see if iptables-legacy and ip6tables-legacy exist and use
> those instead if so.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  tests/inet_socket/iptables-flush | 20 +++++++++---
>  tests/inet_socket/iptables-load  | 52 ++++++++++++++++++++------------
>  2 files changed, 48 insertions(+), 24 deletions(-)

Similar changes are needed to the tests/sctp/iptables-{load,flush} scripts.
Thought I'd wait to see if this approach is how we want to address this.

>
> diff --git a/tests/inet_socket/iptables-flush b/tests/inet_socket/iptable=
s-flush
> index c168d89..a8cbe04 100644
> --- a/tests/inet_socket/iptables-flush
> +++ b/tests/inet_socket/iptables-flush
> @@ -1,6 +1,18 @@
>  #!/bin/sh
>  # Flush the security table.
> -iptables -t security -F
> -iptables -t security -X NEWCONN
> -ip6tables -t security -F
> -ip6tables -t security -X NEWCONN
> +if [ -f /usr/sbin/iptables-legacy ]; then
> +    IPTABLES=3Diptables-legacy
> +else
> +    IPTABLES=3Diptables
> +fi
> +
> +if [ -f /usr/sbin/ip6tables-legacy ]; then
> +    IP6TABLES=3Dip6tables-legacy
> +else
> +    IP6TABLES=3Dip6tables
> +fi
> +
> +$IPTABLES -t security -F
> +$IPTABLES -t security -X NEWCONN
> +$IP6TABLES -t security -F
> +$IP6TABLES -t security -X NEWCONN
> diff --git a/tests/inet_socket/iptables-load b/tests/inet_socket/iptables=
-load
> index 5be94f4..83ca966 100644
> --- a/tests/inet_socket/iptables-load
> +++ b/tests/inet_socket/iptables-load
> @@ -8,42 +8,54 @@
>  # - Specified the interface since the tests are only performed over loop=
back.
>  # - Set the port number and context to the values used by the test scrip=
t and policy.
>
> +if [ -f /usr/sbin/iptables-legacy ]; then
> +    IPTABLES=3Diptables-legacy
> +else
> +    IPTABLES=3Diptables
> +fi
> +
> +if [ -f /usr/sbin/ip6tables-legacy ]; then
> +    IP6TABLES=3Dip6tables-legacy
> +else
> +    IP6TABLES=3Dip6tables
> +fi
> +
>  # Flush the security table.
> -iptables -t security -F
> +$IPTABLES -t security -F
>
>  # Create a chain for new connection marking.
> -iptables -t security -N NEWCONN
> +$IPTABLES -t security -N NEWCONN
>
>  # Accept incoming connections, label SYN packets, and copy labels to con=
nections.
> -iptables -t security -A INPUT -i lo -p tcp --dport 65535 -m state --stat=
e NEW -j NEWCONN
> -iptables -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:te=
st_server_packet_t:s0
> -iptables -t security -A NEWCONN -j CONNSECMARK --save
> -iptables -t security -A NEWCONN -j ACCEPT
> +$IPTABLES -t security -A INPUT -i lo -p tcp --dport 65535 -m state --sta=
te NEW -j NEWCONN
> +$IPTABLES -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:t=
est_server_packet_t:s0
> +$IPTABLES -t security -A NEWCONN -j CONNSECMARK --save
> +$IPTABLES -t security -A NEWCONN -j ACCEPT
>
>  # Common rules which copy connection labels to established and related p=
ackets.
> -iptables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CO=
NNSECMARK --restore
> -iptables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j C=
ONNSECMARK --restore
> +$IPTABLES -t security -A INPUT -m state --state ESTABLISHED,RELATED -j C=
ONNSECMARK --restore
> +$IPTABLES -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j =
CONNSECMARK --restore
>
>  # Label UDP packets similarly.
> -iptables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --se=
lctx system_u:object_r:test_server_packet_t:s0
> -iptables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --s=
elctx system_u:object_r:test_server_packet_t:s0
> +$IPTABLES -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --s=
elctx system_u:object_r:test_server_packet_t:s0
> +$IPTABLES -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --=
selctx system_u:object_r:test_server_packet_t:s0
>
>  ##### IPv6 entries
> -ip6tables -t security -F
> +$IP6TABLES -t security -F
>
>  # Create a chain for new connection marking.
> -ip6tables -t security -N NEWCONN
> +$IP6TABLES -t security -N NEWCONN
>
>  # Accept incoming connections, label SYN packets, and copy labels to con=
nections.
> -ip6tables -t security -A INPUT -i lo -p tcp --dport 65535 -m state --sta=
te NEW -j NEWCONN
> -ip6tables -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:t=
est_server_packet_t:s0
> -ip6tables -t security -A NEWCONN -j CONNSECMARK --save
> -ip6tables -t security -A NEWCONN -j ACCEPT
> +$IP6TABLES -t security -A INPUT -i lo -p tcp --dport 65535 -m state --st=
ate NEW -j NEWCONN
> +$IP6TABLES -t security -A NEWCONN -j SECMARK --selctx system_u:object_r:=
test_server_packet_t:s0
> +$IP6TABLES -t security -A NEWCONN -j CONNSECMARK --save
> +$IP6TABLES -t security -A NEWCONN -j ACCEPT
>
>  # Common rules which copy connection labels to established and related p=
ackets.
> -ip6tables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j C=
ONNSECMARK --restore
> -ip6tables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j =
CONNSECMARK --restore
> +$IP6TABLES -t security -A INPUT -m state --state ESTABLISHED,RELATED -j =
CONNSECMARK --restore
> +$IP6TABLES -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j=
 CONNSECMARK --restore
>
>  # Label UDP packets similarly.
> -ip6tables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --s=
elctx system_u:object_r:test_server_packet_t:s0
> -ip6tables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --=
selctx system_u:object_r:test_server_packet_t:s0
> +$IP6TABLES -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --=
selctx system_u:object_r:test_server_packet_t:s0
> +$IP6TABLES -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK -=
-selctx system_u:object_r:test_server_packet_t:s0
> --
> 2.49.0
>
