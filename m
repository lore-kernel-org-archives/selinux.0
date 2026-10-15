Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC234C1510
	for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074344; cv=pass; b=kDCmHo/CxBbO2B6dJvDCi99kp6bCuLlzP6OykH/yIAbdZstNKqxyXYxzD3R6tV/D+6thHjB+/WI6dHYLrPIgHXkYPklwkgrUtdprljFtUxwVTT+UbqogV7M35lKPkc/AAVVwxqyqo6ElAR08AcgVfSVnYRS16Vx7uDKxLOEsruc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074344; c=relaxed/simple;
	bh=KTp6MfgIsRalj6F7c77xLx2Fzog8GjthsdnQCFhv4rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPGsWENtaCsKeRwv+Y3gwjGn6SoABkOjKcwx54HznPcqDN1g2olt/48bJuZpFtpGDv0fWotALF4ncrhm+2Nd5x0IO9uuJjuyHSGkd/sx0036YZfj70qNtYO3NAZ0zMZUZLSp24fk+mbB62xcBMsyCZob+SXbm1pqELYhaHu8n5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPBWLr++; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPBWLr++"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67999045530so1613822d50.1
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2026 07:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792074339; cv=none;
        d=google.com; s=arc-20260327;
        b=awE8ePju7ie/oqZtcPJe/EEeBHkxjBlfUR2QgBnK/6vroquXavBlYGxOZlp+w+9g3Z
         vlSn5ovFd4a6Wh+qOVJU/jU0GkpC3ZtQqWr95ZrCH809Y483dL6D97LJYNwO9N9gvVIy
         NLp53MaM3JbFcIO42NX98GJPZGFMsiZ2e7qgGeNe+jgogL/RnnNcLI1VbHP/7uxBR030
         MpX9OP9L0tD8RmvEm8u9ryZT2m796LPh6bFXAjL3xU+GKYUu4iPDLqdGnLSDbjww/BAh
         /5vuLNMgbFWaVDFQCaFXw9BlY8X0yp26EoYgJUk1ljCqSJWtTSYNY+UhQI2areNZcaSd
         428g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CMgvUxB1dgQc5WQOP3eW+85x0q3n5JSFSh3XsjCk8lc=;
        fh=/ylro2kycojNQMvnSHIUFC32boeLWx2LWGPJCNKw/TA=;
        b=lfonAb07CAFUKBde8B1wU3Xie1xYc28eg2b8DnYqA/BW3Y7YcT9eh3YWI3sFJBZrN/
         Cq1/A6h+FqQ0cLV8t6QAUJo5kiE20Qc8Ax4wrg8d1EsXJ8M5EtPuQw4+/pUQQajuU8oQ
         DBDH5rehPNIjvkFGVaoee2XoiSo1FoR0hy1YZ9lOcmH8eRb5lQUF4ie/QOF8NCLBAMUW
         Cgq3m0A5owTBSR8QeVuMlLS4BJ2RBvrRw7H9vy2nXwt30LhLC9dfxfbES6AFKMgoH5CE
         OpdJFFnl0d22NRt0e99JzmT31Dma5gX6DbB+4yBjL8+JkpZ0o/kklb/NFBc8JUziSkt4
         knOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074339; x=1792679139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CMgvUxB1dgQc5WQOP3eW+85x0q3n5JSFSh3XsjCk8lc=;
        b=NPBWLr++2Uqm7YdtQtJ6b4cVg6SA3hIMOlVdRbnccc1AgmrlZ0z0yNRkXlZt5X7baZ
         iwrI2eKunVdo0LJO7brVs5Oh+gVceARlUvwGLQJe2R5c9E+LiBT1GFRboaAn+Pp0MGox
         ATys7AajHn3FgbqmY4slKufBnkZBuuGEo63iWbfXas4pHrFTVoHAOJ6lUzomXUIEclHs
         U0APiJiJh6LDI4hERUFvHW9errqeBF9/sAAW2y67cLXgV3k+tjya3ywoHzygjLTLL5Mr
         jgnQZvPCOz58JK3AVRZ7LgTpOH/LT3Ur8XZ0hSnQxTExoiViN6zwo0oh8mpSwZFh//tZ
         U2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074339; x=1792679139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMgvUxB1dgQc5WQOP3eW+85x0q3n5JSFSh3XsjCk8lc=;
        b=jfm5fHd1JhfXM8tk8Vua9dbtCkZbqOgJeS4+sHB1Wt5Uo24Ks1eqtGj2ZHW/7UHb8G
         /nfW8XWcE59GmiqMqFy/3z2sdjQ+m78mdOICthPsldiO5Cuqb9oNy6lVna4lF+Yyxx2L
         eXWntJG/CTIRJrSUwtRngP5AdH+OGKdR98KKE3WD7ulUKXaEbiQxG26QGayQ6RaidoR8
         REXFsy3gaqm14eRsNwk43W8piKy5Bu2AgcJ0xmtAmZeO8JVQCpqYb27nyEEcMvC/9aC+
         bZlL9RK4XNH3LzdTGlsLK7dj8nOS7jB8c7W0nAuENeIaJK9feTwxXo3Pe/COTHwmF3ik
         Bzsw==
