Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96Fh80f029712
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 11:43:08 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k96FgV03000789
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 15:42:31 GMT
Subject: Re: Networking policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
In-Reply-To: <452672AB.4020309@tresys.com>
References: <36282A1733C57546BE392885C0618592015CFBBB@chaos.tcs.tcs-sec.com>
	 <452672AB.4020309@tresys.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:42:57 -0400
Message-Id: <1160149377.26418.67.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 11:13 -0400, Joshua Brindle wrote:
> Venkat Yekkirala wrote:
> > Actually, the above only applies to the compat_net case
> > and there unlabeled_t is just fine.
> >
> >   
> why isn't compat_net using the same default sid for associations?
> > So, there are different MLS constraints (and policy) for
> > the compat_net case as opposed to the new secmark controls.
> >
> >   
> there shouldn't be, compat_net and secmark use different object classes 
> (except association) and the behaviors should not conflict
> > I guess you are planning to have one policy for compat_net
> > and another for secmark?
> >
> >   
> I'll let Chris comment here but I don't think that is ideal.

Agreed, it would not be ideal.  The behaviors shouldn't conflict, so a
unified policy should be doable.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
