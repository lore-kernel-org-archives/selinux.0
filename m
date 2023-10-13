Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8F5CDB47E
	for <selinux@archiver.kernel.org>; Fri, 13 Oct 2023 15:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjJMP7T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Oct 2023 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjJMP7L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Oct 2023 11:59:11 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC0C128
        for <selinux@vger.kernel.org>; Fri, 13 Oct 2023 08:58:39 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9a58aa4983so2635565276.0
        for <selinux@vger.kernel.org>; Fri, 13 Oct 2023 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697212719; x=1697817519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMItJNtAIYEkraNi4OzcpT9oMRd15bEoOJ11eN8TfFo=;
        b=b+bIPD5rDGaHUZNiD/Hci3joe2NwS2ytptjMz52FcNl5rN4JRwVsg19lcpMUvTVa7N
         Ze0tSMYG4rYEevBkGJQ/u9qbgUrfZk5YtKYMtr5bBMRgGq/w5Z4BumQlghg24DF0/brx
         uiTFDM3PTopTHaNzjPkIEevsVubVnp+63qHsgpk+E5wob/y7oYq82Xvk2hxTVeSS+qYg
         o684xa1Yncf4aUQHLlRrDhDwArpd2h8GItTz03j4S9TtnpHQ5ZULoMfxUp9+qAmGKTKF
         LYDFGy7IDLG229jxLvEli5V7wtFJ6K3ObQIcarV+Gr1iz/K9kb4zgWD4qzJZxg2j6SlD
         EMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212719; x=1697817519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMItJNtAIYEkraNi4OzcpT9oMRd15bEoOJ11eN8TfFo=;
        b=tMHo4MAs2RASRqXTCHqg3VqJBOKbr1OfwiIGUT4DsCLIlaps4HGpmLKwbs68EIWumn
         me9gYWlyOfz2bqXR/gvIcCV9p5h7MqjWT84CT4AZRiqpaCYFygKwqyuYD/qB8Dx7PMe+
         biziGWg/Wo7N6Sdl5A1YB3MCGVRsBEYvaSM/Xan+MiLhqyLDPi13SqtY1tVgNPOdPkpy
         J42n61d2wyBFfcXxAxRwhx6JYfnLJ/LKI1AxK01vrjQHphySsUIK7ya3xRl43k8DKXgG
         5XwE0WOlqVAC8zD3qSw09GMNsH6mpXTtKmka9N858rRWk/FLTpwk79asTCzJYvj9VQjV
         HTSw==
X-Gm-Message-State: AOJu0YxkyvaAV8PRhS0bWS+JewgKXFYTCOpbILT0wqfa89MQadB+EdRX
        nH5aq7ZVAuhhxl/u8u7gnC83w5sokL1EC/aCqEImzvgTZb399c8=
X-Google-Smtp-Source: AGHT+IFfXq+KuEVLnyrqOduru2q+B/1/Ku1jruLwbTUIY+8j2o/tZcmkee3ENbrcKnVBf5DvXpF3mKAKyvSmv47NC8M=
X-Received: by 2002:a25:109:0:b0:d9a:b7cb:53bb with SMTP id
 9-20020a250109000000b00d9ab7cb53bbmr6002422ybb.11.1697212718736; Fri, 13 Oct
 2023 08:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <ZSZMGtFFycCLmjNb@dhcp-0-146.brq.redhat.com> <CAHC9VhSC9BeD+mCPSoDp1fphV4BMAxmBVp2pL+wVoFsmYC121w@mail.gmail.com>
In-Reply-To: <CAHC9VhSC9BeD+mCPSoDp1fphV4BMAxmBVp2pL+wVoFsmYC121w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 13 Oct 2023 11:58:28 -0400
Message-ID: <CAHC9VhSSxNKsGUJfFwvCLjxgEZj6N4BkBzNf4ZwuAfG7vY6eXg@mail.gmail.com>
Subject: Re: An X.509 certificate for selinuxproject.org web server has expired
To:     Petr Pisar <ppisar@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 11, 2023 at 10:04=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Wed, Oct 11, 2023 at 3:18=E2=80=AFAM Petr Pisar <ppisar@redhat.com> wr=
ote:
> >
> > A TLS certificate for <https://selinuxproject.org/> has expired:
> >
> > $ gnutls-cli --port https selinuxproject.org
> > Processed 367 CA certificate(s).
> > Resolving 'selinuxproject.org:https'...
> > Connecting to '207.210.245.134:443'...
> > - Certificate type: X.509
> > - Got a certificate list of 3 certificates.
> > - Certificate[0] info:
> >  - subject `CN=3Dselinuxproject.org', issuer `CN=3DR3,O=3DLet's Encrypt=
,C=3DUS', serial 0x04ef96d84dee2bf82c3fd430379377422cc5, RSA key 2048 bits,=
 signed using RSA-SHA256, activated `2023-07-12 19:10:38 UTC', expires `202=
3-10-10 19:10:37 UTC', pin-sha256=3D"MrgWqS/CGL+3idYpvJbFP3KfXfWmDboEKJTsCX=
Fmc28=3D"
>
> Thanks for the heads-up, I'll contact the sysadmin and let them know.

This should be resolved now, if you notice any problems please let us know.

--=20
paul-moore.com
