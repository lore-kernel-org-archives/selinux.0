Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1GDxgXf026698
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 08:59:43 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1GDxd8P006145
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 13:59:39 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id k1GDwZUW016698
	for <selinux@tycho.nsa.gov>; Thu, 16 Feb 2006 08:58:35 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id k1GDwZL6016697
	for selinux@tycho.nsa.gov; Thu, 16 Feb 2006 08:58:35 -0500
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k1FGNDXf013286
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2006 11:23:13 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1FGNAtx021216
	for <selinux@tycho.nsa.gov>; Wed, 15 Feb 2006 16:23:11 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: linux-audit@redhat.com
Subject: Re: [RFC][PATCH] collect security labels on user =?iso-8859-1?q?processes=09generating_audit?= messages
Date: Wed, 15 Feb 2006 11:22:37 -0500
Cc: Linda Knippers <linda.knippers@hp.com>,
   "Timothy R. Chavez" <tinytim@us.ibm.com>, James Morris <jmorris@namei.org>,
   selinux@tycho.nsa.gov
References: <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com> <1140018578.11792.23.camel@localhost> <43F35354.2090108@hp.com>
In-Reply-To: <43F35354.2090108@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602151122.37945.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This should be a separate thread since the topic is different.

On Wednesday 15 February 2006 11:14, Linda Knippers wrote:
> Amy submitted a patch a while back to eliminate the "name=" field
> to avoid "name=(null)" from the audit records if there was no name
> but I don't think the patch went anywhere.

Right. I want all audit fields to have name=value. If we have %s in the 
message and pass NULL to it, snprintf is already going to put "(null)" so 
what's wrong with just using this precedent?

> It looks like there's a new case (for tty) where "(none)" is used.

Yes for the same reason.


> It would be nice to avoid having this in the audit records, especially
> in this case where the value might never be set on a particular system.

It creates parsing problems without a value. If I saw "tty="  and that's all, 
I'd think the audit system malfunctioned and file a bugzilla. I don't want 
that.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
