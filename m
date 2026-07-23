Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9F36606E
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828251; cv=pass; b=YGMOxrhHCP98W58IANIoZKpA0femmLAq9oIaowYHJl+ye6JejFKN8ZCwKzYy/RzaJbhAKwSTJNwo4sx7xVDF9cwN0VWv41CEKzNtN8D173J0GWAXCKYlfDzbkCq2kuHS8Tx0YcQgjlns/KE55NG8CtyR3JgvamroRseEcx99Rqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828251; c=relaxed/simple;
	bh=GFeS4In3AgkL2c9HozZZO+cH/BDOzTK+pRU3lKIjv70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lV0lOB7WTz+IeKHwtPIfDpeNDay4HsJHQGfiykPDbXkdxBgPTJFRk8ieRMJvhdwMWlYaZAuyDAL4Bd+6joXMhHjw+p2VlGs2YFKnQIwx3Bv1o+DWH6oMG0BHcXql0LWJhbgdpp4FOztgP3IYxIDZkc5vg+UGmhs91/naNWtpAPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=St0nVBgD; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="St0nVBgD"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so627963a12.1
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 10:37:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784828248; cv=none;
        d=google.com; s=arc-20260327;
        b=Rvl4TbgGMIHchPX5sQGdtcpN/OzgJ+g7Oz8lbRJ+o+8/SOVz/CGYLtWD3RXRh3inHb
         z6qxbfHPXj/wCJ6Ar3741u6TWeM/zCbGW9Kv8AgImBUL3TRnDOV57kp1FqHlIwMtzvBH
         zL3w4oKc0n3c8vkPuLtwQDZN3uIUEWbJyCo3Cr7LolRNRs/l71rgE71eRQB2EETYQsjd
         7BEbHD5BaDKs1hJVqTfNB1NQAjsrQBQKy4iGRASJQ0sNyyRiMmZqTd3sR0jDTN4PxHiY
         wFLPuJK5v+2T6sYwSi3AEgeEjNb7qUjYsn2K21WcpZFCZlBw1Kwn/IoC2xy1lbzUr5yI
         5mfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GFeS4In3AgkL2c9HozZZO+cH/BDOzTK+pRU3lKIjv70=;
        fh=FXY3j2QXbXTGHbNJ8rCvBj1hTll2yb3oPWyk5qufJtc=;
        b=HaUXgbAiEc3rJEwKPFeG64QJqZB3Z96yL5FtmNV+Og6RnQTzfc3UQLgZskoMirlUZ5
         iOvwRg+O9cKR1gokoz6Rdjz5F6zyihWk/k2X1mQnJV7dj/PYuDOCkgsFufQKbV5rMR0D
         BXrBcWFfiHD1pukq7VsmQdKhJLBRYbMmQO63m13Fp5XNhCyZqvSLw62WQdPcW+n7pYaB
         kB5ZRjCdiskk16HtMIRRW7YbI3l00/vEv2HATXSqor6SJ5q8fvAj+uQtw9F9vrCmhFj1
         78jrYfafhppQBJcfE7UKqf2OfpAItFPpX11ET17PxSStBAPGXSYqFFeRe5reNEIcY4Hc
         mWxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784828248; x=1785433048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GFeS4In3AgkL2c9HozZZO+cH/BDOzTK+pRU3lKIjv70=;
        b=St0nVBgDh4WlnNf/iD35ySOS+Sz1ym2gVtn9MRupC0UjoYSB4ZhOdTUr97ih7wnnaa
         uA67Kqb+G0rjf/A9DKJym3wYAtOPhx2wP5/np4JS5bNvlj1EQnONAHaSfpQ5zkuFcraD
         uZtwRm25gcdStGrtuyusuPS7l7CEm/RLoLd984gsOL6R9GeVsnCfRHOmvDCd6003C3jM
         wJJ2/75rVLTumQZH1anYyxC0LcLTpf/7kAtEWUMttHFzGT3KchWfFFrsqrpl2HdM75f3
         KdEQ2V0lKBYZ+H1PK4dcA3FgV6LfPnBtHDThuhhckat1yMO73Aa6/Knic1AUGNDQp2Ll
         fxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828248; x=1785433048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFeS4In3AgkL2c9HozZZO+cH/BDOzTK+pRU3lKIjv70=;
        b=h3cD/LmZCYG4UnFX39P7n1hTItf9YWqcf8Jpt9gvPmtDnRRoV7t4xtBW4NjmLec4t2
         Z0F4LphK95vJtz6WJTcuXpGTMARXw4pJcKpggHzoHxtMMmh6oXVJAMfN7F4Amxvj+lAQ
         JfJMtl/tx3iOFj3pFA6e9MF+zW0Vz69KrMl7kq+VBnt8IHERVxm2hwPCfuDg08KhA24b
         q+sTh6wkTNavIndHf4KId8KE1EA5vU6M16lBuMX+4F3IVpEehjQuV20CL+GQNgNgIkqS
         NEL0V2LCZNzvqIDuhbi288XI47vrkcdll79M4Kyi0Fbd0zyQV8pPUsJGT7/K2tgVAm9T
         0jTw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6FnmyrG2WFXc70+o87NJYnpWgH+fmfcsi/7jvBXvtdP3eL+PH8e/Dmzi5uV/5Ih4tw65p4W/k@vger.kernel.org
