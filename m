Return-Path: <SRS0=SQk1=V4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD5FC32751
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 05:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67F3206A3
	for <selinux@archiver.kernel.org>; Wed, 31 Jul 2019 05:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYrcn0L5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfGaFPR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Jul 2019 01:15:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35415 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaFPR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Jul 2019 01:15:17 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so133558619ioo.2
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2019 22:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BH3VSGr+tvzcEqsxhZ69ucAEQHfqzVTWrJmyPWXlVF8=;
        b=cYrcn0L5MTgM0tEaaarcd9LbPPszRFdQHtweX6gq44tphKpW8QjpoZX7+h7qhfZM63
         z9cjYDp6DBM8YfLMoMktym4ABeUKacgOQQx0a+bhfvzpV3rjzOQTKV4awklM1eOiz6AP
         kxS5HdqwMoiAu5nViu7gqdyJLWze/884Zhptt7mIW4cuyeQQho7Y1VBooy496ppoZ8ty
         97VuMQJFUptqM4wIZmApdkSfiY8nHlBZersE8hrubf6x38oLJJjII2I2EIlwNAKI24tE
         uuUvbTnIXvEqthMDNLM2w+JLOPN3Gc9+mcGvdUsZf5l0lvIulOw20vJwVT065a86ygxp
         BEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BH3VSGr+tvzcEqsxhZ69ucAEQHfqzVTWrJmyPWXlVF8=;
        b=EvcMaKWRR08H0EjFmN5EAm6F4MMa+eue4ikXwNVeJFGavWhaOPzeLyBwcXCF0auTei
         1JWhzpOSPy8F6j9/BqOfvlc+15hK8pbQWlze2YBeRE5sCNQERNTRlqjN4osERA8oX2lm
         L+pIEdK8EDjVH01YRU3ywBvzxhVpz6UDjWwUE2q7MGMJSzdARUt/49xHXGcLxMuCeZ4q
         CvTKO2H8/Q6xlfOfWF59v1kr+udtL21LIm3/+7toP/B/Ry4Mbd2uFbG1qdAxd98ZMzxL
         bVnRwBLl27Hm5bNUK+LWCLzkU1H6EBEv6XnNJ+pLA8cnsQq1HmISJ886rylbVVatvwZl
         AKuw==
X-Gm-Message-State: APjAAAUSEYKDzU233oH30+QhIPn4iWZpC7hFLMkmJ/ik2iVWkvFj+Pta
        8LOibrtGzTNckDMXyABWEHYF5A9BWFWxeiGl3WIZOYgQ
X-Google-Smtp-Source: APXvYqzI4pp98lV3SSyGIcfWAiIYO6+jw0QTcD3c5knaKi7BoO0ODzGfQz6pHweRaswhMJnlWToQE4LSOzfUI/sawqk=
X-Received: by 2002:a5e:c24b:: with SMTP id w11mr101045169iop.111.1564550116203;
 Tue, 30 Jul 2019 22:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190702120905.9808-1-vmojzis@redhat.com> <20190702120905.9808-2-vmojzis@redhat.com>
 <CAJfZ7=nZ3mVRFD6d5OGq+r1srH+8bRr-hKeLi3kpc_bx3W5yTw@mail.gmail.com>
In-Reply-To: <CAJfZ7=nZ3mVRFD6d5OGq+r1srH+8bRr-hKeLi3kpc_bx3W5yTw@mail.gmail.com>
From:   Chad Hanson <dahchanson@gmail.com>
Date:   Wed, 31 Jul 2019 01:15:05 -0400
Message-ID: <CAOFCXecb5Z_d+iSqda-yHaQRgEsonHJEZx4MQut89t8E4CQ9BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fix mcstrans secolor examples
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I agree the secolor configuration file is lacking consistency. From a
historical MLS perspective, there were two special labels in many MLS
systems: SystemLow and SystemHigh.  This would be "s0" (lowest
level/no categories)  and "s15:c0.c1023" (highest level/all
categories) respectively.  At these special  levels, there was
traditionally no other category usage.

I concur we either do the proposed change in this patch or just change
the "s0:c0.c1023" lines to just "s0" (SystemLow) to be consistent with
the "s15:c0.c1023" (SystemHigh) range that exists currently. They will
both provide the desired results.

