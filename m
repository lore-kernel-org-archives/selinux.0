Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4O99TRb009057
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 05:09:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4O970B2015019
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 09:07:00 GMT
Received: from kokytos.rz.informatik.uni-muenchen.de (kokytos.rz.informatik.uni-muenchen.de [141.84.214.13])
	by jazzswing.ncsc.mil  with ESMTP id i4O96xwi014988
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 09:07:00 GMT
Date: Mon, 24 May 2004 11:09:09 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <rcoker@redhat.com>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: [patch] policy for nrpe
Message-ID: <20040524090907.GA15439@thebe.cip.ifi.lmu.de>
References: <20040523214406.GB6147@jmh.mhn.de> <200405241056.58596.rcoker@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200405241056.58596.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Russell Coker <rcoker@redhat.com> [2004-05-24 02:56]:
> On Mon, 24 May 2004 07:44, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
> wrote:
> > The attached patch adds policy support for nrpe.
> > (nrpe stands for Nagios Remote Plugin Execution and is a client called
> > from inetd which performs checks on a client on behalf of a Nagios
> > server)
> 
> We currently have a netsaint.te in the policy, should we change that to 
> nagios.te?  

Yes, I think it would be best to change the name.

> Should we include the nrpe stuff in the main netsaint.te or 
> nagios.te file or is it best to keep client and server stuff separate?

It should be kept separate. Typically you have one server running
Nagios, but many or all clients running nrpe. So it makes sense to
keep the policy separate.

Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
