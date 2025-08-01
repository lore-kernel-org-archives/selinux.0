Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC64C1AAA1B
	for <selinux@vger.kernel.org>; Fri,  1 Aug 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071089; cv=none; b=J6MgIDdjmXMvtQ/bxIJgwOVq03SH1buxbLEbS/kfigSBFPsOi0X5+kYI2puCWnTzhGp1uwC52zokzsLgoPO4z0zGrNzFA2gbjdptX/+sHpcADDM+7LPF9jB6EPT9g/9k7/qyUyqKRxDUzwbnafg3EZaABNyo3oK8s5PzKX9Wc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071089; c=relaxed/simple;
	bh=WDJLA9ighCKoylyABheWwKTmuNnofiYUSj9IDBDQIXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sam43+aMgvS01++Uho3dnhiN1jbi0i30T0SAthMQd9em+gn7DlnikXMAeQSeKMLHSkV1vOIbxcJhVQsD3r0T0wbNQDRf7bxXxs+cGYyEWt7PQ0aMUV6TeEWNFT5ZnY8z9i45uMVnU1pRg6BGPoNel+tmTaD3Y4ZuzwvErBkEZ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVo3BrWp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVo3BrWp"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b34a8f69862so911105a12.2
        for <selinux@vger.kernel.org>; Fri, 01 Aug 2025 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754071087; x=1754675887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaGut5K7hIPAjaQAByCM6a13t7ENdfTlI5DCUuXNNL8=;
        b=RVo3BrWph18jdJBDirzw/qIYsF+4/RkaS4PjiqEjDANpAIhSXw6T5wveC43V59fKlY
         tf2Mig6WZcRfeKfzLVXJ6SuZUtOCF/0KGF+ug1r/aADyvmfvqmnzXIK04KAyBohca3OR
         eGjXoYpD4iofuYNuMyRnxMS+K97GsW72j1JNjUTmEbVWgmPxNpPJeyMtiR6j1F6sHcwQ
         pYTKQI4bbljvOj2FH8sZdPDvypZrHAJmK4AaZpQOb14OYr/NvXc8UKHzhx1c1lQJfu0m
         4s+kTjwGjCXc0h3+fpOjfo3SnlxQWQx7/HkoBmJq0nwQ1i46Qvk9MDKuymcOqwZhUTgc
         B58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071087; x=1754675887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaGut5K7hIPAjaQAByCM6a13t7ENdfTlI5DCUuXNNL8=;
        b=Oh0jWRAZ1ZbuEiOaX3oDrY3HGIugKJPfg1zXVPi7nVx0J1Fh0VYtEYH8Jm1ebJyGjS
         JPbecbC1bnidGQhtz4OrXapdvQUeWuDblDSyq9hDuDHS4JDyvONNyK9nPjSX42ZaT88I
         eQ3zj13s+IwzA1g44xj3e6f+v234wbzW0HdlgBNCtrrG2HBn2RkMUVLic4DotvHXgi7+
         MWO4KAwljgLSaJEAaekK0t5KPN7LkIlyfB7BWo8jiJAKEYWAL/qMn9Fr0Hw3j+xdO0RX
         J8LfuGJGeEN4M4HnxeOUOXNO3pWZjy5PF0HRreM2DH5oZ6CSrgKsFdcT3GxwZUO4fp/e
         Z++w==
X-Gm-Message-State: AOJu0Yxx5ffEZtZ6Qqz+8Pt59WvwziHYjtgM2+xTvgECVN13k7xyu4eK
	qNqV3KWv/Ll0MsRWiWiz7+U2PDX/WGAdTQ1TBjRie3ctgUfOAl6M7GQJGsGBU0MMz+dgsammnSk
	ynTHlkXA5htot5gXsZ8usmAJoKTgitxPHpA==
X-Gm-Gg: ASbGnctnk2e16t5znUhDeKOlpwUZOBbeuV3IGC49S8g7bcvEJUSIuuBq7XS3sAg5J6f
	n4AYLq8oHaDYHauauYM1pGwj1hBLVftuhKaRivSv1fu2IIlZ6MdTIvEouLkbdz9a806xLPmYcHl
	N81zpPLWjONTpAgBRnXG7t0kOBVnDOMfjLI7/pQJRMi7nvmy/r9Y7dHMqOGHEitxJiBkZoN+nWo
	13LeMY=
X-Google-Smtp-Source: AGHT+IFKGLiM6wRbPXSoVzvGjLwIp5tOOxeeNkGBzQCS3jMPrC1gLjCJQenXxRDIMYuSv8XABclzttmI/welJWGEe9c=
X-Received: by 2002:a17:90b:3b44:b0:312:1c83:58e9 with SMTP id
 98e67ed59e1d1-321161da196mr878799a91.5.1754071087277; Fri, 01 Aug 2025
 10:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DBR9Z1C82MG9.J5SX2WJQ0UBS@gmail.com>
In-Reply-To: <DBR9Z1C82MG9.J5SX2WJQ0UBS@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 1 Aug 2025 13:57:55 -0400
X-Gm-Features: Ac12FXwNx0VHTgdb0Fdc4tMWQAMgln2VHpOnLvaUBaMvkxmGyfutHQkH_p_v0gM
Message-ID: <CAEjxPJ5OXCS1nkJzukkp61J3a4fmGeOLftTiDHKjQmPvDw+yKQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: refactor selinux_check_securetty_context
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:42=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wrot=
e:
>
> > No need for { } for single-statement bodies.
>
> Thanks, I wasn't sure about the correct style here as I couldn't find a
> style guide.  Is there one I could read, and if there is could we link
> to it in the CONTRIBUTING guide[1]?
>
> [1] https://github.com/SELinuxProject/selinux/blob/main/CONTRIBUTING.md

Unfortunately not. It would be good to specify one at some point and
start applying it. The selinux-testsuite has a tools/check-syntax
script for checking (and optionally fixing) coding style; we could
either duplicate that for the userspace or come up with something
else. There is a scripts/Lindent in the selinux userspace tree from
Linux but it hasn't really been used or enforced by most.
