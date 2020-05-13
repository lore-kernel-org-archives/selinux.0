Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7630CC433DF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 23:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D092053B
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 23:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRqmTzKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbgEMXNl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 19:13:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728315AbgEMXNj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 19:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589411617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmMD6XDgyrg0kIPXb2cMEKa1A3azrPgvq+3AzZZ9RcQ=;
        b=MRqmTzKTW0SY1c1JdKFAy4C69xjdMP4oG2o29KasrcaWu1btdg4d1DcdZFJsEKez7WERP+
        FGvxkYWazbx8UGXNhQDtkj15IhUebhjMGlBm5uyIWgO9W0ry7usragQDWnjfvMXyBIOD6G
        Cnnqz6brjH3xQU8sq6qA9ECNqw4Cfzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-Q9t9zeVRNwCXxVJMkBsddA-1; Wed, 13 May 2020 19:13:35 -0400
X-MC-Unique: Q9t9zeVRNwCXxVJMkBsddA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DA118FE860;
        Wed, 13 May 2020 23:13:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E6F45C1D3;
        Wed, 13 May 2020 23:13:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com>
References: <CAEjxPJ4=ZN_jKP2nX5mrMA3OxC8XLsYEmCPCD-78H4XQw=_hCA@mail.gmail.com> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com> <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        keyrings@vger.kernel.org, SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3611506.1589411611.1@warthog.procyon.org.uk>
Date:   Thu, 14 May 2020 00:13:31 +0100
Message-ID: <3611507.1589411611@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> wrote:

> >  (3) An override due to CAP_SYS_ADMIN.
> 
> CAP_SYS_ADMIN should never skip SELinux checking.  Even for Smack,
> there is a separate capability (CAP_MAC_ADMIN) for that purpose.

The LSM doesn't get consulted at the moment.  With this patch, it will get
consulted.

> >  (4) An override due to an instantiation token being present.
> 
> Not sure what this means but again we shouldn't skip SELinux checking
> based on mere possession of an object capability (not a POSIX
> capability).

The kernel has delegated the instantiation of a key to the calling process and
has given it a temporary key of type ".request_key_auth" which it has put into
force with keyctl(KEYCTL_ASSUME_AUTHORITY).

This authorisation token grants the caller the ability to (a) perform
operations on the key it wouldn't otherwise have permission to do, (b) use the
key instantiation keyctls and (c) temporarily search the keyrings of the
caller of request_key() using the creds of that caller and to read/use the
keys found therein if the caller was permitted to do so.

> It would be better if the permission indicated the actual operation
> (e.g. KEY_NEED_INVALIDATE_SPECIAL), and the decision whether to permit
> CAP_SYS_ADMIN processes to override was left to the security modules.
> SELinux doesn't automatically allow CAP_SYS_ADMIN processes to do
> everything.

These individual permissions don't exist yet.  I have an ACL patchset that
allows me to add a greater range - though there's issues with SELinux there
also.

Also, the keyrings are specially marked to say that the sysadmin is allowed to
flush them at the moment - but that can go away with the ACL stuff.

> > +       switch (need_perm) {
> > +       case KEY_NEED_UNLINK:
> > +       case KEY_SYSADMIN_OVERRIDE:
> > +       case KEY_AUTHTOKEN_OVERRIDE:
> > +       case KEY_DEFER_PERM_CHECK:
> >                 return 0;
> 
> We really shouldn't be skipping any/all checking on CAP_SYS_ADMIN or
> an AUTHTOKEN; those should still be subject to MAC policy.

I'm not sure how to do that.

Note that KEY_NEED_UNLINK *must not* be overruled by the MAC policy.  The
value is only there because lookup_user_key() requires something to be put
into that parameter - it's more of a courtesy thing, I suppose.

Why should AUTHTOKEN be subject to MAC policy?  The kernel has told the
process to go and instantiate a key.  It shouldn't really then turn around and
tell the process "oh, but you're not actually allowed to do that".

David

