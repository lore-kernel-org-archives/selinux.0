Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA52AC43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B596D22527
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 16:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFPNHe49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfLLQDV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:03:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27079 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729618AbfLLQDV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 11:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576166599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1MMaFBO/gL/SISGr7Vc7VFndOnccsU620OgzX8/Wmzw=;
        b=gFPNHe492vkIy8Xa9gPfijiQVQ0/Kci+3pXZBJw3X2JrEvNX3URRLDHiBE7UZkiqe7tSfM
        LN0vfhwG8EVBnRHRcPd0P/J02CN6xPqGqmRKGUTwQs38J4dOy+OB+fQ2L0whqwYnlsKMLb
        rQHl8yYT6VMmCEJ3oDF0mqQaU88gl+o=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-I1hy9nIPPxqhHMk_P_3ywA-1; Thu, 12 Dec 2019 11:03:18 -0500
X-MC-Unique: I1hy9nIPPxqhHMk_P_3ywA-1
Received: by mail-oi1-f199.google.com with SMTP id v130so813455oif.18
        for <selinux@vger.kernel.org>; Thu, 12 Dec 2019 08:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MMaFBO/gL/SISGr7Vc7VFndOnccsU620OgzX8/Wmzw=;
        b=D9RFkX6Wdt8p+hP1DcOAsBnp3JBXhmKEuR1TEJ8+giXR5lRXrQKw+zn6ajmM0IICsJ
         gt7nwecQjCipVtBXeVdmG3JGo6Hk5D/QCml7DBIIrm5vU2Qp2qnv5nZUZqmULw6U9xB5
         fkMML4wKnde1tmpjYfDLZ5uSLYSdJA7QNahS8ghokIjiBVuuVWMhT0m+9b9PXogrZwoH
         KRDlsvODT0T4LL5IohD7R4XWg68KpgT4faeqX0VaEIT5gCXTdbevIVaICh3qK/Ww6GEE
         NyZqiy0HK2mEhhb5wBvYMUDD3pK9Fj1lBIh1UiS0fIf4J5TbhCzoub6RmePnRpH8wg16
         qDhA==
X-Gm-Message-State: APjAAAVXX6kV9c1ZJhNf0dFhnt1svdCLN96uiUvD+sxm2p9Tn1u9GDkH
        7FILxdMb/FVTs60PKhJh4qWuEesbnxjctxbgOkkSjUPlktFE7551ECDNU/dHk3cMOptpjk/j0yB
        C6kEaB3SHTHY1TcZmLdtVM+DFE4PqCSOZ4Q==
X-Received: by 2002:aca:498e:: with SMTP id w136mr827446oia.103.1576166597334;
        Thu, 12 Dec 2019 08:03:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqxf/8HbpzahUgvj05ZxnnoEPurDochWKDityadFNIJw87ktdSLpFgVvvYkOJMNwxAYIibp2IlwX3BDEEyRYTOw=
X-Received: by 2002:aca:498e:: with SMTP id w136mr827410oia.103.1576166596929;
 Thu, 12 Dec 2019 08:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook> <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov> <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov>
