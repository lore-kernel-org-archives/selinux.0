Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BECAC169C4
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 20:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1740D2080A
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 20:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="i9GTsd06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfBHUEz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:04:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39477 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfBHUEz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Feb 2019 15:04:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id m11so3452244lfc.6
        for <selinux@vger.kernel.org>; Fri, 08 Feb 2019 12:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/yHHQsXkosSec39u4MqESBjuGJdPTGx9cMyLKRS5Y8s=;
        b=i9GTsd06vWtzokLTKHBYDKOgiZ5Ht+DJ/FhP3fLgpYaIvBNFN6c+lGLuaLQ+pq3QRa
         60iSQI6O2F3/0Ue8g8s8y+BflcEEqWsFtGqOaPmYmgi+aDwvuVWR4sTbtdcEAhxBP1xA
         z25APrABHgWZf4I5N7faAsnwZp+LND0tsyjRO0NqSmRAO7Y1FrEPcNugd0RRSlf905Q2
         NAQPqHiNnKMy28urNdZQO9qkKHFS9l/iYwy/Tn1J/qtOZ3kj8xXy/eDX4MSo7TWCRH30
         v4q/n3Cg6PXw/sGx4oQoko+oV8w/OViPcmakl97hyA8In6dfWGRYs6AQ6rS7cW0g0qd+
         E5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/yHHQsXkosSec39u4MqESBjuGJdPTGx9cMyLKRS5Y8s=;
        b=numA6CN85sYWU/pqJqKGdEtu1YLxWmSrkFgC+5RzE48Tt8rrHt+azD49ZICtTmL2oh
         anyRvoNCkBS6MkaNbVZlNpZrfS4/MCkvbKN5AQYCq7JU7gbXXNGYja5NSt5AahAeZKkk
         iBoN066kMDD4mWvUTt0+gfPnrz7moo1OgnIjaTLcTko/2hVtlM5Q3ngdS9bEOHLeyBqf
         QJGdUMLPWLxG60nL0x48c27/sifoO5PUdTKm63CYlkvunmd6b7+gcHgQu7e6hYiat3zt
         q1F5/jdYjbVCztAze+Y3xkZcHYiVdcN/zqZkWECgPzgyxj1nX2XGyVOUq2c8hlQTMFpR
         zYyg==
X-Gm-Message-State: AHQUAuYmYJXcD40oaLsb/VbIBxJSDhf+QG0lVq2DQAR8UDWWQ33vWTt+
        zbN7IjZK7Kh7G4ELQR8tJ2VeTaanfFwayqaeJ7dg
X-Google-Smtp-Source: AHgI3Iae0MWD8I0A0KM8PSha/z72W1pXzw6DxjzW9UXVJiaWZRjXY2qnZ8/95FjOrtU6Mj16Ics9buvLg53+r8KpJQE=
X-Received: by 2002:a19:9c54:: with SMTP id f81mr14997930lfe.135.1549656293026;
 Fri, 08 Feb 2019 12:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20190127081023.21124-1-leon@kernel.org> <CAHC9VhQccU9sD7Zb+6d9sPK=fq593R1-UOhVfwgiK-6usrkbQw@mail.gmail.com>
 <b558e86b-dc56-d17a-30c0-0b640f0bf6cc@mellanox.com> <CAHC9VhQTq_UTFkBOSb0fWbde6tsb_uiNi8EHdCovKzB8KkD6XA@mail.gmail.com>
 <40feb71f-d24c-f592-58d0-fc5814307c6c@redhat.com> <CAHC9VhSzNjVFq-aiUrS2og0sMUwNB+aBwtk7ZWj9dss12xfVOQ@mail.gmail.com>
 <1859ec04-d3d2-bffe-16ca-2ae602e5bbff@mellanox.com> <325d56d9-24d9-a850-57a7-47f12baa593c@mellanox.com>
 <CAHC9VhRWHzrR84ueJHzmBgyQviL-36-ezvDb0u-xRfQmBsBO2g@mail.gmail.com>
 <3cf233f6-4ca7-1667-7d09-0d2b6879046d@mellanox.com> <CAHC9VhQWG7z0dV4=bULLGdU3SXjQH-da9vkyZo6a+Wy5Bw29_A@mail.gmail.com>
 <CAHC9VhQc-_iYUid1PYnRA8_cJG+Ji5zkoz80Pg++C-wY_GKrvw@mail.gmail.com>
 <3c92c876-8ef7-aff9-59ab-966ee95978e6@mellanox.com> <CAHC9VhQoEZY3s=SjQQe+OR8A9bPN_v8u5fHxmtd=iN==iYkH3Q@mail.gmail.com>
 <12c95863-83bc-2ce8-a2c4-72199af7ed0a@redhat.com>
