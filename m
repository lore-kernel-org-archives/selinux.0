Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BMK7MC014772
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 18:20:07 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5BMK5Uh020718
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 22:20:05 GMT
Date: Mon, 11 Jun 2007 18:20:02 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: "Serge E. Hallyn" <serue@us.ibm.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
In-Reply-To: <620792.60154.qm@web36608.mail.mud.yahoo.com>
Message-ID: <Line.LNX.4.64.0706111810210.1336@d.namei>
References: <620792.60154.qm@web36608.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 11 Jun 2007, Casey Schaufler wrote:

> and dealing with interactions with them. My only concern is that you
> seem to be sneaking around the "additional restrictions" LSM model,
> with the justification being that the bit you're taking authority over
> is also an LSM module.

SELinux itself stacks capabilities as a secondary module, and thus already 
has full authority over the LSM in the coarse sense of whether it is 
actually loaded or not.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
