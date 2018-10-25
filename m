Return-Path: <SRS0=7H0L=NF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D2DC46475
	for <selinux@archiver.kernel.org>; Thu, 25 Oct 2018 21:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177862054F
	for <selinux@archiver.kernel.org>; Thu, 25 Oct 2018 21:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nffMmVoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177862054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeJZFlh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:41:37 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42210 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbeJZFlh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Oct 2018 01:41:37 -0400
Received: by mail-oi1-f195.google.com with SMTP id h4-v6so5856488oih.9
        for <selinux@vger.kernel.org>; Thu, 25 Oct 2018 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxtPsT8DCyR5worKd8tBNDaRBeqqwhuyywFDOSMVHpY=;
        b=nffMmVoDy7rd9dqOFhXaDXcbrhRuFhoWSddn9nwyvzJR6w84M9qCxUnyRtaQJUMj6o
         4zvwWCzqHZmd/GohVvhaqXvgGmmmv0+4sKFuKzrgWTShqfNkjiSp0TAG3iLyEQAryV/n
         oIp3EiGHJeaRB2eKjCIRDKm4f+K2D08enctanWm92as0ro5uyKBhYcrd2jKj6Fn9VlOv
         ZRS3ksHOzdQC0HpGDWjT+/+bY5L28agtE63c09DKKi5+o62hvP1bCzVNHfVSsi96rRWr
         KGapoljsNVIBMRSQwRT3sSqBsh0oIXc+0d4GRApwq8GX4lrUILD9DyEGJXoXMmmm8fWe
         CNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxtPsT8DCyR5worKd8tBNDaRBeqqwhuyywFDOSMVHpY=;
        b=NAVga4E0En/9JjxleRnTCx1Xvx2EIyJqBDbjGvtqtOxvrGxtxyG1AEokFr0beGr4D6
         A6KHXbd+hPfn9D3t0xOEv6lYwc3iaya8T+tsdOCUijyj2TFjkddp5MjlUfMxi35a4Smx
         UXhq6XXq5FfyEH1VAHtyLFU8tl7N8U+nz52ornnkjubA+W0UXhut1DGLUP6Gj+taBADp
         luNs4J+efgLYayI0RYHkEUaJOBiB0PkqUjZRQh74WLS7seh4a8sr4076wwbnC91Q/VLd
         7IYO4nWd13AByJffRomzSXxOn+V1XJwsLqpnxE+SjUFHbXy67kalXX09tmfuYkGcoaCl
         lPNg==
X-Gm-Message-State: AGRZ1gL6oWj56Mv23zZetcX6POtBXflWFhVyK82F9Kbp+BbHZkE1u2tx
        lGnnZM66iIww1dMfOxsIi4DCKmIdxUFVxFW6Uog=
X-Google-Smtp-Source: AJdET5fCw6QlltxP20UC87Pyf+ocp/fy1n1svS7KBvC6WuoNABldMKo4AarM73OJ4hZsMrh3dcBHPQ1ATkV61M2akvM=
X-Received: by 2002:aca:4cd1:: with SMTP id z200-v6mr501333oia.318.1540501638271;
 Thu, 25 Oct 2018 14:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181023065757.16784-1-omosnace@redhat.com> <CAFftDdr9s72BPz+j1GhFXS_DWpo0ucehv=jHJkOcZc=yzwAhAg@mail.gmail.com>
In-Reply-To: <CAFftDdr9s72BPz+j1GhFXS_DWpo0ucehv=jHJkOcZc=yzwAhAg@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 25 Oct 2018 14:07:05 -0700
Message-ID: <CAFftDdqRwEabEoWfAamwx5eV_9WAVoDAjud0qkjwvS=BxT18FQ@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: add missing ibendport port validity check
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, danielj@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 23, 2018 at 10:29 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Mon, Oct 22, 2018 at 11:58 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The kernel checks if the port is in the range 1-255 when loading an
> > ibenportcon rule. Add the same check to libsepol.
> >
> > Fixes: 118c0cd1038e ("libsepol: Add ibendport ocontext handling")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  libsepol/src/policydb.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > Changes in v2:
> >  - use UINT8_MAX as the limit for ibendport.port value to emphasize that
> >    it is an 8-bit value
> >
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index db6765ba..96176d80 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > @@ -2854,7 +2854,9 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
> >                                         return -1;
> >                                 break;
> >                         }
> > -                       case OCON_IBENDPORT:
> > +                       case OCON_IBENDPORT: {
> > +                               uint32_t port;
> > +
> >                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
> >                                 if (rc < 0)
> >                                         return -1;
> > @@ -2862,6 +2864,10 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
> >                                 if (len == 0 || len > IB_DEVICE_NAME_MAX - 1)
> >                                         return -1;
> >
> > +                               port = le32_to_cpu(buf[1]);
> > +                               if (port > UINT8_MAX || port == 0)
> > +                                       return -1;
> > +
> >                                 c->u.ibendport.dev_name = malloc(len + 1);
> >                                 if (!c->u.ibendport.dev_name)
> >                                         return -1;
> > @@ -2869,11 +2875,12 @@ static int ocontext_read_selinux(struct policydb_compat_info *info,
> >                                 if (rc < 0)
> >                                         return -1;
> >                                 c->u.ibendport.dev_name[len] = 0;
> > -                               c->u.ibendport.port = le32_to_cpu(buf[1]);
> > +                               c->u.ibendport.port = port;
> >                                 if (context_read_and_validate
> >                                     (&c->context[0], p, fp))
> >                                         return -1;
> >                                 break;
> > +                       }
> >                         case OCON_PORT:
> >                                 rc = next_entry(buf, fp, sizeof(uint32_t) * 3);
> >                                 if (rc < 0)
> > --
> > 2.17.2
> >
>
> ack. I dropped it on top of https://github.com/SELinuxProject/selinux/pull/105
merged: https://github.com/SELinuxProject/selinux/pull/105
