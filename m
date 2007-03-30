Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UK9sW9001818
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 16:09:54 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UK9rnf005511
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 20:09:53 GMT
To: bug-coreutils@gnu.org
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux for upstream coreutils, finally (RFC: does mkdir need -Z?)
From: Jim Meyering <jim@meyering.net>
In-Reply-To: <87tzw3x9mo.fsf@rho.meyering.net> (Jim Meyering's message of "Fri\, 30 Mar 2007 13\:18\:23 +0200")
References: <87tzw3x9mo.fsf@rho.meyering.net>
Date: Fri, 30 Mar 2007 22:09:52 +0200
Message-ID: <87k5wywl0v.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jim Meyering <jim@meyering.net> wrote:
> I've merged the SELinux changes onto the trunk.

In case you're interested in trying it out,
here's a snapshot including the new SELinux bits:

  http://meyering.net/cu/coreutils-6.9+.tar.gz
  http://meyering.net/cu/coreutils-6.9+.tar.gz.sig

aka

  http://meyering.net/cu/coreutils-6.9+-ss-2007-03-30.20.07.11+0.tar.gz
  http://meyering.net/cu/coreutils-6.9+-ss-2007-03-30.20.07.11+0.tar.gz.sig

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
