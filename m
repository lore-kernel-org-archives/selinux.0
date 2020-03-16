Return-Path: <SRS0=RXLG=5B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8AAC0044D
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 16:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46CA20679
	for <selinux@archiver.kernel.org>; Mon, 16 Mar 2020 16:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbgCPQEt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:04:49 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58831 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731674AbgCPQEt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Mar 2020 12:04:49 -0400
Received: (qmail 9520 invoked by uid 500); 16 Mar 2020 12:04:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Mar 2020 12:04:48 -0400
Date:   Mon, 16 Mar 2020 12:04:48 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     selinux@vger.kernel.org
Subject: Policy module to allow a domain transition
Message-ID: <Pine.LNX.4.44L0.2003161146070.8175-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If this is not the the right forum for this discussion, please redirect
me to some place more appropriate.  Where to go for good advice on the
trickier details of selinux is not obvious.

The setting is CentOS 8.1.  I'm running tcpserver as a systemd service.  
tcpserver is a general-purpose Internet (actually TCP) service 
dispatcher, rather like inetd.

In this case, I'm trying to use tcpserver as an entryway to sshd.  It 
works fine when selinux is in permissive mode but fails in enforcing 
mode.  According to audit.log, the error is:

type=AVC msg=audit(1584123331.011:167): avc:  denied  { dyntransition } for  pid=2002 comm="sshd" scontext=system_u:system_r:unconfined_service_t:s0 tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process permissive=1

I take this to mean that tcpserver runs in the unconfined_service_t 
domain (confirmed by ps -Z), that when it execs the sshd program it 
doesn't make the transition to the sshd_t domain, and consequently sshd 
is prevented from doing what it wants.

audit2allow's recommendation is:

	allow unconfined_service_t unconfined_t:process dyntransition;

which probably would work, but it seems like treating the symptom
rather than the disease, not to mention opening up a fairly large
security hole.  I'd like something a little more specific, particularly
since I want to run one or two other services under tcpserver in
addition to sshd.

Probably the best approach would be to create a new tcpserver_t type
with all the appropriate policies, but that's beyond my current skill.  
Would it make sense to create a policy module that would simply allow
unconfined_service_t to transition to sshd_t?

And what would the source for such a policy module look like?  The 
impression I get is something like:

	allow unconfined_service_t sshd_exec_t:file { execute
		execute_no_trans getattr ioctl map open read };

basically just a copy an existing policy for inetd_t and 
sshd_exec_t.  Is that the right way to go about this?  Is there 
something better?

Thank you,

Alan Stern