-Chad


On Mon, Jul 29, 2019 at 5:41 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Jul 2, 2019 at 2:09 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > According to "check_dominance" function:
> > Range defined as "s15:c0.c1023" does not dominate any other range than
> >  "s15:c0.c1023" (does not dominate "s15", "s15:c0.c200", etc.).
> > While range defined as "s15-s15:c0.c1023" dominates all of the above.
> >
> > This is either a bug, or "s15:c0.c1023" should not be used in the
> > examples.
>
> Hello,
> I am not familiar with the concepts about range dominance, so I do not
> know whether this is a bug that should be fixed or if updating the
> examples is better. Can someone please review this?
>
> Cheers,
> Nicolas
>
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> > ---
> >  libselinux/man/man5/secolor.conf.5                      | 4 ++--
> >  libselinux/man/ru/man5/secolor.conf.5                   | 4 ++--
> >  mcstrans/share/examples/urcsts-via-include/secolor.conf | 2 +-
> >  mcstrans/share/examples/urcsts/secolor.conf             | 2 +-
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/libselinux/man/man5/secolor.conf.5 b/libselinux/man/man5/secolor.conf.5
> > index b834577a..a3bf2da1 100644
> > --- a/libselinux/man/man5/secolor.conf.5
> > +++ b/libselinux/man/man5/secolor.conf.5
> > @@ -123,7 +123,7 @@ range s7\-s7:c0.c1023 = black red
> >  .br
> >  range s9\-s9:c0.c1023 = black orange
> >  .br
> > -range s15:c0.c1023   = black yellow
> > +range s15\-s15:c0.c1023   = black yellow
> >  .RE
> >
> >  .sp
> > @@ -165,7 +165,7 @@ type xguest_t     = black green
> >  .br
> >  user sysadm_u     = white black
> >  .br
> > -range s0:c0.c1023 = black white
> > +range s0-s0:c0.c1023 = black white
> >  .br
> >  user *            = black white
> >  .br
> > diff --git a/libselinux/man/ru/man5/secolor.conf.5 b/libselinux/man/ru/man5/secolor.conf.5
> > index 4c1236ae..bcae80c1 100644
> > --- a/libselinux/man/ru/man5/secolor.conf.5
> > +++ b/libselinux/man/ru/man5/secolor.conf.5
> > @@ -121,7 +121,7 @@ range s7\-s7:c0.c1023 = black red
> >  .br
> >  range s9\-s9:c0.c1023 = black orange
> >  .br
> > -range s15:c0.c1023   = black yellow
> > +range s15\-s15:c0.c1023   = black yellow
> >  .RE
> >
> >  .sp
> > @@ -163,7 +163,7 @@ type xguest_t     = black green
> >  .br
> >  user sysadm_u     = white black
> >  .br
> > -range s0:c0.c1023 = black white
> > +range s0\-s0:c0.c1023 = black white
> >  .br
> >  user *            = black white
> >  .br
> > diff --git a/mcstrans/share/examples/urcsts-via-include/secolor.conf b/mcstrans/share/examples/urcsts-via-include/secolor.conf
> > index d35b3c67..3b3f5430 100644
> > --- a/mcstrans/share/examples/urcsts-via-include/secolor.conf
> > +++ b/mcstrans/share/examples/urcsts-via-include/secolor.conf
> > @@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
> >  range s5-s5:c0.c1023 = white blue
> >  range s7-s7:c0.c1023 = black red
> >  range s9-s9:c0.c1023 = black orange
> > -range s15:c0.c1023 = black yellow
> > +range s15-s15:c0.c1023 = black yellow
> >
> > diff --git a/mcstrans/share/examples/urcsts/secolor.conf b/mcstrans/share/examples/urcsts/secolor.conf
> > index d35b3c67..3b3f5430 100644
> > --- a/mcstrans/share/examples/urcsts/secolor.conf
> > +++ b/mcstrans/share/examples/urcsts/secolor.conf
> > @@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
> >  range s5-s5:c0.c1023 = white blue
> >  range s7-s7:c0.c1023 = black red
> >  range s9-s9:c0.c1023 = black orange
> > -range s15:c0.c1023 = black yellow
> > +range s15-s15:c0.c1023 = black yellow
> >
> > --
> > 2.17.2
> >
>
