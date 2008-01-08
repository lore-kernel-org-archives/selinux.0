Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m08H3MEO015156
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2008 12:03:23 -0500
Received: from g5t0009.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m08H3MN3025413
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2008 17:03:22 GMT
Received: from g5t0009.atlanta.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id DB8AB302D5
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 17:03:21 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.cnd.hp.com [15.15.136.127])
	by g5t0009.atlanta.hp.com (Postfix) with ESMTP id D0BDB3026C
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 17:03:21 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 90C191E0F50
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 17:03:21 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 78317134002
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 10:03:21 -0700 (MST)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g5Qpwk7Y1dM0 for <selinux@tycho.nsa.gov>;
	Tue,  8 Jan 2008 10:03:17 -0700 (MST)
Received: from flek.americas.hpqcorp.net (flek.americas.hpqcorp.net [16.116.102.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ldl.fc.hp.com (Postfix) with ESMTP id 59524134003
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 10:03:17 -0700 (MST)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH] SELinux: Add network ingress and egress control permission checks
Date: Tue, 8 Jan 2008 12:03:16 -0500
References: <20080105002920.28482.29256.stgit@flek.americas.hpqcorp.net> <20080105003456.28482.59925.stgit@flek.americas.hpqcorp.net> <Xine.LNX.4.64.0801070922120.21625@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0801070922120.21625@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801081203.16131.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 06 January 2008 5:22:25 pm James Morris wrote:
> On Fri, 4 Jan 2008, Paul Moore wrote:
> > This patch implements packet ingress/egress controls for SELinux
> > which allow SELinux security policy to control the flow of all IPv4
> > and IPv6 packets into and out of the system.  Currently SELinux
> > does not have proper control over forwarded packets and this patch
> > corrects this problem.
> >
> > Special thanks to Venkat Yekkirala <vyekkirala@trustedcs.com> whose
> > earlier work on this topic eventually led to this patch.
> >
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
>
> Please send this to netdev for review.

For those of you who don't follow netdev, this approach got a thumbs up 
so it looks like we are still on track for 2.6.25.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