In-Reply-To: <12c95863-83bc-2ce8-a2c4-72199af7ed0a@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 8 Feb 2019 15:04:40 -0500
Message-ID: <CAHC9VhSgC+x_dsV0_-YRdACm7otRVBsqwn2g6+aYOOo7OaMoEA@mail.gmail.com>
Subject: Re: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM notifications
To:     Don Dutile <ddutile@redhat.com>
Cc:     Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 8, 2019 at 2:58 PM Don Dutile <ddutile@redhat.com> wrote:
> On 02/01/2019 11:09 AM, Paul Moore wrote:
> > On Fri, Feb 1, 2019 at 9:16 AM Daniel Jurgens <danielj@mellanox.com> wr=
ote:
> >> On 2/1/2019 7:57 AM, Paul Moore wrote:
> >>> On Tue, Jan 29, 2019 at 4:13 PM Paul Moore <paul@paul-moore.com> wrot=
e:
> >>>> On Tue, Jan 29, 2019 at 3:58 PM Daniel Jurgens <danielj@mellanox.com=
> wrote:
> >>>>> On 1/29/2019 2:51 PM, Paul Moore wrote:
> >>>>>> Okay, so let's attempt the change above where we just do the acces=
s
> >>>>>> check directly.  Although I'm a little concerned that without a
> >>>>>> reproducer we might not end up fixing the problem we're trying to =
fix.
> >>>>>> Is anyone in touch with the person who originally reported the
> >>>>>> problem?  It would be great if we could get that person to verify =
the
> >>>>>> change ...
> >>>>> I decided to go with maintaining a list in IB core. The notifier ca=
ll is done under rcu_read_lock vs spin_lock_irq for register/unregister, so=
 we shouldn't have any problems in that case. So only registering once basi=
cally achieves the same thing as taking it all out. I'm testing it now. I'l=
l send it for internal review today assuming it checks out. Hopefully Leon =
can get it posted tomorrow, I know Don has some schedule pressure here.
> >>>> Okay sounds good.  We're still at -rc4 so as long as we can get
> >>>> something posted this week, or early next, I see no reason why it
> >>>> can't make the upcoming merge window.
> >>>>
> >>>> I'm guessing Don's schedule pressure is more a RH deadline, and not =
an
> >>>> upstream constraint.
> >>> I just wanted to check in and see how this was progressing?  I didn't
> >>> see anything in my inbox, but perhaps I missed it ...
> >> It's passed internal review. Leon should send it soon (Sunday at the s=
oonest, IL has Friday-Saturday weekends), he may be waiting for a regressio=
n run to finish.
> >
> > Great, thanks for the update.
>
> update? we're approaching the 2nd Sunday after 2/1/2019, when this email =
was sent ...

Leon sent out an updated patchset on February 2nd, and I sent a
reply/ack for the SELinux relevant patch a few days later on the 6th.
Archive link below, but it looks like you were CC'd ... ?

* https://lore.kernel.org/selinux/20190202090945.4106-1-leon@kernel.org

--=20
paul moore
www.paul-moore.com
