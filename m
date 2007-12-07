Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB7KjwXg014353
	for <selinux@tycho.nsa.gov>; Fri, 7 Dec 2007 15:45:58 -0500
Received: from g5t0008.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB7KjvrZ010461
	for <selinux@tycho.nsa.gov>; Fri, 7 Dec 2007 20:45:57 GMT
From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] XFRM: assorted IPsec fixups
Date: Fri, 7 Dec 2007 15:45:41 -0500
Cc: netdev@vger.kernel.org, linux-audit@redhat.com, selinux@tycho.nsa.gov
References: <20071207171116.18151.42328.stgit@flek.americas.hpqcorp.net> <1197059769.3183.16.camel@dhcp231-215.rdu.redhat.com>
In-Reply-To: <1197059769.3183.16.camel@dhcp231-215.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712071545.45411.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 07 December 2007 3:36:08 pm Eric Paris wrote:
> On Fri, 2007-12-07 at 12:11 -0500, Paul Moore wrote:
> > This patch fixes a number of small but potentially troublesome things in
> > the XFRM/IPsec code:
> >
> >  * Use the 'audit_enabled' variable already in include/linux/audit.h
> >    Removed the need for extern declarations local to each XFRM audit
> > fuction

{snip}

> although it does make me wonder why audit_log_start doesn't just check
> audit_enabled itself....

/me shrugs ... I have no idea, I've just always followed the lead of what was 
already written, but now that you mention it - it doesn't make much sense.  I 
suppose at some point we can go through and change all the 'audit_enabled' 
users, but I wonder if there is some point (?performance?) to having the 
callers check?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
