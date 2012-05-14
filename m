Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4EKslFY006560
	for <selinux@tycho.nsa.gov>; Mon, 14 May 2012 16:54:47 -0400
Received: by qcsk26 with SMTP id k26so4112816qcs.12
        for <selinux@tycho.nsa.gov>; Mon, 14 May 2012 13:54:48 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: RFC: packet checks always on option
Date: Mon, 14 May 2012 16:54:45 -0400
Message-ID: <1941684.m6pGkLqOxR@sifl>
In-Reply-To: <C42CE43E0E13AB44A299B62E255003740CC39B@TCSEXCH1.tcs-sec.com>
References: <4FA95098.1050201@tresys.com> <2254819.3TiCjlmuru@sifl> <C42CE43E0E13AB44A299B62E255003740CC39B@TCSEXCH1.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, May 14, 2012 04:42:06 PM Chad Hanson wrote:
> > > >> * during boot and shutdown you can guarantee no network access
> > > > 
> > > > You can do this through a variety of other mechanisms that have
> > > > nothing to do with secmark labels.
> > > 
> > > No, you can't.
> > 
> > Yes, you can. See "netif:{ ingress egress }".
> 
> This assumes you have netlabel rules enabled.

Look at the code a bit closer; it works with both labeled IPsec and NetLabel.

Regardless, I see your point.

> I would like to see the configuration option noted as a possibility in
> netlbl_enabled() to be 1 without a kernel patch. This then would assure that
> there are always netif checks are active in the absence of secmark rules is
> this is desired.

*If* we were to do something to enable the per-packet access checks regardless 
of configuration I agree, we should enable the secmark checks and the peer 
label checks.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
