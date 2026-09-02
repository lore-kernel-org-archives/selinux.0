Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B774A33E1
	for <selinux@vger.kernel.org>; Wed,  2 Sep 2026 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362503; cv=pass; b=ebFheGvZtXbJHo5xy02IT01mPoufJXf8YEOKxq7boLpH084Dr6MIiYpgq6t5Bylr0HctKY/ZeaFHsYyg02PU03TaI8gC4ZmgL4Vt9wwoTGy53pYo1Shgm/MUH1SO2gbdD1KVpYk9cTy7vfQr/ILAQzaOk6STlHuGZYLFw73o9Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362503; c=relaxed/simple;
	bh=yO+NiU01/pbgzkDIrYw8AbIzOXQDy0WdINfcl8QaRe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsxHPDzyH5OCIxjVARawxAGK1QhWi9vTlBumBDw9vgOXR8YvFUW58u49p6RyNePk1anSrfsBVB52cFR0o8eSGKNz0aR3prIPc2Xkrx9ZUBRnMuGm+46lUEoejoD6o1bMBrkVldyTXpUk5yrt7jY2+rGXQ59laS38ulGPi9uLI+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5lhcVyU; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5lhcVyU"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43b7e186a0cso693367fac.0
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2026 08:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788362501; cv=none;
        d=google.com; s=arc-20260327;
        b=o7MlOZY3DYJFHAgPtmKNPnJyHqyDBFVy0MlFZ3S95lgXVAkMLhosV5XOyRGV6WVHOe
         JYrUA9sO1shdI92841QuP4pzXVKgqwrPsy794K2GzS534z9uVNm3cykUeX8VKBcvTsH0
         Q1znrz7huuZbA8+vHH05Wmc9UXCD06mEpHlUN+wgF+b8AEBr64+EMtN1jdCJhjGAjGKs
         FDUYznh38TZVv/rGLVkIs+2Lnelf8f7V1KXIU73lR3h63ILFDfjho8KdSI3XQKOin+kW
         cIhgXyEJ/CmFBPzO+I6MqEIr0djcUz8jzHcYcQuc6VT9K5Rou64I16x7jDsp8oPqjxX/
         v7lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yO+NiU01/pbgzkDIrYw8AbIzOXQDy0WdINfcl8QaRe4=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=BmRvYvwCLfDDvv26WXbFTJcUD9N1tDr4uYiCxTAmqEMFkiqU/bTygqM7zMv/4cdY3f
         VbpMkeJgLyJ08FKW08GFioBhZ7gCUpjNlEc0TuQEgjPwtFfXiA/qnJHsgS75h8hRJlyM
         ZdRuPqpmvybKoZ8Wk2GGmn4iQLkomYwfWrVVENnAuquDLxaGxGXvpWJc8htB1lsTn8cN
         XT+e/dIxsPkFAGUaYffQAKYQ8uWUFrjYS/jmzBjgJMNmFBhcclo7UJzSqEDQ60PWP1wZ
         F2ooEaak8hqJBUkXcC1Tl461STsI7VT29oNtkzUxWnu+No0xZgE4c/NUjuR0r9822UXF
         we2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788362501; x=1788967301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yO+NiU01/pbgzkDIrYw8AbIzOXQDy0WdINfcl8QaRe4=;
        b=s5lhcVyUFJzijF3G0VqpvWi/005lMsS6OoaCBab4L1tPtO0ZrNBHVpek7CP8eLN0bk
         khR+JFG95IRP2sm1AI/D0WpLmOCDp1H9K6bYPsa5JqwAS1khm0ClDnAyJCXBcyv20QAi
         MkfMBRPW+W7anK3GPZ6PPlHeoFXXQO/DmZuirdDmgZYWxUDkM0hsoKTBhxOjd9dKISy0
         xYS6DkfUlwLF4x+3p4X0vxbW5PpRDbGdQ5WnZo5usxCwgSpE6RyybKHgED4kBNtm+kpw
         7eRAc0j8N0o5wyo8yUxUF6Ja1KUtH6mrMrVXHncn+elsqZm5Lm6mn0DYEcN2W1dgI3BZ
         uLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788362501; x=1788967301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yO+NiU01/pbgzkDIrYw8AbIzOXQDy0WdINfcl8QaRe4=;
        b=DfN11ZvZs6QBcLclbJ2n5OmCy7cvCQZkQl7odw4IRwd0VxILpK5sKMoEjdPkDAYKv6
         FPCjrLKrJzUwhbhWSZd+A6mS4OMFYvvX69jDOFTaJVxZP6dQW9Ws5VmQ+DTabfBG8sNV
         inHCz64p1/84zmmVLPhBcPjcROhRFAxiNbZKxx3CCxhY+3ACAXbchWnAtjC14dC4dJtl
         w6fcftE3s3t6SJMWb6XLdkdHwZ74twIRNCwl5XqYHtJ9Zfzl5xBDo62XOLMWZfTuv56D
         37Cd2eou2Sukw3Eh+4uOwt+6GAstVCCBN1VerafKt5gBFBD4R4l6FpANLFPYjSBlGCYv
         esZA==
