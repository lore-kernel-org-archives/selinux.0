Return-Path: <SRS0=pOJ2=A7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A41C433E2
	for <selinux@archiver.kernel.org>; Mon, 20 Jul 2020 13:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93002070A
	for <selinux@archiver.kernel.org>; Mon, 20 Jul 2020 13:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHopuJmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGTN6C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgGTN6C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jul 2020 09:58:02 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892BC061794
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2020 06:58:02 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id w17so12241076otl.4
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2020 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJNEMjEMLJ6wNIqnqJfCIFoBviZ+kQ+8DeMtZmT2VHo=;
        b=WHopuJmFAY6B0obrBZ44jWDtV/952qnkC1hzkvcvjusMV5ccnlp8ITfXKJrRy+Iviz
         6hCdqayEIa0Qi6XQQ5G4CK8/a4DgE/JOjQ9lx93o4VrPobSIM049iblr+I1PgRxhGmT7
         b7SE2cqt7EcMyYKPSa8CadkX/4NId5X5ARG6jmjOb5HT2U1EbI0b4VZVHIMIwvU4NhrT
         dlFb/1GDoKhYMMT6NsP2T8u+U8K2ZntGmjMjRi9Ava6pqrvSshpwLOgrvOB2V4Pu7RVP
         RwUmUOY+fQnhOKOG3UmUp1Ym2oc8kHSql5XDqVZKWaUoogHzlmHULl3Y+oN8I3oDcONF
         8yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJNEMjEMLJ6wNIqnqJfCIFoBviZ+kQ+8DeMtZmT2VHo=;
        b=HEu81YGBGyNesMJc4G8cF/qrIiTaxejgd5nDnCXPI1mCN4HEji8s9l6GjgVLwUAdly
         TqNp+sUX2e+ppdH5w/dZ/9jJrSDduvhHXvmxwJ8xuoR1gA/9EBqFKYbHFivChCAUT0gc
         0tVYKVuEOPN6w3W+xBW6orpwinafc77ejs1NIexHcmqHiCvCmyOYtMy2BuxPYa6BDkCu
         iR9Lz1ZHkcC6ffWSvuqfc4x0c3F5mhmckZ5nmZJ61J/ZFrzJJ3A2v+KDwv3G1TkJ+a0+
         OHEBkNcJFkJ043cH8/zHrgwBqjBXdF7X8LxxXwIXFHzjke/NI9MR70GmODE9Cjjb7u7M
         OP2Q==
X-Gm-Message-State: AOAM533zCgfgkpbMPNHZdce+kf29OCJgnEIEZQS5/cAm6xEIu7eXZHMU
        dkS56pgbG7XT81ZXK4spDG/dKMaLVAx6LX/ue5I=
X-Google-Smtp-Source: ABdhPJxKSJ69qhT326JY6q5gcy+uAzvyQM4xsARaB74uuLYhcKY4+DXpslj6eeVsm4IZFYUiLpfY1j1wE3PQPWGQhcY=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr20410138oti.162.1595253481391;
 Mon, 20 Jul 2020 06:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200716210315.19907-1-mike.palmiotto@crunchydata.com> <CAEjxPJ4L_aKDfzWsb-Ve1ah1SES02jBtuKAYMy8YFwadj6RRkQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4L_aKDfzWsb-Ve1ah1SES02jBtuKAYMy8YFwadj6RRkQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 20 Jul 2020 09:57:50 -0400
