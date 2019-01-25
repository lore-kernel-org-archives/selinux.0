Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650D0C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 09:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360092084A
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 09:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfAYJxV convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:53:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40245 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfAYJxU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 25 Jan 2019 04:53:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so7980026oth.7
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 01:53:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zS7FT2HHTg3L2qh2Deo3X0MjjcJKMMUy91+zVce4ons=;
        b=JWBkuWmea9SVr2uzchD761BSYAjETaXnkH6VhZ2DK4gd2RFal3i2Ri2MyxieWLQD6B
         YJnhktLK9OVQHgkYWsLqe7CLaPpRGnOswNui3X+bzS9MRocqU536CRxlMS5E4Vcv3tz9
         DEdWBo1uIVrMt9p9D9kepulfBGX2V+DoQFVsYRqngyvvf/PQ8lc4RIbFzCvNF2WdOoqk
         yGxaUiDzHaAgU8LRcMOHXY6rKsjoKCyxsCGxYMfEcN7AKSb1uMoJthM+IWlV8+qHUox2
         EuechkW7tV/SZz7VfHmdCQiXLfa0HUgzXl/1vKfM55tsbrfDjkHY5ppC+uFNUvBKgtYG
         TLfw==
X-Gm-Message-State: AJcUukcfIpJuof4V3B1mabcTptWj8r4eF6ZZmMpxh7r+22KQKqo6ZFtC
        D5OPOANiytLctUEFbqVpM57gH2oSVwmx/eKlBUJHr+M9
X-Google-Smtp-Source: ALg8bN7HhemlhpfU1zQ60i4yFEunJTG3PaZ9aFY9T/uAkRFO2tByHmCc7A5y8P87pal0IuVyFXp/y8JdqmaS9H9+tq0=
X-Received: by 2002:a9d:3d0:: with SMTP id f74mr7054585otf.52.1548409999579;
 Fri, 25 Jan 2019 01:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20190121153605.26847-1-omosnace@redhat.com> <CAHC9VhRDSMeojFEFz+8rshiP4TmtoGuEuOK0AwZecyJ0SWN3Ug@mail.gmail.com>
In-Reply-To: <CAHC9VhRDSMeojFEFz+8rshiP4TmtoGuEuOK0AwZecyJ0SWN3Ug@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 25 Jan 2019 10:53:08 +0100
Message-ID: <CAFqZXNtkUC88X9sfr4Kaq=QDN-H9G=xHKEntyE2mfvC5S0aVXQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: log invalid contexts in AVCs
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 22, 2019 at 8:42 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Jan 21, 2019 at 10:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > In case a file has an invalid context set, in an AVC record generated
> > upon access to such file, the target context is always reported as
> > unlabeled. This patch adds new optional fields to the AVC record
> > (srawcon and trawcon) that report the actual context string if it
> > differs from the one reported in scontext/tcontext. This is useful for
> > diagnosing SELinux denials involving invalid contexts.
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
> > type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 trawcon=system_u:object_r:banana_t:s0 tclass=file permissive=1
>
> I would like us to add new fields at the end of existing records; the
> recent audit config changes are a bit of a special case as discussed
> previously.

Okay, I happened to find a way to do this a little differently (taking
a suggestion from Stephen about avoiding the need to do strcmp()) so
now it is actually easy to move them at the end. But I didn't expect
to get a more liberal reply from Steve (who is usually more strict
about this) than you :)

>
> Also, under what cases would we ever see a srawcon field?  This is
> only going to happen if we have a running process whose domain is
> removed during a policy reload, correct?  I'm find with including this
> for the sake of completeness, but I would mention this in the patch
> description for the next revision.

I tried to find a similar reproducer as for trawcon, but it doesn't
seem to be possible to do that without reloading the policy. I will
just add a note.

>
> > Cc: Daniel Walsh <dwalsh@redhat.com>
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1135683
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > v2: Rename fields to "(s|t)rawcon".
> >
> >  security/selinux/avc.c | 49 +++++++++++++++++++++++++-----------------
> >  1 file changed, 29 insertions(+), 20 deletions(-)
> >
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 9b63d8ee1687..df5490db575b 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -165,6 +165,32 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
> >         audit_log_format(ab, " }");
> >  }
> >
> > +static void avc_dump_sid(struct audit_buffer *ab, struct selinux_state *state,
> > +                        u32 sid, char type)
> > +{
> > +       int rc;
> > +       char *context, *rcontext;
> > +       u32 context_len, rcontext_len;
> > +
> > +       rc = security_sid_to_context(state, sid, &context, &context_len);
> > +       if (rc) {
> > +               audit_log_format(ab, "%csid=%d ", type, sid);
> > +               return;
> > +       }
> > +
> > +       audit_log_format(ab, "%ccontext=%s ", type, context);
> > +
> > +       /* in case of invalid context report also the actual context string */
> > +       rc = security_sid_to_context_force(state, sid, &rcontext,
> > +                                          &rcontext_len);
> > +       if (!rc) {
> > +               if (strcmp(context, rcontext))
> > +                       audit_log_format(ab, "%crawcon=%s ", type, rcontext);
> > +               kfree(rcontext);
> > +       }
> > +       kfree(context);
> > +}
> > +
> >  /**
> >   * avc_dump_query - Display a SID pair and a class in human-readable form.
> >   * @ssid: source security identifier
> > @@ -174,28 +200,11 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
> >  static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
> >                            u32 ssid, u32 tsid, u16 tclass)
> >  {
> > -       int rc;
> > -       char *scontext;
> > -       u32 scontext_len;
> > -
> > -       rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
> > -       if (rc)
> > -               audit_log_format(ab, "ssid=%d", ssid);
> > -       else {
> > -               audit_log_format(ab, "scontext=%s", scontext);
> > -               kfree(scontext);
> > -       }
> > -
> > -       rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
> > -       if (rc)
> > -               audit_log_format(ab, " tsid=%d", tsid);
> > -       else {
> > -               audit_log_format(ab, " tcontext=%s", scontext);
> > -               kfree(scontext);
> > -       }
> > +       avc_dump_sid(ab, state, ssid, 's');
> > +       avc_dump_sid(ab, state, tsid, 't');
> >
> >         BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> > -       audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
> > +       audit_log_format(ab, "tclass=%s", secclass_map[tclass-1].name);
> >  }
> >
> >  /**
> > --
> > 2.20.1
>
> --
> paul moore
> www.paul-moore.com

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
