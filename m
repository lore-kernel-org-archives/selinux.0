Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17506C54FCB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25B2206D9
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 15:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="S9/1RV0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgD0PYa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0PYa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 11:24:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A25C03C1A7
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 08:24:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id r7so13743383edo.11
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLfkmnAmNVphbG9R0lr0hF06PEKfNMCkHl7LVzkw/sE=;
        b=S9/1RV0XeEBnzxqpE5Cu04AK9oPmaIKsXZfMBbLcDnlc0vKRrmMi0J0YbdjIgm5qbe
         5z5t8JpyPByEzAFOOZZjymrqvsscl9jU3WwvmWVJz1LIWkaxSwwL+qnWYogHgKuPWqYH
         bSfToHcp40y4Buyt20clBUotWNf8tTENoSH20jkmOecbaHJK9T2h6AO1buD0oAGpOoNi
         T66Ri9duCWOZ2Ut0D/7rlf+fJHTrXUDQ8WZbWP41wQRHrk7jwOAGBPJ1ygLUDQJCS74a
         YkuzCQqzS9CFxVe6Vg/EJI8p0225fyGl7yUhC0MwEPBQG0CANsP4jJ4meGImzQ0d7UWI
         NXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLfkmnAmNVphbG9R0lr0hF06PEKfNMCkHl7LVzkw/sE=;
        b=S/HGvhb5KXv3OhS4Ulf7TaRDzqZdC56/3vh8aUFArODUVozFH21Ebvqo7jUk+4WNc3
         EAAazUFPK8rWwYpLcIkH0xm4erXEHsFuOpH36aYZFMQINBS9/CrkiS/j57XKzDNf7x/X
         nr8RiEWh+l6q567XTpcUSsurWQ+g67Qaz9BzH0YD1kdriP5y9D2Ak+43tLrHFOyKble0
         SnF45KQTDPuZRg/KnRYGvs7aWmxAjrDsrtAUtHa+BXLSja2iZ+DiqdeHlfu/lpLJcBZv
         +kVViQJ/vQReAlfjUDimrjLc7dD05Zob3xqk4eDkWHqaJfS1DSLyP6/pRiSYkQlBkibi
         ruLg==
X-Gm-Message-State: AGi0PuaHxgBgB9FunzdohfKqqGdRzkAuVf6H9agszI1c+fp4hdOHw8gW
        ixRhuD2Nt+VfW3KPh6QKP8lGSwaHKPn3T0LMpby9
X-Google-Smtp-Source: APiQypLOcuYsweG3zdDR3Xg2WVeSZJ8Iwg7/3aFs+GmdwkODkXo2vz6N6dKj/SxkwlKgQ3ULvGfxkJgUWRmxcjrUSRM=
X-Received: by 2002:a50:d98b:: with SMTP id w11mr17688742edj.196.1588001068417;
 Mon, 27 Apr 2020 08:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <2136640.1587472186@warthog.procyon.org.uk> <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
 <3834193.1587771802@warthog.procyon.org.uk> <CAHC9VhQbhG8-ZABtkZr1FXo9cuH4_nsbB=HP_fGvW+FNQ7iAXg@mail.gmail.com>
 <355576.1587996734@warthog.procyon.org.uk> <CAEjxPJ4ScTAbOOxd8FUa2XcfMqbNuWLxnHhRko=je2+0re8Ztg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ScTAbOOxd8FUa2XcfMqbNuWLxnHhRko=je2+0re8Ztg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Apr 2020 11:24:17 -0400
Message-ID: <CAHC9VhRQfq+QsmdwkNfLs8bs8xGnBOA3_G=+--13sTmUkdjgCQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 27, 2020 at 10:36 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Apr 27, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:
> >
> > Paul Moore <paul@paul-moore.com> wrote:
> >
> > > Okay, can you send the next version of the patch to the SELinux list for
> > > review?
> >
> > Here you go.  Note that I did this a few days ago and I actually used EACCES
> > rather than EPERM.  Which one is one preferred for this?
>
> Generally SELinux returns EACCES unless the hook normally returns
> EPERM (e.g. capable).
> Should we use a build-time or runtime guard to catch introduction of
> new KEY_NEED values without corresponding SELinux
> permissions?
>
> >
> > David
> > ---
> > selinux: Fix use of KEY_NEED_* instead of KEY__* perms
> >
> > selinux_key_getsecurity() is passing the KEY_NEED_* permissions to
> > security_sid_to_context() instead of the KEY__* values.  It happens to work
>
> s/security_sid_to_context/avc_has_perm
>
> > because the values are all coincident.
>
> Shrug.  That was just a requirement on key permissions when they were
> introduced; same is true of capabilities.
> Not opposed to explicitly mapping them now but it isn't really a bug.

I haven't looked at the rest of the patch yet, but I wanted to make a
quick comment on this ... over the years I've seen a number of
problems that crop up because of cross-subsytem assumptions, unless
there is some performance critical path where the mapping is
problematic I would prefer to see a translation layer to help protect
SELinux.

-- 
paul moore
www.paul-moore.com
