Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598004;
	b=OcFF2+m0H2NrL5hpUhYCezaROF3N1ttRqLh6PwyhIboFzeCuWK9nLXu0uOd4imYe49i3
	 UFWiJw0B2328Kdu0AnLxD1RJTUuTIgULIapkQ64sk59fuqUCQ0MV+PxjigZIA2ErrIrgC
	 //vCGjYgJoM/V4SoAcooCQuXQxlZIJ77awGFNtx/yvf8mR+AV1+ydHI4SCSgNepVSLJi1
	 YjhcLFqWeKJpFXsDO179cnRckMKnPKQBp8RG7Wxl+LcagnRjuMRgNaPKwhdPY/k1eKfaL
	 14Grgszc1YR3zB2Pk95cJokuJfQIbrpsxZnZ2/oKqldEPOlkyHT38vt01/8y/nvjVfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598004;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
	b=wmifiPU0CCgOHHIVFrnLfqmr0BHZ4csRTMk1vWwS9F5G5pDB0NpRxcfno5W6OXeVSjb2
	 ll6RCeKH9siYaigOUy52lCaemqCOafNEbYeT3G4+BuzfKtwXYOzMpL2Vei2726lymy9Eg
	 gR4hZietOmScVW6/JLWRB2AKProbMgdOoZEE7iKXvmk1ayxqwoPsjLV+Ke4kwf8bfoSFU
	 VDDB8n1h8J5LJwG2cCdUsbVNsWT5B+4nPUoWkLoZG+H+TpciZHKGpK7sbTgdDI5EuYkl+
	 X2vKw56SJkb0UuqbvpE1yA8CeZMO+HP1Nz2cQDhXKFd7Y56C/EnNp2xH1ojifInZcXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cYoot7un;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4BD606A32D
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 19:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D4BD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=cYoot7un
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ede35b0cf2so12750205ad.2
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 11:26:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794598002; cv=none;
        d=google.com; s=arc-20260327;
        b=PdpXdhUPVB9A8Fvp4ZSAvjc5ZpcWeEvGg4goXA3GCZ9f6JA4nKOA3XT3tB0Pb6Olfc
         DCvI2eUVw7FPVw4gfWJw+/K7a6UnrbousZz27eoVGIXwLfIJJ3c1fv563Lh+nFh6gvIQ
         XWxb1iy1gBa/tc0ANlmOSnZdzFtLYRBxP3E4O89LbIUQ0i2KVCx7N8qXeGhDNVW9HNEO
         EOUpEzbpJDPMTQRvbsvcrv0aIEAH5oIfaQBIpJ+YUTm65qUtjvk3rsdtVZlbwr9DcD5G
         miBsSROT4ztZk2yDokSG99O4b77GrI0KHxSgB0HM7uK+B/mL/GRskXxVTVXXuh+/HFcC
         1tSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        fh=ZsA0ceWecPODh/1LQdJjhVaj8katIiJdbePECaecaSs=;
        b=F6Jx1YJo8Wpscr/KGq8wwd2qTu2C40Gf6Dp8NLkW8wfdqNndRxsjoLkFAPW+YDRuqz
         wDwVauITHfsDMITLv4eYHy93a11uN50n4O3+CKv5WQGl1GEeWk7sTzfO1S38rlnUluCQ
         4Xx3iyOUDtRyPDnlv/9nbBTOoQjM2Lxw5JeH5xYwQtM5VboDCMyBcclqjnY4q/QObY1j
         sFEx5cWP9Vat/M5Muh9vJTq07vnqZ7MnZxWicbikqaePIQOBeVKb4ZpWI0VkChSWSMJd
         yi5rMt5SfKC63lTvaDc1EeUMC/bQlNPRYe5MiUdvBMXsF+rsTsNeXmAIw6ND+lz8hPC6
         uJ/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794598002; x=1795202802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        b=cYoot7unQPS/3GmA5SC0wFl6UOpV/+X6gCQJp4wBxSFo7t2KxJa2fZxp5V/cjZhU8H
         slv9FbVon/Sv65B6pgIsLRT7xer6EhVRTchVk2j0FwTg/ZfPdCLxuy3ivzehlC7Ly+c1
         O/MRP0xaSILFZNeFpSGbvp17p9I3PnfASo9NsG7qF7v/TmIgigiF5PEmzhCdvt6pDtVg
         0gNogHERceNCbPI6Nj5kOMrza+2ofQdvg2z+jsUWoyKcWjho6jjJeDMso5hWtHjx1Rwf
         mVDE2H9V5hW20AAM1g26zZPvxNVNeEguHXmLWgTkLjcUNK6AH8Jyb36IPwnnjRvJE8h/
         R9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598002; x=1795202802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiRuS99+AkTRz0MXcWmZfyNH/KXYZ+AP4DTphBGSVM4=;
        b=BS35ZvyXkubGuPrtfrWRQ8AA3f5CMYJvykuiEehXWF6HIbvHhgZ8/6XGgAO7ykZGQp
         UVAuBqJML0YAPGBTod0RM2hEw4JHh18PVD8VOwZ0bMQJqvRsQMya2B/S5h76FzxyCyWN
         Nzkgx2Q6Utydstjkd77MELW+/8EM7b8upAyMny1IksY/1y2guVQ91G4ZHH7pvZDJrQjn
         j7CirzQeX5XnIjJ18dmIPNF5JdUz8DbK7TMwqtbD+yK2DX8ceYdIt9UF5Sjg+aO3ksk9
         d2NVUnWo+h7RIRd5Gjz6gv5VAlj4mtF6ycZNSdu5SMquDo0fcN6sPkRtbcsXRhXpVk6B
         uNag==
