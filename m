Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDC6C1975A
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 19:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C87B20753
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 19:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQTaQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:30:16 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41411 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726294AbgCQTaQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 15:30:16 -0400
Received: (qmail 23326 invoked by uid 500); 17 Mar 2020 15:30:15 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Mar 2020 15:30:15 -0400
Date:   Tue, 17 Mar 2020 15:30:15 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Dominick Grift <dac.override@gmail.com>
cc:     selinux@vger.kernel.org
Subject: Re: Policy module to allow a domain transition
In-Reply-To: <87lfnzget4.fsf@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2003171515120.21801-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 17 Mar 2020, Dominick Grift wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Mon, 16 Mar 2020, Dominick Grift wrote:
> >
> >> Alan Stern <stern@rowland.harvard.edu> writes:
> >> 
> >> > If this is not the the right forum for this discussion, please redirect
> >> > me to some place more appropriate.  Where to go for good advice on the
> >> > trickier details of selinux is not obvious.
> >> >
> >> > The setting is CentOS 8.1.  I'm running tcpserver as a systemd service.  
> >> > tcpserver is a general-purpose Internet (actually TCP) service 
> >> > dispatcher, rather like inetd.
> >> >
> >> > In this case, I'm trying to use tcpserver as an entryway to sshd.  It 
> >> > works fine when selinux is in permissive mode but fails in enforcing 
> >> > mode.  According to audit.log, the error is:
> >> >
> >> > type=AVC msg=audit(1584123331.011:167): avc:  denied  { dyntransition } for  pid=2002 comm="sshd" scontext=system_u:system_r:unconfined_service_t:s0 tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process permissive=1
> >> >
> >> > I take this to mean that tcpserver runs in the unconfined_service_t 
> >> > domain (confirmed by ps -Z), that when it execs the sshd program it 
> >> > doesn't make the transition to the sshd_t domain, and consequently sshd 
> >> > is prevented from doing what it wants.
> >> >
> >> > audit2allow's recommendation is:
> >> >
> >> > 	allow unconfined_service_t unconfined_t:process dyntransition;
> >> >
> >> > which probably would work, but it seems like treating the symptom
> >> > rather than the disease, not to mention opening up a fairly large
> >> > security hole.  I'd like something a little more specific, particularly
> >> > since I want to run one or two other services under tcpserver in
> >> > addition to sshd.
> >> >
> >> > Probably the best approach would be to create a new tcpserver_t type
> >> > with all the appropriate policies, but that's beyond my current skill.  
> >> > Would it make sense to create a policy module that would simply allow
> >> > unconfined_service_t to transition to sshd_t?
> >> >
> >> > And what would the source for such a policy module look like?  The 
> >> > impression I get is something like:
> >> >
> >> > 	allow unconfined_service_t sshd_exec_t:file { execute
> >> > 		execute_no_trans getattr ioctl map open read };
> >> 
> >> That would be redundant. unconfined_service_t already has broad access
> >> and from a unconfined_service_t perspective you just need to tell
> >> selinux what to do:
> >> 
> >> type_transition unconfined_service_t sshd_exec_t:process sshd_t;
> >> 
> >> That will tell selinux that processes types should transition from
> >> unconfined_service_t to sshd_t when processes with type
> >> unconfined_service_t execute files with type sshd_exec_t.
> >> 
> >> When you do this and try it out then some avc denials will likely
> >> surface regarding access that sshd_t processes may need to
> >> unconfined_service_t processes. (for example sending a child terminated
> >> signal, but possibly others as well)
> >
> > Yes, I see what you mean.  I'm getting AVC violations because sshd 
> > isn't supposed to perform getattr and setopt actions on a tcp_socket of 
> > type unconfined_service_t, which is what it gets when it inherits a 
> > socket from tcpserver instead of opening the socket itself.
> >
> > It looks like the tcp_socket needs to undergo a type transition along
> > with the process.  Is there any way to express this?
> 
> tcpd would have to grow selinux awareness and do that manually using the
> setsockcreate() functionality provided by libselinux.
> 
> systemd does this with its socket activation functionality.

All right, so rather than try to change the programs, I added the
following TE rule:

allow sshd_t unconfined_service_t:tcp_socket { getattr setopt };

With that, sshd under tcpserver worked okay in permissive mode, with no
AVC notices in audit.log.  But when I changed to enforcing mode, the
program failed for no apparent reason (and again, no AVC messages).  
The remote system merely reported "Connection reset by peer".  Any idea
what's wrong?

Alan Stern