X-Gm-Message-State: AFq9FYJTiqrz84Nxmr5mdIm+qpVd3n3IitaWMNPO861DzAkWZMTBEEnS
	qcr/1h/lLIHV2Ap5Vxx7zl1t4jDLaWtTQG0RCBa1VYe9SG2ZL3sj7IzdBC1i1dpweqdDlvSrxWj
	AHme1vaoKgE4QSxaO+M0hgKpzndIeKew=
X-Gm-Gg: AYBFou3Rx4Lb3iY0vzogzpZXoxApajbYq+aSkP0NhNiRL+7iGzM9iAYhiKPBt3bZSKA
	M6Z0AXBvNVKLtNmPvX0Lp4qVY9mJLe8AsVdZWvQopPOAN9FbNOlgJzkPJjcXtz7nS5JI/35eF5g
	JYrlPzKrNpCF/P+CQ3OMkUNDR63L2SwgUqU7N/155pzrDjFjk01CLD8Rk1Rn+OiLb83odQEG4lS
	JyotVyLv99hMIZ8kP1b0oc8wsOKxeJCKe6V7+qnCGerFwhMhY2ydUPhUXxQSW0Qxdd6+o2loIFO
	EZeGO0JFfZNI8Fe0JFmLHMI2EV0fj1JjH/6tn+k21KMBwfwuylhKsxQ=
X-Received: by 2002:a05:690e:169f:b0:679:a047:e27f with SMTP id
 956f58d0204a3-679a047eaaemr775350d50.17.1792074339356; Thu, 15 Oct 2026
 07:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015054535.844874-1-omosnacek@gmail.com> <20261015054535.844874-5-omosnacek@gmail.com>
In-Reply-To: <20261015054535.844874-5-omosnacek@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 15 Oct 2026 10:25:27 -0400
X-Gm-Features: AclHuK8qJi6Nu9fnubGOGnNWINlZsadLbwLBD3MmE_tKvegYcbjIxX0wGd0NCz8
Message-ID: <CAEjxPJ50eQ-4=nLKnOZ7B_A9hg-DRoqECcs=nQtixSA=u4QMaA@mail.gmail.com>
Subject: Re: [PATCH testsuite 4/5] tmt: work around missing rule for sysadm_t
To: =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:45=E2=80=AFAM Ondrej Mosn=C3=A1=C4=8Dek <omosnace=
k@gmail.com> wrote:
>
> The avc-check test currently catchesa denial triggered when the

typo: catchesa->catches

> testsuite is ran under a confined root (sysadm_r). Add the rule into the

ran->run

> system policy as a workaround until the rule is added to Fedora policy
> (https://github.com/fedora-selinux/selinux-policy/pull/3465).
>
> Signed-off-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> ---
>  tmt/tests.fmf | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tmt/tests.fmf b/tmt/tests.fmf
> index 75484f4..8f37bb9 100644
> --- a/tmt/tests.fmf
> +++ b/tmt/tests.fmf
> @@ -28,6 +28,10 @@
>        unconfined_t|'')
>          ;;
>        sysadm_t)
> +        # Workaround for missing https://github.com/fedora-selinux/selin=
ux-policy/pull/3465
> +        echo '(allow sysadm_t self (netlink_iscsi_socket (create)))' >/t=
mp/sysadm_workaround.cil
> +        semodule -i /tmp/sysadm_workaround.cil
> +        rm -f /tmp/sysadm_workaround.cil
>          ;;
>        *)
>          echo "Invalid STS_ROOT_DOMAIN value!"
> @@ -189,6 +193,9 @@
>      set -ex
>
>      make -C ../policy unload || true
> +    if [ "$STS_ROOT_DOMAIN" =3D sysadm_t ]; then
> +      semodule -r sysadm_workaround

Should add a || true to the end of this line in case prepare aborted
before semodule -i completed;
else the semodule -r here will abort the unprepare.
