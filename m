Return-Path: <SRS0=obw9=P5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B1DC282DB
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 08:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF35920823
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 08:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfAUIgz convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:36:55 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34564 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfAUIgz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jan 2019 03:36:55 -0500
Received: by mail-oi1-f193.google.com with SMTP id r62so13937966oie.1
        for <selinux@vger.kernel.org>; Mon, 21 Jan 2019 00:36:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hw+oq+bUIvNBMNHnH2T0h8ERSR7Fbhe37/3h9MYbuMM=;
        b=k5zNaWKK9zNr0u+j6SqTfUdeRoMv2VM12xUEa97L/oyuWhZfi/JfulGNAYyL5kEKVb
         +uJxa7mkI17XMswWqWwIl2HS67bZd26Nfe44xH+zN/F4ymg4ixVL2MgVfOYyOXHgDoLz
         pqFMHKpW1UYzvRtpaZnUy+knqqS3qd6ddbtY5yN3awqkVCoF2R47Ik4U31FRU0ueOqs/
         pnjQVbS5OOXsCqpfprE3ivwX1v14siEX6RZSMBLMgq5OjmOwVUXE280hyueYLnCcQlpd
         hlER3gUs+VURcPML/CVjb4ZWh4JsAPiEglU5c1QitWKtMLQZgA7jbJqx0bxjOt/ni3J/
         3qrw==
X-Gm-Message-State: AJcUukc51F+BZ/ki68xMD5DqdjFKMgj5MKmuXMfutN8T2YAoZi40vgjN
        9mq6hIusv5POldlfOFNEXV4aZovFpybSGo2AAP96FR8NW0Tpzw==
X-Google-Smtp-Source: ALg8bN7VgYmC/kXCxeNdbTYNXhDArkIr0D856w9NnVgQwYhGt17gj4HbiRlZzBJ5rf7UTVJ7MRctzGZRuhiD17v+hYQ=
X-Received: by 2002:aca:2403:: with SMTP id n3mr5151231oic.328.1548059813970;
 Mon, 21 Jan 2019 00:36:53 -0800 (PST)
MIME-Version: 1.0
References: <20190118100429.11703-1-omosnace@redhat.com> <20190119132301.bwlokbs6vth7erkw@madcap2.tricolour.ca>
In-Reply-To: <20190119132301.bwlokbs6vth7erkw@madcap2.tricolour.ca>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 21 Jan 2019 09:36:43 +0100
Message-ID: <CAFqZXNuj1GrU5wXOQv1R4SRSW9FZx3gV=4Z75eeh0ajNCvN4Rw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: log invalid contexts in AVCs
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jan 19, 2019 at 2:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-01-18 11:04, Ondrej Mosnacek wrote:
> > In case a file has an invalid context set, in an AVC record generated
> > upon access to such file, the target context is always reported as
> > unlabeled. This patch adds new optional fields to the AVC record (slcon
> > and tlcon) that report the actual context string if it differs from the
> > one reported in scontext/tcontext. This is useful for diagnosing SELinux
> > denials.
> >
> > To trigger an AVC that illustrates this situation:
> >
> >     # setenforce 0
> >     # touch /tmp/testfile
> >     # setfattr -n security.selinux -v system_u:object_r:banana_t:s0 /tmp/testfile
> >     # runcon system_u:system_r:sshd_t:s0 cat /tmp/testfile
> >
> > AVC before:
> >
> > type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file permissive=1
> >
> > AVC after:
> >
> > type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tlcon=system_u:object_r:banana_t:s0 tclass=file permissive=1
> >
> > Cc: Daniel Walsh <dwalsh@redhat.com>
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1135683
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/avc.c | 49 +++++++++++++++++++++++++-----------------
> >  1 file changed, 29 insertions(+), 20 deletions(-)
> >
> > I'm not entirely sure about the record format here, so I'm Cc'ing
> > linux-audit and Steve for feedback. I went for optional fields to
> > minimize the size of the record, but maybe a different format is
> > preferred. If so, let me know and I'll do a respin.
>
> My understanding is that optional fields can be a problem (but not if
> it is a non-searchable field?).

Yes, I hope Steve will eventually chime in and clarify what are the
exact boundaries I can operate within for this particular record and
fields. I could for example move the new fields at the end of the
record or make them always there, but set to "?" or "" if the value
would be the same as in the other fields, but I'm not sure if that is
necessary or sufficient for audit-userspace tools.

> There is an existing "invalid_context"
> field whose position may help indicate which one it refers to, but this
> sounds pretty weak.
>
> Alternatively the best I could suggest would be a new auxiliary record.

Hm, "invalid_context" seems to be part of the SELINUX_ERR record,
which is already use for a similar purpose (to report that an invalid
context has been encountered) in compute_sid_handle_invalid_context().
Perhaps I could reuse it here, but "error" sounds a bit strong...
Maybe we need a SELINUX_WARN or SELINUX_INFO...

>
> > Also, I accept suggestions for better field names than "slcon"/"tlcon"
> > ("lcon" is meant as an acronym for "literal context", but I'm not sure
> > if that's a good name...).
> >
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 9b63d8ee1687..4a181ed56e37 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -165,6 +165,32 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
> >       audit_log_format(ab, " }");
> >  }
> >
> > +static void avc_dump_sid(struct audit_buffer *ab, struct selinux_state *state,
> > +                      u32 sid, char type)
> > +{
> > +     int rc;
> > +     char *context, *lcontext;
> > +     u32 context_len, lcontext_len;
> > +
> > +     rc = security_sid_to_context(state, sid, &context, &context_len);
> > +     if (rc) {
> > +             audit_log_format(ab, "%csid=%d ", type, sid);
> > +             return;
> > +     }
> > +
> > +     audit_log_format(ab, "%ccontext=%s ", type, context);
> > +
> > +     /* in case of invalid context report also the actual context string */
> > +     rc = security_sid_to_context_force(state, sid, &lcontext,
> > +                                        &lcontext_len);
> > +     if (!rc) {
> > +             if (strcmp(context, lcontext))
> > +                     audit_log_format(ab, "%clcon=%s ", type, lcontext);
> > +             kfree(lcontext);
> > +     }
> > +     kfree(context);
> > +}
> > +
> >  /**
> >   * avc_dump_query - Display a SID pair and a class in human-readable form.
> >   * @ssid: source security identifier
> > @@ -174,28 +200,11 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
> >  static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
> >                          u32 ssid, u32 tsid, u16 tclass)
> >  {
> > -     int rc;
> > -     char *scontext;
> > -     u32 scontext_len;
> > -
> > -     rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
> > -     if (rc)
> > -             audit_log_format(ab, "ssid=%d", ssid);
> > -     else {
> > -             audit_log_format(ab, "scontext=%s", scontext);
> > -             kfree(scontext);
> > -     }
> > -
> > -     rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
> > -     if (rc)
> > -             audit_log_format(ab, " tsid=%d", tsid);
> > -     else {
> > -             audit_log_format(ab, " tcontext=%s", scontext);
> > -             kfree(scontext);
> > -     }
> > +     avc_dump_sid(ab, state, ssid, 's');
> > +     avc_dump_sid(ab, state, tsid, 't');
> >
> >       BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> > -     audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
> > +     audit_log_format(ab, "tclass=%s", secclass_map[tclass-1].name);
> >  }
> >
> >  /**
> > --
> > 2.20.1
> >
> > --
> > Linux-audit mailing list
> > Linux-audit@redhat.com
> > https://www.redhat.com/mailman/listinfo/linux-audit
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