X-Gm-Message-State: AOJu0Yym96dto6psIkbO4cM58q8mrLwq0zEwz+UlvIlu5hUIYanDe21B
	dQHBz9GB1y4UW45NAL/6v/1a+HwHJMV9Pli2olzbAag91CSSWppDbnVgpuT4fd82lxcfMGcFmbr
	vbpDlX11f+YUQkviHzL2uXFOFJjBZr2gUeLT5l6pz
X-Gm-Gg: AR+sD13mWvcUfZ0ac++2UHt/oFkp4D2g3/opNCQLjuGKUs0LEkJmUykvidp9PiZQCWA
	GJQniH8pJ/9IBwfudIlJvVMLaWOb303GUsEEPZPR99BdTWV9Pi+zDTqw9SLPftKQcr90sfztYjd
	R/ElRQpRK4bmvhET4hSe+qbJcbuu7osxAW1GT/RGEEx0jZVEjbzXSlGJfGNHorfdYzZfbj4YmyY
	9mKeEm9TVONjTJhZlcbK5EtJWkf9Sfx8ur+EQCuxlTMAvY7DU8R+pkbLFRPsQbV0ChIF1/J
X-Received: by 2002:a05:6a20:c79a:b0:3bf:a698:ce4d with SMTP id
 adf61e73a8af0-3c44b244083mr4418150637.54.1784828248202; Thu, 23 Jul 2026
 10:37:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <CAEjxPJ4cexAeJbQdDWzD=NiyukP_THb9PHhTYi=n8ww+3bwrCw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4cexAeJbQdDWzD=NiyukP_THb9PHhTYi=n8ww+3bwrCw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Jul 2026 13:37:15 -0400
X-Gm-Features: AUfX_myztMdqHSe0HhN5syWLvwWfrTZd5HW9GKD0wmKfmOIDNsULOf9f-9umNE4
Message-ID: <CAHC9VhTpaqdbd4NOZO=2G-OneFTnoi4BtA-JeB_o=hQO6kCUWw@mail.gmail.com>
Subject: Re: [PATCH 1/3] SECURITY.md: Update security contacts
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Jason Zaman <jason@perfinion.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:42=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Jul 23, 2026 at 2:24=E2=80=AFAM Jason Zaman <jason@perfinion.com>=
 wrote:
> >
> > Part of the annual cleanup of security contacts, drop people that are
> > not as active committers currently. Thanks for all the work over the
> > years!
> >
> > Signed-off-by: Jason Zaman <jason@perfinion.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
