Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BE9C11D2F
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 15:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ED82084E
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 15:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0/mFfmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgBXPs5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:48:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47424 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727299AbgBXPs5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 10:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582559334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5qu6I84601MU1nFYz4DV5DIEEY5JfZs25lnQtF/9vf4=;
        b=O0/mFfmR2y/m1+xo2xsOJFAcMwpRuYmDFCdn4vzkW/j6IBMLwHPAuTIRLHvAoO8jZUiDue
        kJnxn9vgkzv6oN26Jin3Z4XHQXXAM7HtvY8rJtIXblUJXUm4rzeb4x7jXKLEmdIeI/llnh
        2bImNE7eXea9AA8LtLmr84TPHgkvoDc=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-DVwz_wAAO-2zNl1bvncByA-1; Mon, 24 Feb 2020 10:48:49 -0500
X-MC-Unique: DVwz_wAAO-2zNl1bvncByA-1
Received: by mail-oi1-f198.google.com with SMTP id 3so4378281oij.21
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 07:48:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qu6I84601MU1nFYz4DV5DIEEY5JfZs25lnQtF/9vf4=;
        b=QZUGLrRR4Fix/ke03wZ4eHYywQO/a3eTf6oTPHvuMAe0/VV7unHetPWs1koxqr5u37
         UNzmSEVxSK0FwJBPQ364xKIUEAhUxbsNLN6rbJ+r1YmJjIdpIhflmeNzvs0iLllCAG4e
         8Wt7DEL+xhZIkq+XK8wCA27R2U7E5JgWOSj7+qcgySGiLTvrBOfDIw09wmE57fJtDBHx
         KWR8UxVV8LOqsZRRUkJMOaddct7goDOX23JANXbIhnNPG/pFGwmMl3HrrMp0Q2J/6qt1
         NsyTj/nC72QTR/as4w4hZ+CaamD1d/sfOXG9peMPwubKyequWo3c2bkBRSmbpLMtLs+o
         C09w==
X-Gm-Message-State: APjAAAWix9x5KdQ2ot5RYVemTnw8oakY4qJqu+cLRJTYE5eItCqQMJyK
        HB/xsO3QzcYXAO+6ipBnKE7S4I9irmHpebVTB82NHYYCFzj7Hy6HBaWPwMAOJjVuk7P246oax+/
        IT2J3ELT1pa7m3eVtHP+5gdXUfJATyGh2aA==
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr336207oth.43.1582559327924;
        Mon, 24 Feb 2020 07:48:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGSKR/EVcOyWgkwG4wJcvJtSdNm4ek7UFLK1G+8KUjsoCK/aSfUD01xXcc6vRt8JPCQNbjNWse2GqKwigRlHE=
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr336187oth.43.1582559327528;
 Mon, 24 Feb 2020 07:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20200224124710.156385-1-omosnace@redhat.com> <e67597de2429f1df449a495b4d48842528f280e3.camel@btinternet.com>
In-Reply-To: <e67597de2429f1df449a495b4d48842528f280e3.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 24 Feb 2020 16:48:36 +0100
Message-ID: <CAFqZXNvxg3n2kL2iMYw4r0QRNqK5xavdU=QcNRb95UdgA=i-UQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/sctp: fix setting of the SCTP_EVENTS sockopt
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 24, 2020 at 4:24 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Mon, 2020-02-24 at 13:47 +0100, Ondrej Mosnacek wrote:
> > First, the setting of SCTP_EVENTS socket option in sctp_server.c is
> > completely wrong -- it assumes little-endian byte order and uses a
> > plain
> > int instead of the dedicated sctp_event_subscribe struct.
> >
> > Second, the usage in sctp_peeloff_server.c is correct, but it may
> > lead
> > to errors when the SCTP header definitions are newer than what the
> > kernel supports. In such case the size of struct sctp_event_subscribe
> > may be higher than the kernel's version and the setsockopt(2) may
> > fail
> > with -EINVAL due to the 'optlen > sizeof(struct
> > sctp_event_subscribe)'
> > check in net/sctp/socket.c:sctp_setsockopt_events().
> >
> > To fix this, introduce a common function that does what the
> > sctp_peeloff_server's set_subscr_events() did, but also truncates the
> > optlen to only those fields that we use.
>
> Thanks for fixing these problems. How did the problems come to light,
> just via the header file changes or some tests failing on a certain
> kernel ?