Message-ID: <CAEjxPJ6y6+EfZ7=0ZKVf4+bjg2F93732CCdP0CSNZe3xJSeftA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Use sestatus if open
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 20, 2020 at 9:47 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 16, 2020 at 5:06 PM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
> >
> > Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> > /selinux/status") introduced the sestatus mechanism, which allows for
> > mmap()'ing of the kernel status page as a replacement for avc_netlink.
> >
> > The mechanism was initially intended for use by userspace object
> > managers which were calculating access decisions within their
> > application and did not rely on the libselinux AVC implementation. In
> > order to properly make use of sestatus within avc_has_perm(), the status
> > mechanism needs to properly set avc internals during status events;
> > else, avc_enforcing is never updated upon sestatus changes.
> >
> > This commit introduces a new selinux_status_loop() function, which
> > replaces the default netlink-equivalent, avc_netlink_loop(). The
> > function watches the kernel status page until an error occurs, at which
> > point it will close the status page and exit the thread.In the event
> > that the status page cannot be opened, the thread will continue to
> > function as before by using a fallback netlink socket.
> >
> > This allows us to replace the call to avc_netlink_open() in
> > avc_init_internal() with a call to selinux_status_open() and remove the
> > avc_netlink_check_nb() call from the critical code path in
> > avc_has_perm_noaudit(), as well as selinux_check_access().
> >
> > Userspace object managers wanting a netlink socket can call
> > avc_netlink_acquire_fd() to open a netlink socket if there is not one
> > open already.
> >
> > Update the manpage to reflect the new selinux_status_loop() and
> > avc_netlink_acquire_fd() functionality.
> >
> > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
>
> A few minor comments.  First, the subject line should be changed to
> reflect the fact that you are changing it to use the SELinux kernel
> status page whenever it is available, not just if it is already open.
> Second, I'm unclear on the need/benefit of exporting
> selinux_status_loop() as a public API/ABI of libselinux.  The
> difference from avc_netlink_loop() I think is that one requires access
> to functions/state private to libselinux while the other only uses
> other public APIs/ABIs.  Also selinux_status_loop() is a pretty
> trivial function.  So unless there is a compelling reason to export
> selinux_status_loop(), I wouldn't make it a public interface.  A
> couple of comments on the code below.
>
> > diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> > index b4648b2d..e36a9a53 100644
> > --- a/libselinux/src/avc.c
> > +++ b/libselinux/src/avc.c
> > @@ -557,9 +557,10 @@ void avc_destroy(void)
> >
> >         avc_get_lock(avc_lock);
> >
> > +       selinux_status_close();
> > +
> >         if (avc_using_threads)
> > -               avc_stop_thread(avc_netlink_thread);
> > -       avc_netlink_close();
> > +               avc_stop_thread(avc_status_thread);
>
> Shouldn't we perform the selinux_status_close() after stopping the thread?
>
> > diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
> > index 2a368e93..8d8d8fd2 100644
> > --- a/libselinux/src/libselinux.map
> > +++ b/libselinux/src/libselinux.map
> > @@ -203,6 +203,7 @@ LIBSELINUX_1.0 {
> >      selinux_status_close;
> >      selinux_status_deny_unknown;
> >      selinux_status_getenforce;
> > +    selinux_status_loop;
> >      selinux_status_open;
> >      selinux_status_policyload;
> >      selinux_status_updated;
>
> If we were going to add a new API/ABI, it would go in a new version
> for the map, tagged with whatever version it would first appear in
> e.g. LIBSELINUX_3.2.  But I don't think we need it exported at all.
>
> > diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> > index 86267ff8..6ecb6337 100644
> > --- a/libselinux/src/sestatus.c
> > +++ b/libselinux/src/sestatus.c
> > @@ -131,7 +141,6 @@ int selinux_status_updated(void)
> >  int selinux_status_getenforce(void)
> >  {
> >         uint32_t        seqno;
> > -       uint32_t        enforcing;
> >
> >         if (selinux_status == NULL) {
> >                 errno = EINVAL;
> > @@ -149,11 +158,11 @@ int selinux_status_getenforce(void)
> >         do {
> >                 seqno = read_sequence(selinux_status);
> >
> > -               enforcing = selinux_status->enforcing;
> > +               avc_enforcing = selinux_status->enforcing;
> >
> >         } while (seqno != read_sequence(selinux_status));
> >
> > -       return enforcing ? 1 : 0;
> > +       return avc_enforcing;
> >  }
>
> I'm not sure this should update avc_enforcing at all, but if it does,
> it should only do so once (e.g. after the loop, not within it), only
> if the value actually changed, and it should use
> avc_process_setenforce() to do it so that it honors avc_setenforce,
> resets the AVC, and calls any callbacks.  Otherwise that will never
> happen if a selinux_status_getenforce() call occurs prior to
> selinux_status_updated() after a setenforce operation.
>
> > @@ -316,6 +325,23 @@ error:
> >         return -1;
> >  }
> >
> > +/*
> > + * selinux_status_loop
> > + *
> > + * Run routine for checking kernel status page in a listening thread.
> > + * Falls back on netlink socket in the event of failure to open status page.
> > + */
> > +void selinux_status_loop(void)
> > +{
> > +       /* Check kernel status page until error occurs */
> > +       while(selinux_status_updated() >= 0);
> > +
> > +       avc_log(SELINUX_ERROR,
> > +               "%s: status thread terminating due to error: %d (%s)\n",
> > +               avc_prefix, errno, strerror(errno));
> > +       selinux_status_close();
>
> Should we really be closing it here or leaving that to the caller?  We
> are closing it anyway in the destroy function.

Also, please put a space between while and ( above and put the
semicolon on a line by itself.
I'd also prefer a space between the (void) typecast and various calls
even though it wasn't that way in the existing code.
