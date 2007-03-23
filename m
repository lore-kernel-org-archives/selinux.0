Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NGne2C029977
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 12:49:52 -0400
Received: from e35.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NGncU1028745
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 16:49:38 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2NGna1u006158
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 12:49:36 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2NGnZ2H067684
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 10:49:35 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2NGnYZI025798
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 10:49:35 -0600
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
From: Joy Latten <latten@austin.ibm.com>
To: Eric Paris <eparis@parisplace.org>
Cc: James Morris <jmorris@namei.org>, David Miller <davem@davemloft.net>,
        selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        vyekkirala@TrustedCS.com
In-Reply-To: <1174628387.10788.53.camel@localhost.localdomain>
References: <200703221835.l2MIZdDw007850@faith.austin.ibm.com>
	 <20070322.120139.74735307.davem@davemloft.net>
	 <1174598630.3085.285.camel@faith.austin.ibm.com>
	 <Line.LNX.4.64.0703221943110.24461@d.namei>
	 <1174628387.10788.53.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 10:33:11 -0600
Message-Id: <1174667591.3085.308.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 01:39 -0400, Eric Paris wrote:

> 
> In either case though proper auditing needs to be addressed.  I see that
> the first patch from Joy wouldn't audit deletion failures.  It appears
> to me if the check is done per policy then the security hook return code
> needs to be recorded and passed to xfrm_audit_log instead of the hard
> coded 1 result used now.
> 
> Assuming we go with James's double loop what should we be auditing for a
> security hook denial?  Just audit the first policy entry which we tried
> to remove but couldn't and then leave the rest of the auditing in those
> functions the way it is now in case there was no denial, calling
> xfrm_audit_log with a hard coded 1 for the result?
> 
Actually, I thought the original intent of the ipsec auditing was to
just audit changes made to the SAD/SPD databases, not securiy hook
denials, right? 

Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
