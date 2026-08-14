Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3147FB10
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731806; cv=pass; b=d+tx8VNFy1X81vNfFmBBvAXQEIdZUphk5T5puJjd5X6nEkpBlV2ODvEoGAICeUOZcOzdNkW3Zw0yOX1oMqljhJOZ5FNnLkijVzzYjDlbq8pYwc2kjK37f5b4HZeFSM3EJ5bFO12ZX3SLJJSxLVBYoyTXm1QNohf5u/MGiQoEsbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731806; c=relaxed/simple;
	bh=mALWxoejXfZbsXXLFjKzyEDL10mYeSz+kb1min1UD3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EwGjoJ402vAJEt1r4b0c7cPueVD0aATlfmFz0Pazc/IuOg+boM1eIDN6JyxPlTw8UfWzLxzud3lJC4I0PvhXKbl1xSuKMVwE/ruZ5db+lqlT4PxakXUVBKLUuEpGsVIskLMbQ47QmcxTrWmNB+Y3uag4MkMChcpxU8VVP8iFVzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+p1Owx+; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+p1Owx+"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-448de0cc236so828291fac.2
        for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 11:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786731804; cv=none;
        d=google.com; s=arc-20260327;
        b=og3v5+2JG9KrZWIJzubn6toB1gtBiSeNUHoRegayclTYn83OfKE73niNlbZMjNABdp
         DWCueoSJRGIBnxvvJxBlUeoeoKWz6JjfQ759YjRQzRga+yzo6MxHfi+Md6UXhqB58qHJ
         hYq8n11tUI3mSEpEl5YdpeWzFlthM2lOqoKbSG7hKQZhMmc4R4jcxJ4FXE8lOzTD4tX7
         TB5LjkfU731Rp8/PP7np1jInf/yFzx/ETXaFNAqGZ8FXqsWCrBauxLcOrJmSji60JccZ
         cYKKRY8zaAj4SIr/CZJqBZOTwvdT+Ugc4mwa5HT52xHgq8UXUw4C1T0F0vyCtVFR3NG2
         S4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mALWxoejXfZbsXXLFjKzyEDL10mYeSz+kb1min1UD3k=;
        fh=y2WBs16wsg9M0AK64SzZDcmD4Evo2ThYxXK6xgDwcAk=;
        b=NAfyDY1kHDRVbDXJ/pzYuH8JjW3GQfMky8SmNa0+qgCl0JjIm6KVscPKq3BRxTjQ0t
         Zo4Tkfk0McgtL1ZiA91phTWf1pdPtCtbPc/rliaIfjKblZ2GH+ymt1quLDnzTpAwWQPZ
         I0Pjo4yds6zFcNn33jNKEudqM2QYkhQ/H6j3c00huypToVLM6ZxbLYNFdHN5Hiog9JD8
         N7jJaGmaHKKB+qw/Otc269OGWJilWLOiEhdjB1DG/FqZYS2H1ZTuwan8d4+Z4twdQy7u
         xhvilSfZI5GHLZ9MFMrL1qXVyq1kp5yLIdoBz7gJo/tj5xcD1PwxYooBjCTTl3IwCqfQ
         MZaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786731804; x=1787336604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mALWxoejXfZbsXXLFjKzyEDL10mYeSz+kb1min1UD3k=;
        b=I+p1Owx+eHq0E4E6V2lxlXqXE2luK8qDLx3WYhfxUncWJ+ot1phE4tN8gJLzTwxuoi
         UI6cRBQBzSP7WMzL8BDUjoid8KbVH8UAPY+/N43HKj9CGpKqZnZ3oyeRvONelmdXS5qi
         arK6JjR/L8My5j2ozOC9yfuqmyhFg8S5w5XhsO6FYGTxiZH9jeOGZcDmlLSFfO6D66hl
         e74SPvHR3AtXYkJBFrmcT59wVz7+3zrfnLipJ5gqVPk7qPRhDdUjCkMWXfEm84mAbjke
         t2y2uzs8K6VEBxDnt9MfP+IriF1nK8jq99xRNxH+O6zxZ1TciSr3rANAj6hr6Rpkdt0O
         Fqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786731804; x=1787336604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mALWxoejXfZbsXXLFjKzyEDL10mYeSz+kb1min1UD3k=;
        b=jlDFYqxgCxqIYqWw7UPeskOHox/+Gxim/m1DZ3Eagai4RbziM62aiNSVDw5EH7nkfx
         3fYr0TxmIQ6/2JYQaFoUzFOORX3x7G7VG3OjCkkMzAcv19hkVz3bt4qaE70aHCSb4HZJ
         hRbtIAzb/PG7fPlB+WabCOw+N2DLo9vOS7ndG7w1E4eDJtWoQ35OaO66piKBUITN4feg
         dcE13o6RMPofdroaxhDD0Bj/HDOjFfZafGaxmm5zSkK+TxVNX/U4fl2eGK2gZqWp4X+d
         EoQNcKRAofU2EVsFd2a7OX6SYdIzhY6ef4wzLfRXehYfv+KJAIFgA0Cqm8uMGgUDSR6N
         bhdg==
X-Gm-Message-State: AOJu0Yzt15fn/LzkUpQO9WfjYL28QIOIaXgPqOvcGlVLXPJby7kV0kJR
	LuxxnOjX39hMfcyvml5Pn7/dNBadTb4ocZaPVCje8pQcxIzcMK7uIZhAmbbp/8TsHkVoByZuyVE
	3QEwqefTwFfmaKRHn5qcFs7CElEgRhXXqoQ==
X-Gm-Gg: AR+sD12u+0wPtArls3eAeg34y/etCUMktuGwOCoacCv0rA1RVd3beXMhLaHOxSe6+jl
	0BafD8BcV8IV1OaWSLs1jggzYvwTAwpzKg4LgV7y8cX7CsiiHQudYW6VzFTpDeCd/5rwQCYRFR8
	7ynWH5nbrLuKdJ6aydONvgigvO8Xpyb9YqRHjh8Mhp5eEjv/M4P8cC6S84N+aTkI2KZHtxGb+k/
	pp76xpEQXGZn8pgI0PS742ok7WNmCP6pWMkwS7fOJDae9KIj5fDpdjpnqGyhePJw9KK6P4Y+JgC
	Ho14nFQC9HClZcDq6LqYqXI/qkM1qUT6i+M74a81CafX
X-Received: by 2002:a05:6870:5064:b0:457:494b:1548 with SMTP id
 586e51a60fabf-45e91e4943emr6777171fac.5.1786731803936; Fri, 14 Aug 2026
 11:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814124425.202855-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260814124425.202855-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 14 Aug 2026 14:23:13 -0400
X-Gm-Features: AUfX_mxj1mWq89OpG82YPC2H0Y6r48DU2jS7vHS000zsFzwwA8eQ3_HBUuy5oUo
Message-ID: <CAEjxPJ59nWxWcr6xDEqDPVisP9OwpGsBjBZXekTv3j6wAJZQ_w@mail.gmail.com>
Subject: Re: [PATCH v2] README.md: Further elaboration on minimum policy versions
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 8:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Provide further elaboration on minimum policy versions and
> considerations when updating them.
>
> Acked-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