In-Reply-To: <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Dec 2019 17:03:05 +0100
Message-ID: <CAFqZXNsZvTfeL_ST7FSxbgM28E3RzKrF1f4JqYUhVY7++01NMw@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 12, 2019 at 2:14 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
> > On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> On 12/11/19 1:35 PM, Casey Schaufler wrote:
> >>> On 12/11/2019 8:42 AM, Kees Cook wrote:
> >>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
> >>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> >>>>>> Instead of deleting the hooks from each list one-by-one (which creates
> >>>>>> some bad race conditions), allow an LSM to provide a reference to its
> >>>>>> "enabled" variable and check this variable before calling the hook.
> >>>>>>
> >>>>>> As a nice side effect, this allows marking the hooks (and other stuff)
> >>>>>> __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longer
> >>>>>> makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directly
> >>>>>> for turning on the runtime disable functionality, to emphasize that this
> >>>>>> is only used by SELinux and is meant to be removed in the future.
> >>>>> Is this fundamentally different/better than adding if (!selinux_enabled)
> >>>>> return 0; to the beginning of every SELinux hook function?  And as I noted
> >>>>> to Casey in the earlier thread, that provides an additional easy target to
> >>>>> kernel exploit writers for neutering SELinux with a single kernel write
> >>>>> vulnerability. OTOH, they already have selinux_state.enforcing and friends,
> >>>>> and this new one would only be if SECURITY_SELINUX_DISABLE=y.
> >>>> Yeah, I agree here -- we specifically do not want there to be a trivial
> >>>> way to disable LSMs at runtime. CONFIG_SECURITY_SELINUX_DISABLE should
> >>>> be considered deprecated IMO, and we don't want to widen its features.
> >>>
> >>> In /etc/selinux/config SELINUX=disabled is documented as "No SELinux
> >>> policy is loaded". How about if instead of blocking policy load and
> >>> removing the hooks it just blocked policy load? It may be appropriate
> >>> to tweak the code a bit to perform better in the no-policy loaded
> >>> case, but my understanding is that the system should work. That would
> >>> address backward compatibility concerns and allow removal of
> >>> security_delete_hooks(). I don't think this would have the same
> >>> exposure of resetting selinux_enabled.
> >>
> >> I think that comment stems from before runtime disable was first
> >> implemented in the kernel, when the only option was to leave SELinux
> >> enabled with no policy loaded.  Fedora didn't consider that (or
> >> selinux=0) to be acceptable alternatives, which is why we have runtime
> >> disable today.
> >
> > Do you happen to remember the reasons why it wasn't acceptable? We are
> > ready to start pushing for disabling SECURITY_SELINUX_DISABLE in
> > Fedora, but we're not sure why it is so crucial. Knowing what we need
> > to address before disabling/removing it would help a lot.
>
> IIRC, they considered the selinux=0 kernel boot parameter to be
> inadequate because of the difficulty in changing kernel boot parameters
> on certain platforms (IBM?).  The no-policy-loaded alternative still
> left a lot of SELinux processing in place, so users would still end up
> paying memory and runtime overheads for no benefit if we only skipped
> policy load.

Thanks, I was worried that there was also something more tricky than
this. We could make adding-removing the kernel parameter easier on
Fedora by creating and maintaining a tool that would be able to do it
reliably across the supported arches. That shouldn't be too hard,
hopefully.

>
> >> selinux_state.initialized reflects whether a policy has
> >> been loaded.  With a few exceptions in certain hook functions, it is
> >> only checked by the security server service functions
> >> (security/selinux/ss/services.c) prior to accessing the policydb.  So
> >> there is a lot of SELinux processing that would still occur in that
> >> situation unless we added if (!selinux_state.initialized) return 0;
> >> checks to all the hook functions, which would create the same exposure
> >> and would further break the SELinux-enabled case (we need to perform
> >> some SELinux processing pre-policy-load to allocate blobs and track what
> >> tasks and objects require delayed security initialization when policy
> >> load finally occurs).
> >
> > I think what Casey was suggesting is to add another flag that would
> > switch from "no policy loaded, but we expect it to be loaded
> > eventually" to "no policy loaded and we don't expect/allow it to be
> > loaded any more", which is essentially equivalent to checking
> > selinux_enabled in each hook, which you had already brought up.
>
> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
> might be the best option until it can be removed altogether; avoids
> impacting the LSM framework or any other security module, preserves the
> existing functionality, fairly low overhead on the SELinux-disabled case.

OK, so I'll put together another patch that removes all the
security_delete_hooks() stuff and adds the checks.

>
> NB selinux_enabled was originally just for selinux=0 handling and thus
> remains global (not per selinux-namespace).  selinux_state.disabled is
> only for runtime disable via selinuxfs, which could be applied per
> selinux-namespace if/when selinux namespaces are ever completed and
> merged. Aside from clearing selinux_enabled in selinux_disable() and
> logging selinux_enabled in sel_write_enforce() - which seems pointless
> by the way, there are no other uses of selinux_enabled outside of __init
> code AFAICS.  I think at one time selinux_enabled was exported for use
> by other kernel code related to SECMARK or elsewhere but that was
> eliminated/generalized for other security modules.  So it seems like we
> could always make selinux_enabled itself ro_after_init, stop clearing it
> in selinux_disable() since nothing will be testing it, and just use
> selinux_state.disabled in the hooks (and possibly in the
> sel_write_enforce audit log).

Yes, that sounds reasonable.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