X-Gm-Message-State: AFuF++klyJbR+Ml9+NAqx2n3HWieF/H1oWvKdrmt2NcrDlgluu/Mvk32
	v1tgl/FGh3DEqI4zXZyU5cJjIH7hM9HMKs4xK9N3U2jaJ3zc9wgJk/CVLD2zLlii8p0/RAKcyqP
	mz81XoD0LCzfej09tLF9MPug3YrlpsmM/NA==
X-Gm-Gg: AR+sD11bGF0V+Tn4Uvm75tmxa1WBN/5wbR03b3BsjlDgb0+oaYDHSTgJS64DRVf00oi
	XZEKSfh59E6GWsneJQYZ9bLs+Vj26Qf6niQdLkaTtN0FqqPtn+jOmbXOqtTeATeHAkXweUFSGVd
	Em3/IBQyWe9mzYqItupRls/7KxwsP6pC4bqUgLowiaTm6FN6r4O+9ps4bVJbKemesLfYkTgv/zd
	edkVDzSItkvPk4oL8NJRzLWW2RoIKYAQVrg0lDoLaHF2wsdSQy0tsI7lrySr+yU5NfDRHq1ag4a
	NMbFn5iEys46Agc5ZC3VRooRx+BaSAxH/9/i2ZhJvOFE
X-Received: by 2002:a05:6870:b0ef:b0:46a:deaf:5915 with SMTP id
 586e51a60fabf-46f87eb082emr5078992fac.9.1788362501047; Wed, 02 Sep 2026
 08:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902113834.2886601-1-vmojzis@redhat.com>
In-Reply-To: <20260902113834.2886601-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 2 Sep 2026 11:21:29 -0400
X-Gm-Features: AcwNN1XpIuoQbTUikHx3PwEP-vSxEpllqKkbkXZuTAF3sFjmXXwHWHHNwW_IB3Q
Message-ID: <CAEjxPJ7HOKL5RSO9xSXO=ZhFfAA5kNQr-Qjggxrg0bQbsTsTVA@mail.gmail.com>
Subject: Re: [PATCH] libsemanage/genhomedircon: reject users with a relative
 home directory
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 7:38=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wrot=
e:
>
> If a user's home directory in the password database is empty or
> otherwise does not start with "/" (e.g. because of a broken NSS lookup
> or a malformed passwd entry), the HOME_DIR template ends up being turned
> into a regular expression such as "/.+", which matches any path on the
> filesystem. This causes genhomedircon to generate a file context that
> relabels far more of the filesystem than intended. Skip such users
> instead of using their home directory to build the regex.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Do we care if there are other questionable things in the user's home
directory field, e.g. regex metacharacters?