X-Forwarded-Encrypted: i=1; AL+hErF6kM+W+WohNhEUbIrAuA3Phl2XIZ0lXCN8T8PC+lQpleObdvV/CZHC2B/UfRlTxQ6ej8v2l9LJ@vger.kernel.org
X-Gm-Message-State: APuU4Z9sZRI3XGi0j3Z4Z6EgPafERRy93XIJZ0PSgQst5NgEW+skS9+Q
	Hbbvrv45Qh7q5HPP20KwVNzC/qvG/kIBXA5SGpQEkCKP+vAf5NpSejjZAl2CBTXdRG6q29rLcE4
	ONeel1I4P6FOkjOrldVABO9XwV5LtqW4HglFVSdUW
X-Gm-Gg: AYBFou37a4yZpOMd7LhcWNhNpSrz/kCaYkgKqQD12Crdmiy9n5DI0mUgOflNajTZBLj
	X6c8OR9Tgapvi3HRROnRej013BQ+COFZggbh87+0gmc8jYwGHaI2KZXyh6DjcHLtuYjmFwMsFT4
	01PscA7BM+3p0uS1lhBpe7j0GkNlLqmWGVBg920rNTnlY9/RKIajcH9PKWogcOKPnh9rJ2bnIEN
	DN9iO1M8670esETKzR9wmUuOFQgji4T+/DCpyQ3cB8SS1qHURPDv45exZnAvJbsikBIdKiWCDvN
	REDHDjQeANjXzTysDQ/18Y5xf8vYVGS+7tew0FOq1Z1MC4/QjrRaavI+S4HkZECmXE+oFMTV1PP
	YcGFLgVO5GgXSZ+hLIAnjGvo7EYZSAdhRd2YbLjndU7jmM14p+oL8U3QqzYsbDy2gZZGKNSv1Dh
	TIe/8BFFCpC0wNlA==
X-Received: by 2002:a17:903:22c1:b0:2ea:192a:13b8 with SMTP id
 d9443c01a7336-2ee0daa3657mr34970525ad.20.1794598002581; Fri, 13 Nov 2026
 11:26:42 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com> <ad935fe9-31c6-4b64-a715-4af428b389b5@schaufler-ca.com>
In-Reply-To: <ad935fe9-31c6-4b64-a715-4af428b389b5@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Nov 2026 14:26:30 -0500
X-Gm-Features: AclHuK8_VELfOWb6QxDH9msFQuAihFI-MTzoli1CQDJEubxRePim00n173V_ijE
Message-ID: <CAHC9VhSzdLiJyRfv2+rScvX=6ObQavHvs_UbNKFDabJNzwC0Ew@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Jann Horn <jannh@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 12:17=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 11/6/2026 1:40 PM, Jann Horn wrote:
> > cipso_v4_delopt() operates on the ip_options_rcu of a socket or a reque=
st
> > socket, and tries to remove CIPSO options from the middle by moving all
> > subsequent options.
> > That's not allowed - ip_options_rcu can be read locklessly and must alw=
ays
> > be consistent. For example, ip_options_undo() reads trusted offsets and
> > length values from the options buffer.
> > Fix it by doing the modification in a copy.
> >
> > The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> > propagate memory allocation failures.
> >
> > Triggering this bug requires that the system is configured to use CIPSO=
.
> > (Setting up CIPSO requires privileges in init_user_ns.)
> >
> > Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Sorry for the delay. I have tested the Smack part, and see no issues.
>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks Casey.

--=20
paul-moore.com
