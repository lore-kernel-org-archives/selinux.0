Return-Path: <SRS0=n8ca=RC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD81C43381
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 09:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EFB2063F
	for <selinux@archiver.kernel.org>; Wed, 27 Feb 2019 09:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfB0Jjh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:39:37 -0500
Received: from dgrift.xs4all.space ([80.100.19.56]:52366 "EHLO
        agnus.defensec.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0Jjh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Feb 2019 04:39:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by agnus.defensec.nl (Postfix) with ESMTP id A11AA2E0FA1;
        Wed, 27 Feb 2019 10:39:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at defensec.nl
Received: from agnus.defensec.nl ([127.0.0.1])
        by localhost (agnus.defensec.nl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id XSiRfkjzYfug; Wed, 27 Feb 2019 10:39:34 +0100 (CET)
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 98B192E0F9F;
        Wed, 27 Feb 2019 10:39:34 +0100 (CET)
Date:   Wed, 27 Feb 2019 10:39:33 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Ted Toth <txtoth@gmail.com>, selinux@vger.kernel.org
Subject: Re: RHEL auth_role using logging_send_audit_msgs
Message-ID: <20190227093933.GA28317@brutus.lan>
References: <CAFPpqQEHRb5pW7HGx7-yZgBbneA3US_nb4HqRAG5uSkYbxg+Jw@mail.gmail.com>
 <20190227082107.GA17179@brutus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227082107.GA17179@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 27, 2019 at 09:21:07AM +0100, Dominick Grift wrote:
> On Tue, Feb 26, 2019 at 04:20:42PM -0600, Ted Toth wrote:
> > The RHEL version of the auth_role macro which we are getting through
> > our use of userdom_unpriv_user_template uses logging_send_audit_msgs
> > which give a type the audit_write capability and allow rules for a
> > number of netlink_audit_socket operations. It seem counterintuitive to
> > give an unprivileged user type audit write related policy.The
> > ref-policy version of auth_role does not use logging_send_audit_msgs.
> > We're considering patching our policy but I wanted to see what others
> > though about giving unprivileged user types this policy?
> > 
> > Ted
> 
> I think this should indeed probably be dontaudited (i have a few of those in my policy as well, so do as i say not as i do)
> 
> Might have been added because of some unpriviliged user space object manager trying to log to audit. These would not have been allowed anyway.
> 
> XSELinux, old dbus come to mind.

Actually, I don't think its this simple. There are also setuid pam clients like for example screen.

I do think the goal should at least be to not allow this to user shells, by moving any pam clients out of the shell domain and into private domains.

Looking at my policy i think i settled for that compromize. I moved all known pam clients and user space object managers to private domains.
But i also rely a little on DAC here. Atleast access is contained to just these domains.

Take for example xserver it can be run as root and as unpriv user. xserver is both pam client as well as user space object manager. So unless you want to overcomplicate things you end up giving xserver pam access/audit access whether it runs as root or not

> 
> -- 
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift



-- 
Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
Dominick Grift
