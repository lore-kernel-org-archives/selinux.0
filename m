Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C92BEC2B
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265629; cv=pass; b=hZd723fUIe6UAt8+b1Uu/Cgwhgyi4df0xTIBnR+uNOwrUpCvb+P5NM6F3SRJ4boEaFqkXd/qtdnktXJtWo7SD1RARsPcRYfWd2ig+8swi3R9/YN7rlBiQn3t37/Ty0HKqH9QsTB0IU+2BJlKuac9SgnzpE+uqKSs0vFwrhxMlxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265629; c=relaxed/simple;
	bh=5Jd0oEfZFAK0qJNzIv/5de1glnVcgs/Aro99gELXTiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfpCIV6BuWacQG9AhL7eRvZYeRjqK0kVEJbYq5QgTjp7Zp5Gskf/HeTYG/I4tdiTET+CWKbZV7hWDPmdd7AJawv2qC1P1+OJJ0D4jXuZbJjugvF2i9OcOm1x9wHzhbvNCkAqRglX52wah/IFlZpMYW3b4derkTHQz5j339YkAbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKnr3YWJ; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKnr3YWJ"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b1afdf5196so982922eaf.2
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 05:27:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788265626; cv=none;
        d=google.com; s=arc-20260327;
        b=T5OLWTnLzDaHRItCjlrFdChvqrvlNfRkTKXy7BvGGfE9/NNbHkO78J+lM0a59HYuKA
         OpK1Pi/ysERUQObj2GxtY2kVFRStY16mbI3ynaNNdon3DwdCz5aKG3GO28jz7ajUHt72
         aIkiAXQhOuGPh6Gz4DgxNsXNQ2M/b5t/5j89uvPhD+K3DemeCLrjxUDxMWYuHN9qYzWQ
         8nyKEK4dQwuh92gt5kZ86RY3L5Xx7tu0sXr7MN4ixfL0zJqQSLn3j+tu2Lsno5YmSdFG
         N1FX3sq1t5mJcGIrPg7dsj0XkEcZYola2wdaoqfNGl3MX/1ahp03fesaIR2SOyIatdyV
         Ngpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5Jd0oEfZFAK0qJNzIv/5de1glnVcgs/Aro99gELXTiY=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Cl+001OJr1KHZle6Hl7p1JZzjGxAugn4lqBz4wO4bqDmhpvVG0oPDs9bt5xGfE7Qcu
         D+wzu4HrA0Pv1EhCxN7aH8ZQ4j3MqUDFU3syvSsrSUS0J12VbVY0tCXJKBYRlKIPYaNp
         9n5y9pRWxGj7jFBluintxjw4QZTtBXjTsTmWX/B3G4B4x5qRxMOHtJk7/twaLphWOXnn
         6HcvS3csookYYbjK9ZcpOk9KS9p5cr707JU4K9gvvNHE1WeM6gvf7QVzmDLOdhff2tLJ
         4YiUWWl5M5kVJjJokEBzFRCHpF75lkDAiiGybeQM+sVt1PT9RXj/J7EJKqs4881VW2uV
         KhOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788265626; x=1788870426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Jd0oEfZFAK0qJNzIv/5de1glnVcgs/Aro99gELXTiY=;
        b=eKnr3YWJedeLaQVGaVLmIy/d60HRxjOYPApRw7DCK/gumIbCRHL/Fzs13MThqDZUdy
         LWRcMaMKrC04FMzBMeT5ixBbUqtyaDQPJ+YCvA+pIAM4+RwDgbHDNd6LCdDCUwcDxx5B
         LhA3yRd0sqW8hL8mKaMysPpvep4Awwwy/ie2V6rdFWhbLsM2dUjkGlaXppbjQXS/rN4J
         negxQAI8TEitEvJStE3qn3UV9jCoFc9poRCaekl74qfej+Z/6GiI5a4yorl+P39QRh2x
         oWMvIp1IZ5pGw+WVhnEXWUAwISHJT7Nm/RCTD5GlXg1HWM+8fTcXq7BDxAlRYYYyX49k
         xdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265626; x=1788870426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Jd0oEfZFAK0qJNzIv/5de1glnVcgs/Aro99gELXTiY=;
        b=LXAU0BDM/8hncBd1tOZVLzlbxBteqKSwP2ES+BZvG5yaZKvpJLhHK7K2Zx4Eyvvg6E
         YiyFvos716xkgyiLtRcxqvHhe44T5kZaxmmG7oCGnoNcQvCwZ4t1PJHqBHRlPmgZONTy
         lZfODCHdWrNUxhbdbPQ/Gtoq3mbQZepmk3Dvhv476GDhLwb2AhGGF6v/Ff4FzNXrU/xz
         5o/9Xqmz9PErAWSBR6Y0Ny4+QB2JjQVji7QN91V9IgwyDvXREVKHrPz+fj8toBMIp5T4
         Am5U7gtCmDXnj3iP0Hr6cZimG3PziJz0GH1FMAqWxs8T2xzY63Glcs7HFdrYIiwBdQOW
         Ffgg==
X-Gm-Message-State: AFuF++mlm9O/SU+sEhfPlHRdaH8YUmRByiT5lWM3JFYf+8KpWENME1Me
	MhwFZp/5Zp7kDixXAIiSTdLiyKDdvnvia9Y69uM9ffFE3zLe372g8ev8G/ARVwyHNPSYgmWVTIV
	hialrr+El5o1TAhQgGGwiOpVrImLI6rDj44LB
X-Gm-Gg: AR+sD124Tz13l1GP0UT+ymCF+A789gnJZmJcy+rG1kuub9PuNT3hqypSzZKDCqOf+mZ
	M1Aia5wjq/2VOv/D3yprxhF2Vj7lcHCLxqn4NsOwySUdaG2Q/IuHLZsIfCMMRtgvGKN0URs8CuL
	zqRBsSZ9eQA0bgDhW3eC2ZHZbxckEWK+mH6cnrhdwV/rfetWSzbt6bvdcV6iP7cfGIuvqPP58Zy
	fjt0rSPzi1+tDEBlmEH7ywfh8YwjJ22FmXug6nijc/jkXvZCGFHg64O4SzalvZMsGjNvEQBkr17
	7eMMMrFMH9/d4ar/Xas4+fxKp/aoDaXhc10aOfCXjHEg60qlgLBH59w=
X-Received: by 2002:a05:6820:180b:b0:6b1:31f:b0c5 with SMTP id
 006d021491bc7-6b1c6715c6cmr30548230eaf.26.1788265626472; Tue, 01 Sep 2026
 05:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831185851.80078-1-jwcart2@gmail.com> <20260831185851.80078-2-jwcart2@gmail.com>
In-Reply-To: <20260831185851.80078-2-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 1 Sep 2026 08:26:55 -0400
X-Gm-Features: AcwNN1X572B78G5Zvu3d8CZqoYpfrkX6_imZUeAQNXIHT5A7s_xB8xb0QYDPp8E
Message-ID: <CAEjxPJ56CmGPWJyZRgPa=eEwiugUcx-q2LUs6=fcR8ssgSeYFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Check for mls components in non-mls policy
 during validation
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 2:59=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> For non-mls policies:
> - Check that the level and category global symbol tables are empty.
> - Check that the level and category avrule block symbol tables are
> empty.
> - Check that the level and category scope bitmaps are empty.
> - Check that users range and default level (both semantic and
> expanded) are not set.
> - Check that constraints and validatetrans rules have no MLS
> expressions.
> - Check that there are no range transitions
>
> Fail validation if any of these checks fail.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
