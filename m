Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76757C4332F
	for <selinux@archiver.kernel.org>; Wed, 21 Dec 2022 19:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiLUTYx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Dec 2022 14:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiLUTYw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Dec 2022 14:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF81264AD
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 11:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671650644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4C3I/Aflv3a3nMUzlPmw+f0O/d9xiUukrVA5sTOzdo=;
        b=e3EtNgEfAWUy7NV+nxuYlEFd/eGXFuEMYZ7+vR4VqTPynVw+b6DgINTMESogR75q5OCA0Q
        MsUSbO/nnslvoPeaHcMeeijc4WFP+E4zVfR513iDrEbuTe6D7yHL5Uf8ithcroGseRXTp+
        3PQclKGCaAPnM/miZ5DsjAE0/FjA2zk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-Fkzspnp0OpKGOZERQebWXg-1; Wed, 21 Dec 2022 14:24:03 -0500
X-MC-Unique: Fkzspnp0OpKGOZERQebWXg-1
Received: by mail-wm1-f71.google.com with SMTP id f20-20020a7bc8d4000000b003d1cda5bd6fso862544wml.9
        for <selinux@vger.kernel.org>; Wed, 21 Dec 2022 11:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4C3I/Aflv3a3nMUzlPmw+f0O/d9xiUukrVA5sTOzdo=;
        b=E9zJBEToiTb4Frjb86JyIoIdzkH+8IFWyHJ2V8M/FjX9NkQzGMt72M+sxrwrtN5BKn
         GRtuT4fy+m7kzJO8YlojOqu9FOvEnnHYMDydQeKqbc67Os83FZ5Pl9h8x2j+r71TWdOS
         HmoFUL9dPsbTv5k4i2vB2j+1Bcn3a7IAy5RmPzgbQr70V6zgJ/k8ytdCCgeBsXzbPLtx
         9IbN9OFOCG9r2VMtGDydXOw9HbYUkQS8ywr+PR+KvFNDXXlq1jZS/1Cv1WcMq5NKel4O
         M1E+0lGQo7OucyQcSAgRJgUVj8eeesLckPdPiCGemC8/JtvnTFaEtPo9EHtC3svCE9zP
         vRPw==
X-Gm-Message-State: AFqh2koR+Hx9qju079zbcRTdWZS1OPkC8ZRwzPjG2yOZe7qImvvcTcL8
        fTYLSeIyhVVxdDjrkd7oCZRIKlGsQAZnLb2yZGK/yfUearIIuXfiYuv5XLN++589wLVvjt22SFG
        hig+X/XC4FEZN6pNZig==
X-Received: by 2002:a05:600c:601d:b0:3d6:4ba9:c111 with SMTP id az29-20020a05600c601d00b003d64ba9c111mr2561748wmb.40.1671650640556;
        Wed, 21 Dec 2022 11:24:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvxoGwwyTymheQbysuArpiDBLiZi1NQiT6NkCs/M8vdLElzezhLtyH/z6oPBoaDj4DtPpHoQA==
X-Received: by 2002:a05:600c:601d:b0:3d6:4ba9:c111 with SMTP id az29-20020a05600c601d00b003d64ba9c111mr2561741wmb.40.1671650640324;
        Wed, 21 Dec 2022 11:24:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c468c00b003cf57329221sm675610wmo.14.2022.12.21.11.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:23:59 -0800 (PST)
Message-ID: <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Date:   Wed, 21 Dec 2022 20:23:58 +0100
In-Reply-To: <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
References: <cover.1671469167.git.pabeni@redhat.com>
         <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
         <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2022-12-20 at 17:07 -0500, Paul Moore wrote:
> On Mon, Dec 19, 2022 at 12:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > 
> > Newly added subflows should inherit the associated label
> > from the current process context, regarless of the sk_kern_sock
> > flag value.
> > 
> > This patch implements the above resetting the subflow sid, deleting
> > the existing subflow label, if any, and then re-creating a new one.
> > 
> > The new helper reuses the selinux_netlbl_sk_security_free() function,
> > and it can end-up being called multiple times with the same argument;
> > we additionally need to make it idempotent.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> >  - fix build issue with !CONFIG_NETLABEL
> > ---
> >  security/selinux/hooks.c    | 27 +++++++++++++++++++++++++++
> >  security/selinux/netlabel.c |  4 +++-
> >  2 files changed, 30 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3c5be76a9199..f785600b666a 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -5476,6 +5476,32 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
> >         selinux_netlbl_sctp_sk_clone(sk, newsk);
> >  }
> > 
> > +static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
> > +{
> > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > +       struct sk_security_struct *ssksec = ssk->sk_security;
> > +       u16 sclass;
> > +       u32 sid;
> > +       int err;
> > +
> > +       /* create the sid using the current cred, regardless of the ssk kern
> > +        * flag
> > +        */
> > +       sclass = socket_type_to_security_class(ssk->sk_family, ssk->sk_type,
> > +                                              ssk->sk_protocol);
> > +       err = socket_sockcreate_sid(tsec, sclass, &sid);
> > +       if (err)
> > +               return err;
> > +
> > +       ssksec->sid = sid;
> > +
> > +       /* replace the existing subflow label deleting the existing one
> > +        * and re-recrating a new label using the current context
> > +        */
> > +       selinux_netlbl_sk_security_free(ssksec);
> > +       return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);
> > +}
> 
> I thought the idea was to ensure that new subflows of an existing
> MPTCP connection would be created with the same label as the main
> MPTCP connection socket?  The code above labels the new subflow based
> on the current process, not the main MPTCP connection; it matches the
> commit description, but not what we had previously discussed - or I am
> horribly mis-remembering something? :)

You are right, I picked a wrong turn.

I just tested the other option and there is another problem :(

The first subflow creations happens inside af_inet->create, via the sk-
>sk_prot->init() hook. The security_socket_post_create() call on the
owning MPTCP sockets happens after that point. So we copy data from a
not yet initialized security context (and the test fail badly).

There are a few options to cope with that:
- [ugly hack] call  security_socket_post_create() on the mptcp code
before creating the subflow. I experimented this just to double the
problem and a possible solution.

- refactor the mptcp code to create the first subflow on later
syscalls, as needed. This will require quite a bit of refactoring in
the MPTCP protocol as we will need also to update the
shutdown/disconnect accordingly (currently we keep the first subflow
around, instead we will need to close it).

- use the code proposed in these patches as-is ;) 

WDYT?

Thanks,

Paolo

