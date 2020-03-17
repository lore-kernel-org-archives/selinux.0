Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6491FC10F29
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 14:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ABB20738
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 14:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgCQODn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:03:43 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37233 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725916AbgCQODn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 10:03:43 -0400
Received: (qmail 24917 invoked by uid 500); 17 Mar 2020 10:03:42 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Mar 2020 10:03:42 -0400
Date:   Tue, 17 Mar 2020 10:03:42 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Dominick Grift <dac.override@gmail.com>
cc:     selinux@vger.kernel.org
Subject: Re: Policy module to allow a domain transition
In-Reply-To: <87y2s0gl15.fsf@gmail.com>
Message-ID: <Pine.LNX.4.44L0.2003170941070.23042-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 16 Mar 2020, Dominick Grift wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > If this is not the the right forum for this discussion, please redirect
> > me to some place more appropriate.  Where to go for good advice on the
> > trickier details of selinux is not obvious.
> >
> > The setting is CentOS 8.1.  I'm running tcpserver as a systemd service.  
> > tcpserver is a general-purpose Internet (actually TCP) service 
> > dispatcher, rather like inetd.
> >
> > In this case, I'm trying to use tcpserver as an entryway to sshd.  It 
> > works fine when selinux is in permissive mode but fails in enforcing 
> > mode.  According to audit.log, the error is:
> >
> > type=AVC msg=audit(1584123331.011:167): avc:  denied  { dyntransition } for  pid=2002 comm="sshd" scontext=system_u:system_r:unconfined_service_t:s0 tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process permissive=1
> >
> > I take this to mean that tcpserver runs in the unconfined_service_t 
> > domain (confirmed by ps -Z), that when it execs the sshd program it 
> > doesn't make the transition to the sshd_t domain, and consequently sshd 
> > is prevented from doing what it wants.
> >
> > audit2allow's recommendation is:
> >
> > 	allow unconfined_service_t unconfined_t:process dyntransition;
> >
> > which probably would work, but it seems like treating the symptom
> > rather than the disease, not to mention opening up a fairly large
> > security hole.  I'd like something a little more specific, particularly
> > since I want to run one or two other services under tcpserver in
> > addition to sshd.
> >
> > Probably the best approach would be to create a new tcpserver_t type
> > with all the appropriate policies, but that's beyond my current skill.  
> > Would it make sense to create a policy module that would simply allow
> > unconfined_service_t to transition to sshd_t?
> >
> > And what would the source for such a policy module look like?  The 
> > impression I get is something like:
> >
> > 	allow unconfined_service_t sshd_exec_t:file { execute
> > 		execute_no_trans getattr ioctl map open read };
> 
> That would be redundant. unconfined_service_t already has broad access
> and from a unconfined_service_t perspective you just need to tell
> selinux what to do:
> 
> type_transition unconfined_service_t sshd_exec_t:process sshd_t;
> 
> That will tell selinux that processes types should transition from
> unconfined_service_t to sshd_t when processes with type
> unconfined_service_t execute files with type sshd_exec_t.
> 
> When you do this and try it out then some avc denials will likely
> surface regarding access that sshd_t processes may need to
> unconfined_service_t processes. (for example sending a child terminated
> signal, but possibly others as well)

Yes, I see what you mean.  I'm getting AVC violations because sshd 
isn't supposed to perform getattr and setopt actions on a tcp_socket of 
type unconfined_service_t, which is what it gets when it inherits a 
socket from tcpserver instead of opening the socket itself.

It looks like the tcp_socket needs to undergo a type transition along
with the process.  Is there any way to express this?

Alan Stern

PS: There appears to be a bunch of redundant rules relating sshd_t and 
tcp_socket in the system's policy database.  Part of the output from 
sesearch says:

allow sshd_t sshd_t:tcp_socket { accept append bind connect create getattr getopt ioctl listen lock read setattr setopt shutdown write };
allow sshd_t sshd_t:tcp_socket { accept append bind connect create getattr getopt ioctl listen lock read setattr setopt shutdown write }; [ nis_enabled ]:True
allow sshd_t sshd_t:tcp_socket { accept append bind connect create getattr getopt ioctl listen lock read setattr setopt shutdown write }; [ nis_enabled ]:True
allow sshd_t sshd_t:tcp_socket { append bind connect create getattr getopt ioctl lock read setattr setopt shutdown write }; [ authlogin_nsswitch_use_ldap ]:True
allow sshd_t sshd_t:tcp_socket { append bind connect create getattr getopt ioctl lock read setattr setopt shutdown write }; [ kerberos_enabled ]:True
allow sshd_t sshd_t:tcp_socket { append bind connect create getattr getopt ioctl lock read setattr setopt shutdown write }; [ kerberos_enabled ]:True
allow sshd_t sshd_t:tcp_socket { append bind connect create getattr getopt ioctl lock read setattr setopt shutdown write }; [ kerberos_enabled ]:True
allow sshd_t tcpd_t:tcp_socket { append bind connect getattr getopt ioctl lock read setattr setopt shutdown write }; [ ssh_use_tcpd ]:True

Don't all those boolean-controlled rules just allow things that are
already allowed anyway?  Or do they override the first rule, forbidding
some of the things it allows (which seems contrary to the idea of using
these booleans to allow things that wouldn't normally be allowed)?

PPS: Is there any document anywhere that explains all the details
needed to understand and create selinux policies?  I see individual
items covered piecemeal in the wiki pages at selinuxproject.org, but no
organized whole.  Certainly nothing that would enable the reader to
formulate a strategy for solving the problem I encountered.

As just one example, is there a complete listing of the syntax
required/accepted by checkmodule in a .te file?

