Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA10321
	for <selinux@tycho.nsa.gov>; Fri, 4 Oct 2002 17:07:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA04187
	for <selinux@tycho.nsa.gov>; Fri, 4 Oct 2002 21:06:01 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA04183 for <selinux@tycho.nsa.gov>; Fri, 4 Oct 2002 21:05:59 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: RH8 policy support
Date: Fri, 4 Oct 2002 23:07:35 +0200
Cc: selinux@tycho.nsa.gov
References: <20021004205040.26115.qmail@web40020.mail.yahoo.com>
In-Reply-To: <20021004205040.26115.qmail@web40020.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <200210042307.35349.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 4 Oct 2002 22:50, Brad Chapman wrote:
> Does your policy work well (or mostly well) on RH8? I'm installing it soon

My policy is little different from that which is in the Sourceforge CVS tree.

> and would like to make your policy work with a minimum of fuss (i.e. it
> takes less than three hours to edit the policy to make it work ;). Do you
> know of any problems so far between your policy and RH8?

I don't know.  I have not had any need to install it on Red Hat.

To get SE Linux running on Red Hat as well as it does on Debian the following 
needs to be done:

Wrappers for rpm and related commands to run them in system_u:system_r .

Support for relabelling files after installing a new RPM package.

Policy to make the install scripts start daemons in the correct domain.

Testing all this on standard operation of Red Hat machines to find differences 
from Debian and write policy and patches to programs to match.


Probably about 3 months work should do it.

As for getting basic functionality working, I don't know of anything in 
particular that'll stop it working, but RH 8 has enough new things that 
there's certain to be some relevant changes, probably more than 3 hours work 
will be required.  But don't be deterred!  This is fun!

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
