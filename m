Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7E6221271
	for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673348; cv=none; b=Ml6hWYSGZ5bzSVJeN8+ip2C1Uw+/lBvBMPc7lW46PHOeHPJErK2KvHzktAr/npF8SPr1xD1L3Lypg+S0UgqX3u9jErUq+Mc/KzlG17xkQXag1MYi1WKCpeRaeLumkDpDVwanYPlP2T/rV6cp/f5mi+cS4svA6lTqF0jDsIeFNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673348; c=relaxed/simple;
	bh=MqV25iWj23690D1kTofUWc5gXlmC1JOwdVWdQKgJE0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5kCjkQUsRHJrmW2Zy++T9virgGRxhgSO5HRUSY4GcKuZVKHIDmRVnHmr3Qngqww8+s073lA09CWl38GpCMFY4JudggyldtG/tXoeq7c+9oLA/EQjPz7MGyImNf584m145U6cwV2PwPkUFwtmXbN9OT/ow483HfhtdXmGxyaM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkONFF9T; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkONFF9T"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so895599a91.2
        for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 13:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763673346; x=1764278146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmg8PkPwMlX7+C+H4DLYa/aa3r4/eJTmhyeSdMb1aOk=;
        b=VkONFF9Tota5c3tOo+uKbcGZLRyLfMopUghE+XIb3ATQeOmvXh1/nI/d5BTpmnJJQ2
         XzvRzaZVG0rtfmV4U/5TLYdpk+8D2zqBJSj+S149mgpsyhA3yVYTEPskRarb9hQ9Gkq+
         qbqLV7pTvhaMyc5+VY8NjFRXgIRw7rQbpjuaig4zRCzuf2RpUV6xPqY8Y7OTVkG2HqLJ
         2a3jY+VtmetspeK1nYYhJwrwDcISJfDQPGHF5xicOWPdqb1T+nnK9b9pOhLzZ7GHbIxu
         3bw5+Pr2BkEdLsWOLdtb4Wtmj/YUiFtmJ6KuE8t7ecgz1Lpt1Pex2KefLK8oL3nLiOLA
         OhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673346; x=1764278146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xmg8PkPwMlX7+C+H4DLYa/aa3r4/eJTmhyeSdMb1aOk=;
        b=VVOJ5w5V3B7sgwbIiLjruRtoIFMshxnRbkvxMYXK9s1kG7eXmY/RiOAu4N5FhUsqUr
         laUTGBkpHxuemfX0KBEw1GL5LAFEp/NxVs8zyZ98roNqdJS+JqR7XF79pegcfcKf7dXr
         5JHbyF6Zhj1XnPnx8vzC93bgpqGePnUDNg3Fo/RaYwx/v3ewxUV2C0ftjxH4PRqGJ1Jk
         2Hv0NI10FG1Iku5jUcxITGTS1LbMOmffWsb8vEeLnJrHJHxZg5KvKifuGEDIPSl29Qbe
         J3uE+fC/E14AmGoUEPgLnwxG/gz0B9S7CAnvCb/HBVu3dAbFWE3bgp/eXtXb3yfA+AIJ
         2WhQ==
X-Gm-Message-State: AOJu0Yz16gv1DOf1WdkTUfrRieRV/I07ZjXV4T0LpE2CCk6pd8BnDroK
	DBYIQnFxnSzUZj8lUaEF9X++c8n3vKr9VaAVyOwPGnGLj2QZ/fvjG29dcyTRZ4kVm0ei1K3Oyga
	YU49MpY9rPRRqC4YdoHsI0LIc8yEXgUA=
X-Gm-Gg: ASbGncsepFstbOJQcbq6xbAzvIGpiOfrBv5OMNtgV0olTNUf4/2QosL6ZTmPXKRsJb/
	CK0N3Nv8lescQ05H7ZPnQYUCXV+UCbr76dti/0wMs5NpVPWRxth++7F53gr5jkGDtHa79rr8VOB
	w6+QJN9DZtX9rnZA5fGQDi1M4ukUGkkpAV+BS18flkPof3HE6a9MxBW3a8l7hhrel7JgQOMTNoU
	oyyPk6Mxi8TXNTx8BWtr+zGeUn4fnhi4ZBGGsgEhj2uR5hP6AhZBiwTEmjnkH4jy1h2wSs=
X-Google-Smtp-Source: AGHT+IHA2r9Wd615agDW0MWmTT7GbJBoNSQGiS2Jx2xTibIvrrlereq40Ne4xrTY78y2+ONQMjISiX/F8hwxYgly4qg=
X-Received: by 2002:a17:90b:57ee:b0:33f:f22c:8602 with SMTP id
 98e67ed59e1d1-34727c4b44amr4320176a91.26.1763673345970; Thu, 20 Nov 2025
 13:15:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D6E78BE1-7054-46F2-AA10-1BC2E0D4A82B@redfish-solutions.com>
In-Reply-To: <D6E78BE1-7054-46F2-AA10-1BC2E0D4A82B@redfish-solutions.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Nov 2025 16:15:34 -0500
X-Gm-Features: AWmQ_bkUKZ8OGON-Yg2AMmgjlJuiGz-v6evlZUajLeDw272D4bFED4ChcL71BX0
Message-ID: <CAEjxPJ7umghjAo3Yg25QsYL+pfQ27bxOvS8J2S5-MSKtKZBXww@mail.gmail.com>
Subject: Re: Adding SElinux support for a service
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 3:14=E2=80=AFPM Philip Prindeville
<philipp_subx@redfish-solutions.com> wrote:
>
> Hi,
>
> I'm working on SElinux support for a server that talks to a PCIe GPS card=
.
>
> Is there a guide to how to port a new service to SElinux, for instance ho=
w to give it its own context?  Or, in the absence of a guide, what GitHub p=
roject can I look at for the supporting commits that were done to achieve t=
he same?

Can you elaborate a little on what it is you want to do? Do you have
SELinux enabled and enforcing already on the base system and just want
to add policy for a new service to confine it and/or control what
other processes can talk to it?
Or do you also want the service to be SELinux-aware, aka a userspace
object manager, where it enforces its own security policy over its own
objects and operations?
What's your starting point?
