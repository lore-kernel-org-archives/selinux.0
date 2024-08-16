Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060A5F873;
	Fri, 16 Aug 2024 03:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780678; cv=none; b=pXHNlVY0XX8XNQ1Ef5GuquW69VNi20fFWwN62GIT5sES76rStpqUVsrHo4HdKiBwgcO6bg9Oi9eJID6LnweyQE7yfC3JT/+DwTkq45sJK5cR0pMa7nVb80U9FqIFO2GFaQhG2Vmy8N+GqLu2MP/HXQKFFk9YOD9Lpj2aZwfgYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780678; c=relaxed/simple;
	bh=YakldiVOnu6xnTAnFekuzC5NS6HjKH7e6eWh7KI0/uQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaHvMnXpcdLuF78oJd0Np1ZTAyO47KrfSFOVQHTp1GudqGGIF+UG2u7Fv0dlwUcnvPuc5Yw9TRY/NJhTrsRoNIIkanWfnVqZr7mD4O0oYqiXqitPJidnvANmdnbXg6m9kpQ/YuokS9KhNysrXq5ubR9jIlMyMQ6qi30N+uUFP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IK86jJiG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK86jJiG"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710e39961f4so1198169b3a.3;
        Thu, 15 Aug 2024 20:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723780676; x=1724385476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtpoYBv6vUMp+t2dHSsWXB2QO2RkHYzYdABqbr1nJLk=;
        b=IK86jJiGcXaSQNqwuMK/3jIYXkgRKEHWdKIs916b5QXNEHMVe3tw/c/x9lfd1U6gk4
         dzKo5nYsyIpE9VN0cFszAWlLLEd27k7F9UcnNg9W9NRZg038lowCVY4pM9j5Q94ax9PX
         uiZxWtUks1U7/MXdC2Emz6oChCbHGd5WErwAd5o2u+eMrB43sKo8isgBg7rccxRBCnpw
         oRy9y03qDtYSkmLXmNKbp5c2jomrDcHfZNvZyMyS82jxEnRmEB8N+hHEE6jbgqSzmr5a
         vmWb+aGDqSadjXy47QjnPIOQ33Ky0069sCO5QpsbPTe3CF6iaQDyLN8zowITOkDCg0wU
         AOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723780676; x=1724385476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtpoYBv6vUMp+t2dHSsWXB2QO2RkHYzYdABqbr1nJLk=;
        b=IHGApGRWmKVs8+XnYCTpaypKccYsG/HabkDZPtdTpoxCXECwkTgFdn3FijhxokdLqZ
         IS24w0sBeLG2OATcCtQ9jZT1tW/p9Y5e2hJPVdobIfOjsel8lQ64Lq3DVcMGybWnFL4t
         yVHL4UdNvU6pERgv9jUekkxAMgtT5e+OOPoPSb1jCNZEi8wnRxVmgJ8F05eKI1V9bBr6
         DaoLX+wP+CIfh9kZ0o42KbpjwZGHTWKKVmn8Xw/f6t4VLK6Tz+APbz/+d9dczD3f0iNi
         omCKKIdM2U7ADLAdqntVGdVzW6Bsba+VQwgynFHmeciYdNsQ/UoeFtwTjkCWBHBu/u58
         eTYA==
X-Forwarded-Encrypted: i=1; AJvYcCUtgaFMK9JTqKXUkj6N2zDlpamRgrJ77DTmEN+ZMKzbV+Cw3CRuBBRbZWX3vbY6AhcxjodGG6PqJ1Y9CSimXedagUrg0kP9rrWD4OZ6nfnDdUCt0G2XGjIOtqF2fhA7ioTGx4LUEg==
X-Gm-Message-State: AOJu0YxGHY7/ewGq0RImTwwHjDn5zLUPBPbhWg66vcdE7vydtJUkDU+S
	3wA9f0mMjkILmP4BBpROGMjR467zODE4PBAQh4KgNF+elvD5fhdn
X-Google-Smtp-Source: AGHT+IG0AXORZ9AtrC3wtFs0x7MqUifhK1TPZlUUYJekfn7hWzUdtpHr6NQqJ3g6Pya7dO8KydvJmw==
X-Received: by 2002:a05:6a21:3a44:b0:1c2:912f:ca70 with SMTP id adf61e73a8af0-1c9050261bbmr1989262637.42.1723780676121;
        Thu, 15 Aug 2024 20:57:56 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3d155sm1749225b3a.215.2024.08.15.20.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 20:57:55 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: paul@paul-moore.com
Cc: aha310510@gmail.com,
	linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
Date: Fri, 16 Aug 2024 12:57:51 +0900
Message-Id: <20240816035751.62058-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHC9VhSrPS27KSG1_On8_WqUfR7tokbrmVwfW3+L_-XJiA=WZw@mail.gmail.com>
References: <CAHC9VhSrPS27KSG1_On8_WqUfR7tokbrmVwfW3+L_-XJiA=WZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Paul Moore wrote:
>
> On Thu, Aug 15, 2024 at 4:32 AM Jeongjun Park <aha310510@gmail.com> wrote:
> >
> > IPPROTO_SMC feature has been added to net/smc. It is now possible to
> > create smc sockets in the following way:
> >
> >   /* create v4 smc sock */
> >   v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> >
> >   /* create v6 smc sock */
> >   v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> >
> > Therefore, we need to add code to support IPPROTO_SMC in
> > socket_type_to_security_class().
> >
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  security/selinux/hooks.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> I'm a little concerned that the small patch below might not be all
> that is needed to properly support SMC in SELinux.  Can you explain
> what testing you've done with SMC on a SELinux system?

I don't have much knowledge about smc, so I can't tested everything, but 
I created a socket, performed setsockopt, and tested two sockets 
communicating with each other. When I tested it, performing smc-related 
functions worked well without any major problems.

And after analyzing it myself, I didn't see any additional patches needed 
to support IPPROTO_SMC in selinux other than this patch. So you don't 
have to worry.

Regards,
Jeongjun Park

>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index bfa61e005aac..36f951f0c574 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -1176,6 +1176,8 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
> >                                 return SECCLASS_TCP_SOCKET;
> >                         else if (extsockclass && protocol == IPPROTO_SCTP)
> >                                 return SECCLASS_SCTP_SOCKET;
> > +                       else if (extsockclass && protocol == IPPROTO_SMC)
> > +                               return SECCLASS_SMC_SOCKET;
> >                         else
> >                                 return SECCLASS_RAWIP_SOCKET;
> >                 case SOCK_DGRAM:
>
> --
> paul-moore.com
