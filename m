Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TGoa8O026645
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 12:50:36 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TGo0u8016534
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 16:50:01 GMT
Date: Fri, 29 Sep 2006 12:50:32 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <method@gentoo.org>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Subject: Re: [PATCH 7/7] secid reconciliation-v03: Enforcement for SELinux
In-Reply-To: <451D4A51.4000603@hp.com>
Message-ID: <Pine.LNX.4.64.0609291247170.6007@d.namei>
References: <36282A1733C57546BE392885C0618592015CF2BE@chaos.tcs.tcs-sec.com>
 <451D4A51.4000603@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Sep 2006, Paul Moore wrote:

> > It seems more of a pain to actually
> > prevent their use at the same time and/or explain strange/unnatural
> > behavior.
> 
> Agreed, the solution that we agreed upon is much easier to implement and
> explain than a lot of the alternatives.

Ok, can you please explain it further?

i.e. show me what the policy looks like, exactly what the user is trying 
to achieve, and explain what happens to each packet exactly in terms of 
labeling on the input and output paths.




-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
