Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C1BC433E0
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 14:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FE5206DA
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 14:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="0xrAw1aN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgGaORc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgGaORc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 10:17:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AB1C061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 07:17:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s16so17366320ljc.8
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/roeMijPw6z7FU0hSg13mQvCGl8rqcyFZkVq0KZ/PM=;
        b=0xrAw1aNw5gyu6mAaUP7UBlDz9Zf04Dz5lMOw9sh22N0ljtT33MWft6TSzhiHHYeVQ
         nItfJRfBeuGkLbNzXxGl5yCUyCF5K4iKeGNNZTgnDH8cvw0xQu2cNsJkt6Ezfbc5dOBq
         dhZzDe6sQlZAoK+UcJ+CKq6NWegsX2NFhLfKwzKrV9FjWz6DXv1GEZrJVCifO7owpYPn
         v10vrGE2msyerZ2Sn5FSkXOe7t9oyq0o+NAlZOEF2IDShph9vnI9Ep5/OWrNOMZuCslU
         o6YTVWE2/taE51/dvG1a9QwTryT/waFI9fliarYxPVU7p4h3eAjSXNy0uFPTNCaUpaCh
         TDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/roeMijPw6z7FU0hSg13mQvCGl8rqcyFZkVq0KZ/PM=;
        b=D4eUmoVzd+YUJlo08AFdFIdpFK0q+iXSimMxYulrJV+1yY89A5LOVfE66ola20R9ze
         JHsL4iHawt6XZZxcekz5UUY2zPADqTIJP8xKNCmScMnYPz9B0fDCEnq9ju2PbdhKTjGO
         0XoGSBcUtrogpDly7IkWInyy6s3+BEq9+DPVeLfbecyJtp/BLNASkRqAIeDdn6rMHBSy
         Zwx0oMtnwsMNuGI4AWQMaSNg/+Y8KYCqzf5BZhzy4xnG/8fm1DMIvnjVF+7btD4Y0CHv
         s3bnE36uGhkcM1r4RJfz7an/ZmAB3URMdhcy4lyQPySMYfgEimOm3ZgCxC4rjdTulzQv
         4uyw==
X-Gm-Message-State: AOAM530th/9yxWVH1du01mqGZYJMNRG09Vt5YKJNCNaGBZhoGc7LZivw
        Ual87QyAkWBITdTSDIURYxCfFAY8qdBA98/hh63CaQ==
X-Google-Smtp-Source: ABdhPJwTclw2VJBRxaY5YOXUnrtTa6ybjxP/gq46yWlcznP75+ydHFMFvpzgh3Il8+j5OtD2TJcuTCofNHURAV1cgTQ=
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr2080002ljj.312.1596205049678;
 Fri, 31 Jul 2020 07:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200724141348.47590-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ7tPfA5+eUJOTw0BemAhizQy5LM6AKayE8VAVzO-ZEZ2w@mail.gmail.com>
 <CAEjxPJ4JF2xFMVgRk9wmwg_cAqKuRXc5FKkqHx525mk6JJy0hA@mail.gmail.com>
 <CAEjxPJ4JF_2jRP5WG6Uz51gEc7H+nRv2YAhcdTUzcwwYmQub_A@mail.gmail.com>
 <CAMN686FNvCu8tsPhnFa2y-M_1-n+TWdMt9w-Pyr6QqK+VeLi8A@mail.gmail.com>
 <CAEjxPJ5NxR=qM9VgAH+DASzquqAjEKb-YDqY7cNN9Ujm5Ut+tQ@mail.gmail.com>
 <CAMN686GPNoLppwOPSkwbCc2GX-AzKtJHayZpGOL1DWPBawwNKw@mail.gmail.com>
 <CAMN686Go8en8a-eOMbkCUwtAFRuKZb8H0Dk7ytbAeV6o8qSMhg@mail.gmail.com> <CAEjxPJ5MW-QM34AwCaB2Zo1H=mDX+y9H5G3=tOSgz4pO5+fCkg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5MW-QM34AwCaB2Zo1H=mDX+y9H5G3=tOSgz4pO5+fCkg@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Fri, 31 Jul 2020 10:17:18 -0400