Apparently, struct sctp_event_subscribe has been extended by a new
field between kernel 5.4 and 5.5 [1] and this caused the error to
appear in CKI testing [2] when Fedora 31 moved to kernel 5.5 (it
installed the tested 5.4 stable rc kernel and booted into it, while
the kernel-headers package stayed at the distro's 5.5 version). The
endianness issue never seemed to have triggered actual failures when
we ran the tests internally on big-endian s390x systems. (I'm
wondering if the SCTP_EVENTS setsockopt() is even needed there...?)

[1] https://github.com/torvalds/linux/blame/master/include/uapi/linux/sctp.h#L623
[2] https://lore.kernel.org/stable/CAFqZXNvnywGVwqJhXcfwpmx2mmu8ajAUOdy0Ny8PvsT=Rg_3Qg@mail.gmail.com/T/

>
> >
> > Fixes: c38b57ffdac4 ("selinux-testsuite: Add SCTP test support")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  tests/sctp/sctp_common.c         | 20 ++++++++++++++++++++
> >  tests/sctp/sctp_common.h         |  1 +
> >  tests/sctp/sctp_peeloff_server.c | 28 ++++++++--------------------
> >  tests/sctp/sctp_server.c         |  2 +-
> >  4 files changed, 30 insertions(+), 21 deletions(-)
> >
> > diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
> > index 100ab22..089af2a 100644
> > --- a/tests/sctp/sctp_common.c
> > +++ b/tests/sctp/sctp_common.c
> > @@ -1,5 +1,8 @@
> >  #include "sctp_common.h"
> >
> > +#define member_size(type, member) sizeof(((type *)0)->member)
> > +#define sizeof_up_to(type, member) (offsetof(type, member) +
> > member_size(type, member))
> > +
> >  void print_context(int fd, char *text)
> >  {
> >       char *context;
> > @@ -99,3 +102,20 @@ void print_ip_option(int fd, bool ipv4, char
> > *text)
> >               printf("%s No IP Options set\n", text);
> >       }
> >  }
> > +
> > +int set_subscr_events(int fd, int data_io, int association)
> > +{
> > +     struct sctp_event_subscribe subscr_events;
> > +
> > +     memset(&subscr_events, 0, sizeof(subscr_events));
> > +     subscr_events.sctp_data_io_event = data_io;
> > +     subscr_events.sctp_association_event = association;
> > +
> > +     /*
> > +      * Truncate optlen to just the fields we touch to avoid errors
> > when
> > +      * the uapi headers are newer than the running kernel.
> > +      */
> > +     return setsockopt(fd, IPPROTO_SCTP, SCTP_EVENTS,
> > &subscr_events,
> > +                       sizeof_up_to(struct sctp_event_subscribe,
> > +                                    sctp_association_event));
> > +}
> > diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
> > index d5c1397..351ee37 100644
> > --- a/tests/sctp/sctp_common.h
> > +++ b/tests/sctp/sctp_common.h
> > @@ -25,3 +25,4 @@ void print_context(int fd, char *text);
> >  void print_addr_info(struct sockaddr *sin, char *text);
> >  char *get_ip_option(int fd, bool ipv4, socklen_t *opt_len);
> >  void print_ip_option(int fd, bool ipv4, char *text);
> > +int set_subscr_events(int fd, int data_io, int association);
> > diff --git a/tests/sctp/sctp_peeloff_server.c
> > b/tests/sctp/sctp_peeloff_server.c
> > index 4a5110a..093c6c0 100644
> > --- a/tests/sctp/sctp_peeloff_server.c
> > +++ b/tests/sctp/sctp_peeloff_server.c
> > @@ -16,24 +16,6 @@ static void usage(char *progname)
> >       exit(1);
> >  }
> >
> > -static void set_subscr_events(int fd, int value)
> > -{
> > -     int result;
> > -     struct sctp_event_subscribe subscr_events;
> > -
> > -     memset(&subscr_events, 0, sizeof(subscr_events));
> > -     subscr_events.sctp_association_event = value;
> > -     /* subscr_events.sctp_data_io_event = value; */
> > -
> > -     result = setsockopt(fd, IPPROTO_SCTP, SCTP_EVENTS,
> > -                         &subscr_events, sizeof(subscr_events));
> > -     if (result < 0) {
> > -             perror("Server setsockopt: SCTP_EVENTS");
> > -             close(fd);
> > -             exit(1);
> > -     }
> > -}
> > -
> >  static sctp_assoc_t handle_event(void *buf)
> >  {
> >       union sctp_notification *snp = buf;
> > @@ -166,7 +148,13 @@ int main(int argc, char **argv)
> >       }
> >
> >       do {
> > -             set_subscr_events(sock, 1); /* Get assoc_id for
> > sctp_peeloff() */
> > +             /* Get assoc_id for sctp_peeloff() */
> > +             result = set_subscr_events(sock, 0, 1);
> > +             if (result < 0) {
> > +                     perror("Server setsockopt: SCTP_EVENTS");
> > +                     close(sock);
> > +                     exit(1);
> > +             }
> >               sinlen = sizeof(sin);
> >               flags = 0;
> >
> > @@ -192,7 +180,7 @@ int main(int argc, char **argv)
> >                               exit(1);
> >                       }
> >                       /* No more notifications */
> > -                     set_subscr_events(sock, 0);
> > +                     set_subscr_events(sock, 0, 0);
> >
> >                       peeloff_sk = sctp_peeloff(sock, assoc_id);
> >                       if (peeloff_sk < 0) {
> > diff --git a/tests/sctp/sctp_server.c b/tests/sctp/sctp_server.c
> > index 4659ed1..7f2cd20 100644
> > --- a/tests/sctp/sctp_server.c
> > +++ b/tests/sctp/sctp_server.c
> > @@ -134,7 +134,7 @@ int main(int argc, char **argv)
> >       }
> >
> >       /* Enables sctp_data_io_events for sctp_recvmsg(3) for
> > assoc_id. */
> > -     result = setsockopt(sock, SOL_SCTP, SCTP_EVENTS, &on,
> > sizeof(on));
> > +     result = set_subscr_events(sock, on, 0);
> >       if (result < 0) {
> >               perror("Server setsockopt: SCTP_EVENTS");
> >               close(sock);
>


-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

