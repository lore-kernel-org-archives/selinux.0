Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C93D8107
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696455; cv=pass; b=rft7NNdGufzymbdwdS0ygieweUEsYUIyo7v8ClfdfqzLvSvOeqRJKpTrrPxDCOoALxSG32DXpk/T+ddbubnViYKsEPP0RWykavjOZfDO6N0twDsUkUySEsL3lJPqu8lFbOUr3zqZD/JaSWkti2kZkvqrK9Pq0niGNdl/AdyObYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696455; c=relaxed/simple;
	bh=YIsIGW2G+ZGPGw8o991amcLFP9avzxbHhyWf4+3hVwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1Xs2VKwBb/POokFUjToQrD2ms6FzCTLZuY78094RyXFLjmi+srYUGqg7j3Pc8fquMQmvZ3P9RYaAxk8KS1bf+TpfR+slcZ6KXyPNSDC8mB4D2YHNyJ7UMOEoxWxNM9TFtvfRiVogvdfQD8/AtUySfes2ICEBh5B+ktQxzCOyqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj7PAlRe; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj7PAlRe"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4ab201ebso4222795d50.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696453; cv=none;
        d=google.com; s=arc-20260327;
        b=NDana6l5yPjlBvtqyQR0W7DfoLheUMeAc1SP0TYgMFLV0aYi1PGO9DyiwgMcMF9XLR
         N79xeT4H/FR4j46d/yKDuOr7MaVN3TQnmM1HjYyVMKBxgJIf0iMZNQCVUobRuwdR6X40
         2I88oIUkzcTuz1ps4UMpMFe0iAIhlSUxcuRQYnxLOAEMieHO6IVjOuEcSnqDW1jiaEgb
         +wsnE5L3OYtV0bHeERo+h9Mxn5/ylThzE00x9JKN8AC0rOICQbAkcuiUoiV7CNmO+GES
         TxYMsRZInNGo+SQG+QlU+kY3C0CrZrH5aUP565UiL2Pxnkl+uYLFGWn5ZopKQs6BqxhP
         GxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eXo1XfObyKoqDtUpdPj0k5OCFS2INt9JJo7CBlaO7RU=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=FxxmP8k0QBFOyVXTEt1/LAm+l1rCrlv2/BTawC/xqplu3MZGb+0c8ocdMu7ys+bDCW
         NL8eak9mGkxBaBV7FuRPLvQ02vFsy6tusGqpcGvGo+2c+Cjm+bJN6Q1Rt2z3uxSUo9UJ
         Znd3mRMJR1PNAjjwxJ8nfLz8GnuMY+mYe3fpDxMj74gGQvfsucoqbUEJcu92S3MTCNnf
         vMUgcpgaBTXp5ZCvYqQ4ZBttgW91oiKPwjs1qD1Tz43oY9tcrZ92uC3L37JZX0/YjAck
         PI8MHLg5OjboL9NvL2mw2oUrhOVfegYkHlT92HoqNmfE6kejOmA+rQm/Jj1w5Zv8rreb
         O+hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790696453; x=1791301253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eXo1XfObyKoqDtUpdPj0k5OCFS2INt9JJo7CBlaO7RU=;
        b=Fj7PAlReUC3ntFC0hXFQN3A/W6R9kRtS3xYacuigI7v1Ks5cy3TJLunopr0Mvq7EQM
         UAa9bFkgx9nOvldlaOi7gT1z+dfWXCBfop9QC8B3olVJUyXhHgv6LIalgUXiUWTSed5T
         t3mRxOMfIWZ6VpPrnSVBbS2KB8ZZuwenK3J3QpzfaHZ6ExaX28tZ0wh73ZPZ4HgAQ0NC
         FVHL+FBa13ol3pDPc+Nr5SlBfUe61MIp1Dk8AqVHIyMYsPL7fT1UjGZAsP/2jxwgFDZ5
         xnVXumrRrybuRRmqjnAbgLZ9o4BnpvdQxL8/eZSoQE42TfkD2Dg/11BuYhuvLo/vtf2a
         CSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696453; x=1791301253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eXo1XfObyKoqDtUpdPj0k5OCFS2INt9JJo7CBlaO7RU=;
        b=ePtzKH5OtWIuRsNwO6YNUCS6ObizlzZ/sRbLblXWk8ETmN9gJNt5+9WkPXlc5jB0FM
         lZhiZqN5bsbW3RE7HJe5Phzdm6eqCpfXCvjRycMRB6InsSKo4BB1rQpvXY/A6vurcart
         byAnxt6JGrcxey/lwch3c8g5rUGQUc5zkCT+poGXohLXNHXbaKch7RAYwmrYhVE+Wm0N
         9+1RVW/oF43vcBXt08eMVYVB7AUyDRlHKzfBy/XpH9GEkzajHokoOPtu5I0wYvQ9Hums
         u5KJ70/Wlt3Y4JQjwnN4QYfMjukZ44NabgclC1Ic5dNJJLICePz+OoekqLyuuNCyCYVe
         v8uw==
X-Gm-Message-State: AFuF++nEhgvmR5iQsbDRjZrOGSeIsK8RvTblp12AomEyyJuTRr879vO2
	quwirR+f8GNZeSl053Y6eNFEqfB5ukHYp7Els20CWC155ahCp5v16zOQC62JvRZytSNKV2/rZYE
	POaYAvsc8o+epXm2CHjZBCRTawvvHVlF2ip/A
X-Gm-Gg: AYBFou2Z1pLwUmcEdtFlaZt0ff2LHMs2TsXd5Vo5KrcOvyozLl+mNn9zQm1ItC1zc1v
	QDNaeQ+h0ueyEDP4Uw2ScBVGNzmp/WnpywPyj4cKqpv7CIlfPKH4OBTN0lHuy3svCYFqFdCXhyc
	bAKulPW8wm5kGtVwOULCPEZsBWF8274HaFz6v+6nQ0F0+yByVlxt5S25PdW7XEkRAZCXa2crqhB
	+y9d9LT2FFKXw/tOkv+44w2HrneF0NNAnWs/odqzBPLrzVnDoOE5Jy/aZhTsDEISMiWjX7YuGJy
	ylDYErWr0z2RbcCC7ERdEDoJ0sderLasQcFSxND1JHWeLjvT60MVovw=
X-Received: by 2002:a05:690e:12c8:b0:675:34b8:78a2 with SMTP id
 956f58d0204a3-67534b890a2mr3633529d50.92.1790696453517; Tue, 29 Sep 2026
 08:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de> <20260928174643.2458710-13-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-13-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 29 Sep 2026 11:40:42 -0400
X-Gm-Features: AclHuK9gR8Q9VfGCY_7jxs3RjQxMVx3PJG_Ff_yIMqbuf_E7TfaUqSh_6SsLKg4
Message-ID: <CAEjxPJ7a8HzYXM8DqqQn6U3nmWk1pk_V+-9V0Op6stb5__2+AQ@mail.gmail.com>
Subject: Re: [RFC PATCH 14/32] selinux: make sidtab_init() return void
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> sidtab_init() cannot fail.  Drop its return value and the unreachable
> error handling in its only caller.
>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
