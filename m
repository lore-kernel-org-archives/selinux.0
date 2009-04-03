Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n33IJJBw022325
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 14:19:19 -0400
Received: from e32.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n33IJIfC004687
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 18:19:19 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n33IGL7r019524
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 12:16:21 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n33IJEMu204526
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 12:19:14 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n33IJDMu023068
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 12:19:14 -0600
Subject: Re: [nfsv4] [Labeled-nfs] New MAC label support Internet
	Draft	posted to IETF website
From: Joy Latten <latten@austin.ibm.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Nicolas Williams <Nicolas.Williams@sun.com>,
        Jarrett Lu <Jarrett.Lu@sun.com>, labeled-nfs@linux-nfs.org,
        selinux@tycho.nsa.gov, nfs-discuss@opensolaris.org, nfsv4@ietf.org
In-Reply-To: <200904021835.51068.paul.moore@hp.com>
References: <1232651815.24537.15.camel@moss-terrapins.epoch.ncsc.mil>
	 <200904011246.33436.paul.moore@hp.com> <20090402152423.GL1500@Sun.COM>
	 <200904021835.51068.paul.moore@hp.com>
Content-Type: text/plain
Date: Fri, 03 Apr 2009 13:08:43 -0500
Message-Id: <1238782123.1876.35.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2009-04-02 at 18:35 -0400, Paul Moore wrote:
> On Thursday 02 April 2009 11:24:24 am Nicolas Williams wrote:
> > On Wed, Apr 01, 2009 at 12:46:33PM -0400, Paul Moore wrote:
> > > My only comment was that figuring out how to transfer information over
> > > the network isn't really that important yet.  Reading through the thread
> > > I don't think there is general agreement on what we even need to send to
> > > enable proper label translation/encoding/etc.
> >
> > I think we all agree that a client and server have to agree on the
> > meaning of any given DOI number so that they can properly encode labels.
> >
> > In order to interop this means we need a common label encoding for any
> > given DOI.
> >
> > I think we agree on that, no?
> 
> Yep.  Although I don't think we should try to force a single label encoding 
> for all DOIs (couldn't tell from your reply how far you wanted to take this); 
> using some combination of DOI+<opaque label> seems reasonable.
> 
> > That leaves this problem: how to ensure that the client and server do
> > actually agree as to a given DOI's label encodings?
> >
> > That's a big problem that to date has been solved by out-of-band
> > mechanisms.  That solution leaves interoperability in a lurch: it's up
> > to vendors to cooperate to obtain a common security policy for use on
> > the wire.
> 
> Well, I think the trick is you define a security policy and label format in 
> the DOI and then leave it up to the various implementations to handle the 
> necessary internalization and import/export of the DOI.  Perhaps we are in a 
> six-of-one/half-dozen-of-the-other discussion right now.

I am just getting to read this thread. I find it interesting because the
labeled ipsec draft expresses DOI + opaque string in similar manner as
the labeled nfsv4 draft. 

Upon reading the thread, I agree with you, define a security policy and 
label format in the DOI and leave it up to implementation to handle
internalization.

I had always assumed the DOI would be handled by IANA and when a request
was made for a new DOI number, a definition would be included. 
For example, DOI #5: mapping between MAC implementation A version xx,
label policy B AND MAC implementation G version xx, label policy R.
Or maybe something like, DOI #6: SElinux version XX, using MCS.

The sys admin would determine based on local MAC, mappings, etc...,
which DOI to use/communicate. 

This perhaps sounds somewhat primitive, but I am still processing all
the info communicated in the thread. :-)

regards,
Joy 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
