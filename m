Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NIsEn1004047
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 14:54:14 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NIsCU1025562
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 18:54:12 GMT
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
From: Eric Paris <eparis@parisplace.org>
To: David Miller <davem@davemloft.net>
Cc: jmorris@namei.org, latten@austin.ibm.com, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org, vyekkirala@TrustedCS.com
In-Reply-To: <20070323.114724.74563713.davem@davemloft.net>
References: <Line.LNX.4.64.0703221943110.24461@d.namei>
	 <1174628387.10788.53.camel@localhost.localdomain>
	 <Line.LNX.4.64.0703231441390.30602@d.namei>
	 <20070323.114724.74563713.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 14:50:31 -0400
Message-Id: <1174675831.10788.79.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 11:47 -0700, David Miller wrote:
> From: James Morris <jmorris@namei.org>
> Date: Fri, 23 Mar 2007 14:46:48 -0400 (EDT)
> 
> > A 'flush' has a semantic implication that all entries will be removed, and 
> > it should be atomic and either succeed or fail at that granularity.
> 
> Correct.

Fair enough, does it matter that we have no way to report failure back
to users who can no longer assume success?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
