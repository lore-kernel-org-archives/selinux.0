Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6OEelUl022796
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 10:40:47 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6OEelWE020618
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 14:40:47 GMT
Subject: RE: hierarchy_check_constraints() needs reworks?
Date: Thu, 24 Jul 2008 10:40:47 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B015880246B2B9@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <48881546.6070903@ak.jp.nec.com>
References: <48881546.6070903@ak.jp.nec.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> 
> In addition, I found two more potential matter in this code.
> 
> The first one is lack of checks for permissions via attribute.
> When a child domain has an attribute which does not applied
> to the parent one, the child can have wider permissions that
> its parent.
> I think any attribute attached to child domain also have to
> be attached to the parent domain.
> (I guess it derived from legacy attribute implementation.)
>

Hierarchy.c:409, expand_avtab will expand all attribute usage into the
avtab. We don't care about attribute usage, only about net permissions
granted. 
 
> The later one is dependencies to the state of boolean.
> Hierarchy constraint allows a child domain to have
> permissions which are enabled for the parent, only if
> specific boolean is turned on. It potentially makes a
> situation that child domain has wider permissions.
> I think it is difficult to check in the policy toolchain, so
> checks on an avc entry creation is better way.
> 

We don't consider the state of booleans when doing analysis of the
policy. The idea was that the avtab is the maximum permissions allowed
and we always test on the maximum permissions. Whether a boolean may
reduce the parents permissions without doing so to the child I think is
a non-issue. Do you have an example of why this might be detrimental?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