Message-ID: <CAMN686E2M0jjh3s10qq=XzF63YpAgC2BQnqPwrLhLPh7XFvKAA@mail.gmail.com>
Subject: Re: [PATCH v4] libselinux: use kernel status page by default
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 4:25 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jul 24, 2020 at 3:43 PM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
> >
> > On Fri, Jul 24, 2020 at 3:34 PM Mike Palmiotto
> > <mike.palmiotto@crunchydata.com> wrote:
> > >
> > > On Fri, Jul 24, 2020 at 2:26 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > >
> > > > On Fri, Jul 24, 2020 at 12:23 PM Mike Palmiotto
> > > > <mike.palmiotto@crunchydata.com> wrote:
> > > > >
> > > > > On Fri, Jul 24, 2020 at 12:09 PM Stephen Smalley
> > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Jul 24, 2020 at 11:48 AM Stephen Smalley
> > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jul 24, 2020 at 11:34 AM Stephen Smalley
> > > > > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > > > >
<snip>
> > > > > > So, options would appear to be:
> > > > > > 1) Drop the usage of avc_using_threads altogether, i.e. even if the
> > > > > > caller provided a thread callback, don't create another thread and
> > > > > > just call selinux_status_updated() on every avc_has_perm_noaudit()
> > > > > > unless avc_app_main_loop is set.  Rationale: dbus-daemon was only
> > > > > > using threads to avoid the overhead of avc_netlink_check_nb() on every
> > > > > > avc_has_perm_noaudit() call, and we've eliminated that via use of
> > > > > > sestatus, hence we don't need to create a separate thread at all.
> > > > > > -or-
> > > > > > 2) If using threads, then create the netlink socket during avc_init
> > > > > > and keep using the netlink loop for the thread.  This preserves the
> > > > > > blocking behavior.
> > > > > >
> > > > > > #1 seems more optimal to me and gets rid of threading for dbus-daemon,
> > > > > > which was something they didn't like anyway.
> > > > >
> > > > > Perhaps this is misguided, but it seems like avc_init is deprecated
> > > > > and along with it the ability to even set a custom thread callback.
> > > > > IOTW there does not appear to be a mechanism to set a thread callback
> > > > > while using avc_open (only avc_init). Perhaps we can just get rid of
> > > > > the default callback for avc_open and allow the (deprecated) avc_init
> > > > > to continue using it as it does?
> > > > >
> > > > > Is this basically what you were proposing for #2? I think I'd be more
> > > > > inclined to go with that approach, in case userspace object managers
> > > > > are doing other things in their thread callback.
> > > >
> > > > I think that's the same as #2 if I understood you currently.  That's
> > > > fine if you prefer it.
> > > > So then programs using avc_init() with non-NULL thread callbacks
> > > > (hence avc_using_threads == 1) will still create the netlink socket
> > > > and start a thread running avc_netlink_loop().  And programs using
> > > > avc_netlink_acquire_fd() will create the netlink socket if not already
> > > > created and can use it however they want.  Everything else will move
> > > > to using the status page.
> > >
> > > What do you think about moving avc_create_thread call (if
> > > avc_using_threads is set) into avc_netlink_acquire_fd().
> > >
> > > That way, if the caller is using avc_init with a create_thread
> > > callback, they can get their netlink socket and create the netlink
> > > thread and everything will function as before. In theory, this would
> > > also work for the sestatus netlink fallback.
> >
> > Alternatively, we could just move the thread creation into the
> > sestatus fallback, since, as you pointed out, the only reason for
> > creating a thread would be to avoid the avc_netlink_check_nb()
> > overhead.
>
> avc_netlink_acquire_fd() isn't called by dbus-daemon in its current
> release used in Fedora/RHEL.
> So adding it there won't help.  We could add it to
> selinux_status_open().  Just need to make sure we don't call
> avc_netlink_open() twice there (it is already called in the fallback
> case) or make it safe to do so.

I've given this a bit more thought, and I'm actually leaning toward
your option #1, Stephen.

Doing away with netlink threads (for non-fallback) should be fine. The
only real change in functionality would be handling of status events
on the next access check, rather than immediately in the thread.

I have a patch repaired to use this approach (and properly handle avc
threads for the sestatus fallback case). I just need to
rebase/review/re-test before submitting.

Thanks for all of the feedback and sorry for the delay.



-- 
Mike Palmiotto
https://crunchydata.com
