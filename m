Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CF3E5A2A
	for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414463; cv=pass; b=qXctC4+a8LB23JjaPLOcyVfALtPwNjfoWLLY6ZS2mJsomiPnmKdZ8j2RaV+dpY5AF4Ahb5JmBbyLxYOmZarkh8VUBmhXFG/Z10VbniMI28OWDu/KGcYJIrM8zPHYP2WxvUBYHbBO5ouexBclYAR+lzu+n17V9A/gXQPIgV9ZR2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414463; c=relaxed/simple;
	bh=v0avcBDuRuU+usnj4A385pontfIw5IxN0NVR5FSJvTY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jkGXl73GNpclHuufenVL0oqEMcymHOvs3hi3heoYquQdld5BAmCxfIsDlEDsRoAtSSnWTAxRP85P1VsB8uB010w8tOLfnxaMloXs9fhtUYW8FMvKEQJNtql1NjfAQlpNRft4A/lTORLUFyMUhPVo3IrLmnsg5Zn8Nazpcsnd0Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5ZmUuJD; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5ZmUuJD"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab432273c5so15058657b3.3
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 05:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792414461; cv=none;
        d=google.com; s=arc-20260327;
        b=pHU3zggm4pkNwjNL+s8TfJzoQX/GU08ags03hVpvwUvANLudhrSpna4jFJOai+zW2G
         cGNwK6l1dAqk02E/A17iq771RFfaFv/8/FLFyGCAFdBARYbbgYKZRmljTlP6gC7Ctg0o
         ShZsXdf8yrNm2Nc5POk3RyupL75aH9iBSGzgP39PbOYH+2qQpeZNAfoJ+vrgZqbAN0Xt
         B8DRFrhw/UaQLzsWF+LBDm+40tRLcb2dydU4e9Au7CkC0GD1MMIHJ1kzJAIFmhcEstAp
         LZpi/aDbXWmKFhuQBk/9IePsqiDX5ZTSXGUrPury9OQbDBOxv7U+rWZWzMgUO1rWcOia
         orVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=v0avcBDuRuU+usnj4A385pontfIw5IxN0NVR5FSJvTY=;
        fh=oUd6iX6eGfmfzSvqOqHtUAkZ8nq97+hvXuiTZgFFhEY=;
        b=KuA9K6cvW46/76KMQfIIy2GvF4SuyT31iq6bjZYrWeSN9LgKUp0QHiJiw7ha2TFP9K
         1+0+OpbkrhnWG49E23tw3gjgCWIRkD2pHli/kAmFzE+tBQgli9QWQxWvnzhcqHqMHo3p
         gnuhsZHdGbwkPZMqRSckWPmCJarT9wRUpCrymyOlbqW+nVduUeaSTaz/2IXJeQPqVuEd
         r2nH372xKv3tRUXUoe4uWNBQMY6rX41AKmY5fwlJBw6W0DTgPbQ5KRvSI8DLc7blS5Yn
         FCP5vTlFSieILjlKsAO/lpi7VY3IpjLla0HudMQ4xzjc/WO4OFWntgu9YHoOMu7CJU9L
         gVfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792414461; x=1793019261; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=v0avcBDuRuU+usnj4A385pontfIw5IxN0NVR5FSJvTY=;
        b=T5ZmUuJDmGHA6yD3IwL6yixzsUDX3aAXXRTFjkm5cc1cYonf2vbIURm3mfAzyeQnDp
         wX/oZymo/b0y5GT1XQO0FLbnngrOJS7bVVH0YiZQh9D6Ox1WQT2cUn+qV74M2PrTOB2A
         PPsp9eZK6ZMmJLz29osrybSz2xkoQlJrVw7y0/QyHWNOg9G0nj34zxyouBPlF5SKCkNt
         E/dzCBByeaV7eWDC1N6+YV7TmBt+b3Kqmn8V9FXsz6cl2GQkZlhVbsQU46dVm2EElxmi
         vSQm8GASs9MXsUHjvZfUo3MoFtPRUGqaxIjTAwuGNZGKJW6WL/46gcCjRNNYQZIz6axd
         Vo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792414461; x=1793019261;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0avcBDuRuU+usnj4A385pontfIw5IxN0NVR5FSJvTY=;
        b=gvWrKHEMDyqv4tRTmif7uMSG+RfnifAmWaFRXfznwHq1asjuKjH0H9IqWWClwjwkPn
         6ihTp+a0IIP3q5XtE+1b3Upbr/UFoYZHBmXZiVAvdzGBQRmLFdlwa7n6xRPWH/QReCPO
         tfN1wtiZngsmYfuuVel0GlKBGyP7NzrlLFeQZ2bNwnUz1Dm07PDHhPoC4rdddxDlbLEw
         0Tly8WlGYV+vJOeCnM3zVWuEnyxcDS5poZrfQ+PYW+zaUavFVsQpA8ygZDGPLoTqfBwC
         DFUSz8312OVR8n/jgspab513CfuK0gt1BOH4XxfEiugyFw/1kIAS9c530pfJuDMPZ9Gt
         +C0Q==
X-Gm-Message-State: AFq9FYKteuPDj2V0Lyu/QfYu70CTwtNtjzVbj5GNddtF2Ow876A0jd1q
	SaBvDmypKnehyMwNh2TqsuhNjdbxo3UYrBxUrsYlqfyxZpCuuXUXLPGr4t7ne+TcRrE2tUM09AE
	m9bE6RmykYtGLpP8JeYQpC/+IEECOXbdVF+Y7CQw=
X-Gm-Gg: AYBFou0muP6QNWEMc9KDRPJ5u52RqmPxQGFsykcOYD1e233J+g2FoNnrKUse3lmhx+v
	tlKs8E8+u76q4E2E69PB2rqALRmChIeKG60+WEQ0ysPIFMX17sCHMl3G4qNLna3iCsbZw/+s9+G
	pKpkzjN/SxVXvgzq/DHRmJv2bBWGxSjOqSda5L/Kia86oKP/2UX0LS+A2CzfTRMcs/mBc/AsXXF
	rDk3MUD/Vk02QDvXPl36rAxieZJlEois3erfdxYhwXDBDwVkUlI8mRbNavENQ9wzzNCRb4jCcoN
	KZywvHAUGhuR9gcYoZRyq5Yg7FGWZLFJkUQXugV3c/TAvFAPikJ9Efs=
X-Received: by 2002:a05:690e:480a:b0:677:ce61:dcf with SMTP id
 956f58d0204a3-679ca8a552bmr1638848d50.77.1792414460774; Mon, 19 Oct 2026
 05:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 19 Oct 2026 08:54:09 -0400
X-Gm-Features: AclHuK_rcWQIEe8ZJNoEQ85CqRGBJ8DgrjAIGy_MLO0QBRhTp_dqZ3EZfzSbZKM
Message-ID: <CAEjxPJ4nHQEt1ApaA9Qbt9Y1WQpN1y5PM=Z8mECKhdJL5dYYJQ@mail.gmail.com>
Subject: Updated SELinux / SE for Android tutorial available
To: SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

An updated SELinux / SE for Android tutorial is available and linked
from https://selinuxproject.github.io/ in Google Slides, OpenDocument,
PDF, and PowerPoint formats. Note that several slides have notes in
the Notes section that provide important context for interpreting the
slide.

The content except for the agency logos is public domain and can be
freely reused with or without attribution.

Corrections and suggestions for improvement are welcome.
