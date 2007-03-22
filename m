Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2N07G7P006680
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 20:07:16 -0400
Received: from e31.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2N07EEE007547
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 00:07:14 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2N07EMk026857
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 20:07:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2N07E4C046844
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 18:07:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2N07DaM031715
	for <selinux@tycho.nsa.gov>; Thu, 22 Mar 2007 18:07:13 -0600
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
From: Joy Latten <latten@austin.ibm.com>
To: James Morris <jmorris@namei.org>
Cc: David Miller <davem@davemloft.net>, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org, vyekkirala@TrustedCS.com
In-Reply-To: <Line.LNX.4.64.0703221943110.24461@d.namei>
References: <200703221835.l2MIZdDw007850@faith.austin.ibm.com>
	 <20070322.120139.74735307.davem@davemloft.net>
	 <1174598630.3085.285.camel@faith.austin.ibm.com>
	 <Line.LNX.4.64.0703221943110.24461@d.namei>
Content-Type: text/plain
Date: Thu, 22 Mar 2007 17:50:51 -0600
Message-Id: <1174607451.3085.290.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-22 at 19:49 -0400, James Morris wrote:
> On Thu, 22 Mar 2007, Joy Latten wrote:
> 
> > > I would look at this patch differently if there were some
> > > security level key being checked for a match here, which is
> > > an input key to the flush, but that is not what is happening
> > > here as the object is being looked at by itself.
> > 
> > Yes, I understand what you are saying.
> > I was concerned about having to check each entry
> > to flush database.
> > 
> > I did this patch because we check for authorization
> > when deleting single specified entries from the SAD/SPD. It
> > seem like a hole to me that we check for this, but that same
> > user/process can delete the entire database with no checks.
> 
> Indeed.  Removing an entry is modifying MAC policy, which requires 
> appropriate authorization.
> 
> The security label is encapsulated with the object, which is why it's 
> passed to the security layer.
> 
> Perhaps a better semantic would be to fail the entire flush operation if 
> one of the security checks failed.  e.g. loop through for permissions 
> first, then if all ok, loop through for deletion.
> 
Ok, will code this up and test it if there are no objections.

Joy

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
