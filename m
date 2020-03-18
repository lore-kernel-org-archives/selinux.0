Return-Path: <SRS0=MhFn=5D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B80EC1975A
	for <selinux@archiver.kernel.org>; Wed, 18 Mar 2020 00:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0723D20724
	for <selinux@archiver.kernel.org>; Wed, 18 Mar 2020 00:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCRAzX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:55:23 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46673 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727197AbgCRAzX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 20:55:23 -0400
Received: (qmail 19629 invoked by uid 500); 17 Mar 2020 20:55:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Mar 2020 20:55:22 -0400
Date:   Tue, 17 Mar 2020 20:55:22 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Dominick Grift <dac.override@gmail.com>
cc:     selinux@vger.kernel.org
Subject: Re: Policy module to allow a domain transition
In-Reply-To: <87h7ymhitx.fsf@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2003172050100.19310-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 17 Mar 2020, Dominick Grift wrote:

> > All right, so rather than try to change the programs, I added the
> > following TE rule:
> >
> > allow sshd_t unconfined_service_t:tcp_socket { getattr setopt };
> >
> > With that, sshd under tcpserver worked okay in permissive mode, with no
> > AVC notices in audit.log.  But when I changed to enforcing mode, the
> > program failed for no apparent reason (and again, no AVC messages).  
> > The remote system merely reported "Connection reset by peer".  Any idea
> > what's wrong?
> 
> You can run `semodule -DB` to make SELinux more verbose. (use `semodule
> -B` to make SELinux less verbose when youre done)
> 
> My guess is that some socket accesses are silently blocked. Is a long
> story but the socket read and write accessed might be silently blocked
> because they are often false positives caused by leaked file
> descriptors.
> 
> In this case the read write on tcp_socket would be legit and would need
> to be allowed.
> 
> So if you do a `semodule -DB` then reproduce a login, then look for avc
> denials related to sshd_t, unconfined_service_t and tcp_sockets (my bet
> is on read and write) but eventually sshd obviously also needs to
> "accept" connections as well. In other words: "tcp_socket { getattr
> setopt }" is incomplete but the next access attempts (read/write) are
> silently blocked by policy and so without that it cannot do its job.

You hit the nail on the head.  As it turns out, not only did sshd_t
need read/write access to the tcp_socket, so did sshd_net_t.  I have no
idea what that type is for, but when I added the permission the program 
worked.

Thanks for your help.

Alan Stern

