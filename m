Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NH3gXw030780
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 13:03:42 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NH3cU1001796
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 17:03:39 GMT
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
From: Eric Paris <eparis@parisplace.org>
To: Joy Latten <latten@austin.ibm.com>
Cc: James Morris <jmorris@namei.org>, David Miller <davem@davemloft.net>,
        selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        vyekkirala@TrustedCS.com
In-Reply-To: <1174667591.3085.308.camel@faith.austin.ibm.com>
References: <200703221835.l2MIZdDw007850@faith.austin.ibm.com>
	 <20070322.120139.74735307.davem@davemloft.net>
	 <1174598630.3085.285.camel@faith.austin.ibm.com>
	 <Line.LNX.4.64.0703221943110.24461@d.namei>
	 <1174628387.10788.53.camel@localhost.localdomain>
	 <1174667591.3085.308.camel@faith.austin.ibm.com>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 12:59:15 -0400
Message-Id: <1174669155.10788.60.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 10:33 -0600, Joy Latten wrote:
> On Fri, 2007-03-23 at 01:39 -0400, Eric Paris wrote:
> 
> > 
> > In either case though proper auditing needs to be addressed.  I see that
> > the first patch from Joy wouldn't audit deletion failures.  It appears
> > to me if the check is done per policy then the security hook return code
> > needs to be recorded and passed to xfrm_audit_log instead of the hard
> > coded 1 result used now.
> > 
> > Assuming we go with James's double loop what should we be auditing for a
> > security hook denial?  Just audit the first policy entry which we tried
> > to remove but couldn't and then leave the rest of the auditing in those
> > functions the way it is now in case there was no denial, calling
> > xfrm_audit_log with a hard coded 1 for the result?
> > 
> Actually, I thought the original intent of the ipsec auditing was to
> just audit changes made to the SAD/SPD databases, not securiy hook
> denials, right? 

Then what is the point of the 'result' field that we capture and log in
xfrm_audit_log if the only things you care to audit are successful
changes to the databases?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
