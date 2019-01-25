Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B21C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 17:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F18A218A6
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 17:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Ko/de9Vk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfAYRbh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:31:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46057 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRbg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 12:31:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so7476827lfa.12
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JWrSqEQNe8Ic+N76MQI6giQIry2RoAz0U8QDQ12Qyrs=;
        b=Ko/de9Vk0UaOe4SFdiQQ15uiNyS2Ivleh/5AC9E1Hd+cFBSiuOvdtWigSXk7wl8Jjl
         /cWyu+tVzkkTBHs77N2vIcrEUAa8X+tpOmb3x1zUdnXF0tU2lSUWgUwqlADlxFdyMAUy
         msh4Esxr2mf0ioTfYTk5HceAPYBJNgvqakHa9vfEj90sE6uDvEfEH0O43nojVcCXqumh
         o2R3bphayLMECrX1hr/uKS1Q0um2mH5I6VING/GnwVPcvMSO/lXorxDhGLYLXjqWuPwH
         ln0agLiqJWOpHqHCC+vqDbUYxEZ4CQJOpu0FfrkWoI+LkYIl7DeV06YcNTJVC8wysoZW
         /jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JWrSqEQNe8Ic+N76MQI6giQIry2RoAz0U8QDQ12Qyrs=;
        b=uKq3zi5K2E/qYxTEbTb3DsAi1uxp3fwJiSKySfOM8c35OMZYHxlePXh5JcRpNMOymq
         7cAPRd9ua0ySsPzxgiYB7NaqSffD1TD5UNaQB20pOyK+lpTf5PcTv1kAD/HaLXMjID8z
         z6bSidpjhgHVxFUttiBBBCb9A4U4r1T/ElpxOy4l/NvrVvPg92ib1kTvvCiTNlxtkgn7
         Mg3XLiNXMHcNmsful3cG+D5Zq4AQrITHtVM4jFHnY/pQeLGnFFk0f7HHkp2i0h238co2
         //vu/OTm0XHWhJG4wyAdxssRSpLlreKojk08TdQzeMYaOXKrzfhO2vdnFcV2RxQ2xwEA
         FfvA==
X-Gm-Message-State: AJcUukelM4XRcNbUrmRLEqMVFIc103Eqd7POLneH/uN04EeBAy2HTol7
        /GlD+huKhu2jLc5Xn5HCtIGvVld5seaSQiCQYP4T
X-Google-Smtp-Source: ALg8bN4BQkyw44eXxjch7Gs8In4y/ehCycBFP695ZiP0icKcrICVX9aQuo8UdGeISDmv8NhcFWstNsYhFRM65eWzc1M=
X-Received: by 2002:a19:db54:: with SMTP id s81mr9755618lfg.102.1548437493124;
 Fri, 25 Jan 2019 09:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20190121153605.26847-1-omosnace@redhat.com> <CAHC9VhRDSMeojFEFz+8rshiP4TmtoGuEuOK0AwZecyJ0SWN3Ug@mail.gmail.com>
 <CAFqZXNtkUC88X9sfr4Kaq=QDN-H9G=xHKEntyE2mfvC5S0aVXQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtkUC88X9sfr4Kaq=QDN-H9G=xHKEntyE2mfvC5S0aVXQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 12:31:21 -0500
Message-ID: <CAHC9VhT-4mujhEJz3XcmOJBGc7dhOcoxkkoJ_ZU=+TgKSxv2Aw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: log invalid contexts in AVCs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 25, 2019 at 4:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote=
:
> On Tue, Jan 22, 2019 at 8:42 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Jan 21, 2019 at 10:36 AM Ondrej Mosnacek <omosnace@redhat.com> =
wrote:
> > > In case a file has an invalid context set, in an AVC record generated
> > > upon access to such file, the target context is always reported as
> > > unlabeled. This patch adds new optional fields to the AVC record
> > > (srawcon and trawcon) that report the actual context string if it
> > > differs from the one reported in scontext/tcontext. This is useful fo=
r
> > > diagnosing SELinux denials involving invalid contexts.
> > >
> > > To trigger an AVC that illustrates this situation:
> > >
> > >     # setenforce 0
> > >     # touch /tmp/testfile
> > >     # setfattr -n security.selinux -v system_u:object_r:banana_t:s0 /=
tmp/testfile
> > >     # runcon system_u:system_r:sshd_t:s0 cat /tmp/testfile
> > >
> > > AVC before:
> > >
> > > type=3DAVC msg=3Daudit(1547801083.248:11): avc:  denied  { open } for=
  pid=3D1149 comm=3D"cat" path=3D"/tmp/testfile" dev=3D"tmpfs" ino=3D6608 s=
context=3Dsystem_u:system_r:sshd_t:s0 tcontext=3Dsystem_u:object_r:unlabele=
d_t:s15:c0.c1023 tclass=3Dfile permissive=3D1
> > >
> > > AVC after:
> > >
> > > type=3DAVC msg=3Daudit(1547801083.248:11): avc:  denied  { open } for=
  pid=3D1149 comm=3D"cat" path=3D"/tmp/testfile" dev=3D"tmpfs" ino=3D6608 s=
context=3Dsystem_u:system_r:sshd_t:s0 tcontext=3Dsystem_u:object_r:unlabele=
d_t:s15:c0.c1023 trawcon=3Dsystem_u:object_r:banana_t:s0 tclass=3Dfile perm=
issive=3D1
> >
> > I would like us to add new fields at the end of existing records; the
> > recent audit config changes are a bit of a special case as discussed
> > previously.
>
> Okay, I happened to find a way to do this a little differently (taking
> a suggestion from Stephen about avoiding the need to do strcmp()) so
> now it is actually easy to move them at the end. But I didn't expect
> to get a more liberal reply from Steve (who is usually more strict
> about this) than you :)

Yeah, the audit record format is a delicate subject with lots of
disagreement between Steve and I.  I think you've seen some of that
since you've been involved in audit, but it goes back years.

The general rule that I've been sticking to is that new fields get
added to the end of the record.  There are exceptions, e.g. the config
records, but those exceptions are typically only given in the case of
a record format that is so irregular it really doesn't matter.

--=20
paul moore
www.paul-moore.com
