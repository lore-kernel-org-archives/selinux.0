Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7C91C9DCB
	for <selinux@vger.kernel.org>; Fri,  1 Nov 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478950; cv=none; b=fuXTF+tGgizG7971N7g0idp/xTQQLJiK+nH9bzkQm+kX+oI3ie4XnCiPOQfiDtfW780J6K0wtkRPnOtc9fChK6yHVM8mJsTS3yuwW0Lc3pFTIS1E9zag4yxYhvqxed5DvHhAHxVFmPSLqtGDCvB3727hCzmnnRTcjJ27SloJ2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478950; c=relaxed/simple;
	bh=fKMkT3TROxajQdsDVduoRSDDqZfstQrOXKZmdCJ1I64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uswrv/V5UXs0uHdCtlTdY+kPGlpds5mzHInX+NBCo9OmJkiXYjPfrqb1TDbzDYcD+kG2zluI+mnNd7OSZO03mvauDBINdBYtRy1V1Pkxotb4NRs43DJma+D4dD9gQRDcKbwQnY4I7aBI2B2phctZZhR+Z5h3tNFtoZY6BBxocn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bRuIjr5f; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bRuIjr5f"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ea0b25695dso17770927b3.2
        for <selinux@vger.kernel.org>; Fri, 01 Nov 2024 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730478947; x=1731083747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKMkT3TROxajQdsDVduoRSDDqZfstQrOXKZmdCJ1I64=;
        b=bRuIjr5fyIpuR+g//5cQ7KobRapXnOK+/oGwb+Z1cJ/x9D6gyeBEqzSwQv04CUpnBE
         21zOHTwC5eI86xVZ5C8za4bTn1Xf0j4fwHKg2bYF9Qd9XlV/kdOmPZs6F5VvzpKkNhg9
         VjSVCo+MTVtMfOURS0cFA8bgl+DDiefWeqs+zp5lWJufPVuZihP2Mx4vHJcDbmq5eKlK
         VWTB9cMfQCNJ+z6z3u3MaGfuhSxmz4g0kMfcFZjqU3HBcAIw/LNxoZJZCMQPOkhfGYlG
         v0XqoRSr9Rqp8JRqckXIIfVw7ID8rtYF3RYYIFQ1h3hcmEctoO6sAFxdWlFZTnpaSstF
         znMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730478947; x=1731083747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKMkT3TROxajQdsDVduoRSDDqZfstQrOXKZmdCJ1I64=;
        b=YeaatpUimjGlB5b4mOjLD4WADySpv1dDI9dYbW/kN5EFeQHiVJ+HzME8tnT4UKhvVC
         aRH4ffoHTUEufPMjMstAT3IWOGv3l5F48kxQd6ZNptBgUCXRInMqAdnoLlHDr24rogSU
         5UEBhGUgsxQuBzG6Mb/LEB2Cu56VKfmD28YdOKjJ74BlxSyKEW8yB3lXedPZWLU5jGVD
         IQq1lC+8CrKosjAqfnszkN98UBDdsM3RIJLoUxPNt83T9JkGiCruRyrycgxV6kkAY07C
         BzPjLxpNVl/OApB2FPbLoCCmF62hPxlByCJrB0bJWww9CtbYYpC/fhZD6sNrE7ZWclY1
         Yr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkM7mKDfCaNHsNBbYwoluAN5PXneZnJa3kbeQVfdVuXET/QIgVzGaCNUzZZ1G0B3EDxhGHE/vl@vger.kernel.org
X-Gm-Message-State: AOJu0YzIyI+JULXyFMU/9nDwCLo9qgrTv916rzKhAV6eiNAEbfR0kbfN
	7rbKpVCWcFs+W6CRMHg2+DjirMTClqspZ9Rv1jrykwnPp0vQOsqoqLbtjqlS0EJK997e2OfA+OC
	/l4ZPxSc39p+7eoijOuOtyk5FbZmYhUbZR21C
X-Google-Smtp-Source: AGHT+IFs+kETWVMdVLzqFgUtLrU9XlTE9u5Wi5RoR1NsOxwN6KBMzdgC6ppcFP/VZqUNKPiNClL5fIAcn0D39qR/XrM=
X-Received: by 2002:a05:690c:87:b0:6e3:410e:bb84 with SMTP id
 00721157ae682-6e9d89950d4mr214759077b3.20.1730478946984; Fri, 01 Nov 2024
 09:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023212158.18718-3-casey@schaufler-ca.com>
 <68a956fa44249434dedf7d13cd949b35@paul-moore.com> <ZyQPfFvPD72rx4ME@calendula>
 <ZyQRgL_jWdvKgRl-@calendula> <dd727620-9823-4701-aaf1-080b03fb6ccd@schaufler-ca.com>
 <ZySCeoe3kVqKTyUh@calendula> <6a405591-40c5-4db6-bed5-8133a80b55f7@schaufler-ca.com>
In-Reply-To: <6a405591-40c5-4db6-bed5-8133a80b55f7@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 1 Nov 2024 12:35:35 -0400
Message-ID: <CAHC9VhRZg5ODurJrXWbZ+DaAdEGVJYn9MhNi+bV0f4Di12P5xA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] LSM: Replace context+len with lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org, mic@digikod.net, netdev@vger.kernel.org, 
	audit@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 12:14=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 11/1/2024 12:25 AM, Pablo Neira Ayuso wrote:
> > On Thu, Oct 31, 2024 at 04:58:13PM -0700, Casey Schaufler wrote:
> >> On 10/31/2024 4:23 PM, Pablo Neira Ayuso wrote:
> >>> On Fri, Nov 01, 2024 at 12:15:16AM +0100, Pablo Neira Ayuso wrote:
> >>>> Hi Paul,
> >>>>
> >>>> This patch breaks nf_conntrack_netlink, Casey mentioned that he will
> >>>> post another series.
> >> I have a fix, it is pretty simple. How about I send a 6/5 patch for it=
?
> > No idea. I don't know what is the status of this series. I would
> > suggest to repost a new series.
>
> I will post v4 shortly. Thanks for the feedback.

Please just post a fix against v2 using lsm/dev as a base.

--=20
paul-moore.com
