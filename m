Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A9EC77B6E
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 17:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjDLRzU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDLRzT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 13:55:19 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72A259F3
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 10:55:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a23so8695601qtj.8
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681322117; x=1683914117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNQ4zEnfQewdYE3Y73LketNkSpHWhH+/ApvrYOYsWJY=;
        b=pCvTGDE+4qUjWeuHyAHse4QL2l1jGf/OoMsMHsSDfXayl+QsLhszxXA0r9f2J2DPiC
         e7HsLj9hW/6WUDJvajeYhwHH0U2haP86qqW7RnIa/tIwd64iYRXW16WkAne3FJp0RHg2
         yrQWx4qCkMHGHVKyW49bbmEcO5lXelhGpSvHye6NBYnFkzAcQ0CL+PQerZTX1T/scC2J
         W67h7ri7mBqgz0zvtqrN0+e4DhYra87uCr+xhniA325aBw0Yjz0HiZLJLNd91HS3IEVR
         Vwrv+yOg+/3PG3pkwrqOjst4hEd1EA6TwgEymVB8HA1ppQjXMif5fLdCdjqmSeNKLi2/
         MiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322117; x=1683914117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNQ4zEnfQewdYE3Y73LketNkSpHWhH+/ApvrYOYsWJY=;
        b=YTdWcc8PUcOaKjRoKkaRsJqaHzHsa69xcbJGsQjhbWwIfdnc3k2DTHX8M8RDeheHVr
         joHkGutwqDsYldlP0+VN+ET90DXlHiV1j376hHXL43fVmWLm6m/ixlk7gEwmQepYDnnP
         QSUp6oBll3GplyfHvpQBtd9BNHt89SvnB6Bh+TGagVQ8F/9k77Rl1KLjFYBh2oreDIa2
         shPFu8hIIxR5twpJK1GMexnCpFHBGRiPEDJzi9zTGP5CN7Sz9X8hKLCrbE4t1kkknbyL
         wcL/iML3XYaWxOno+c6E1wRWgUbeb5DScwySsfahVulEpWhUJHd6WpNumnjey+lMrm6o
         0PKw==
X-Gm-Message-State: AAQBX9cHrW5qpJFfk2aWO6EBP2z2RgzUffwY29EEVZ/g8pJDfSAr7s8R
        MVTj+hJIc82vXotiwbHqLnum9riMmlRhLLu+J3fB7pNA
X-Google-Smtp-Source: AKy350Z5AB+iEbG9zpCuXNdDIDeDFfo2BslHQhubBqPsczpPFSC+j0CDl9lX3829sRio1RLvPEAxz4YBUvpjPyGnnf0=
X-Received: by 2002:a05:622a:1820:b0:3e3:2af6:7edc with SMTP id
 t32-20020a05622a182000b003e32af67edcmr5323404qtc.4.1681322116932; Wed, 12 Apr
 2023 10:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOdf3gqCNHoFT_U8cDTy2v8oB-UKmzJn-hyai8Cn9=Zk7uuTsw@mail.gmail.com>
 <CAP+JOzReUxaxCDwdF57QuV0UqsNKBzcKk2M_PqUFLg_W-1kRsQ@mail.gmail.com>
In-Reply-To: <CAP+JOzReUxaxCDwdF57QuV0UqsNKBzcKk2M_PqUFLg_W-1kRsQ@mail.gmail.com>
From:   Etienne Champetier <champetier.etienne@gmail.com>
Date:   Wed, 12 Apr 2023 13:54:40 -0400
Message-ID: <CAOdf3goJUzhbBBcLX7wOsLzMn1dnnoANgVXePzzArU+9ZgR+Qg@mail.gmail.com>
Subject: Re: portcon tcp 80 change type
To:     James Carter <jwcart2@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Le mer. 12 avr. 2023 =C3=A0 11:21, James Carter <jwcart2@gmail.com> a =C3=
=A9crit :
>
> On Wed, Apr 12, 2023 at 1:12=E2=80=AFAM Etienne Champetier
> <champetier.etienne@gmail.com> wrote:
> >
> > Hello,
> >
> > Is there a way to ship a cil module changing the type of port 80 ?
> >
> > ie something like
> > > (portcon tcp 80 (system_u object_r websm_port_t ((s0)(s0))))
> >
> > When I try to install such module I get an error, I guess because port
> > 80 is already defined
> > > Problems processing portcon rules
> > > Failed post db handling
> > > semodule:  Failed!
> >
> > Best
> > Etienne
>
> The portcon rules are all in the base module.
>
> You could do the following (on a Fedora system):
> 1) Extract the base module into a cil file
> semodule -cE base
> 2) Modify the portcon rule for tcp 80
> 3) Install the modified base module at a higher priority
> semodule -X 200 -i base.cil
>
> The original base module will still exist at priority 100.
> You can see that by doing:
> semodule -lfull
>
> You can remove the higher priority module later by doing:
> semodule -X 200 -r base
>
> That will revert you back to the original base module.

Thanks for the hack, indeed modifying base could be a solution

I'm still wondering why the limitation exists (I only tested on Alma 8),
I can ship a portcon rule in a .cil module if the port is not already defin=
ed,
and ports.local is basically just portcon rules,
no special modifier to say that we are modifying an existing ports

> I hope that helps.
> Jim
