Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4O0wBRb007472
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 20:58:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4O0tgB2005498
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 00:55:42 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4O0tewi005454
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 00:55:41 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: [patch] policy for nrpe
Date: Mon, 24 May 2004 10:56:58 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040523214406.GB6147@jmh.mhn.de>
In-Reply-To: <20040523214406.GB6147@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405241056.58596.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 24 May 2004 07:44, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> The attached patch adds policy support for nrpe.
> (nrpe stands for Nagios Remote Plugin Execution and is a client called
> from inetd which performs checks on a client on behalf of a Nagios
> server)

We currently have a netsaint.te in the policy, should we change that to 
nagios.te?  Should we include the nrpe stuff in the main netsaint.te or 
nagios.te file or is it best to keep client and server stuff separate?

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
