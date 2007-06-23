Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5NKk1Dl010397
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 16:46:01 -0400
Received: from mail4.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5NKjxoq015410
	for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2007 20:46:00 GMT
Date: Sat, 23 Jun 2007 16:45:57 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Casey Schaufler <casey@schaufler-ca.com>
cc: "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>, nfsv4@linux-nfs.org,
        Karl MacMillan <kmacmill@redhat.com>,
        "Matthew N. Dodd" <Matthew.Dodd@sparta.com>,
        Chris Vance <Christopher.Vance@sparta.com>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC] Security Enhanced NFS (SENFS) Requirements - draft 05
In-Reply-To: <417775.99905.qm@web36607.mail.mud.yahoo.com>
Message-ID: <Line.LNX.4.64.0706231622470.13964@localhost.localdomain>
References: <417775.99905.qm@web36607.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 23 Jun 2007, Casey Schaufler wrote:

> I heartily recommend seperating the overall effort into three parts:
> 
> 1. transportation and storage of general extended attributes.
> 2. protection and integrity of the information in #1.
> 3. translation and/or mutual policy enforcement negotiations.
> 
> For step 1 I have passed along a worked example.
> For step 2 call to 1-800-GOTCRYPTO.

NFSv4 security is based upon security at the RPC layer, and in practice 
will commonly utilize RPCSEC_GSS.  It would not be impossible to use 
labeled IPSec, but it would not be acceptable as a general solution.  

>From a user perspective, a labeled NFS mount should essentially "just 
work" as it would for an unlabeled mount with say, kerberos security, and 
not require external IPsec configuration.

Note that further modifications would still need to be made to the 
protocol beyond step 1.  As outlined, several aspects of security state 
need to be conveyed over the network and managed, and the labels on files 
are just one such aspect.  Breaking this layer out is likely how we arrive 
at Paul Moore's labeled NFS (vs. SELinux specific).


> For step 3 you'll most likely want a framework so that machines
> with different SELinux policy files or other system differences
> (US DoD Secret is not the same as US DoE Secret) can figure out
> among themselves who gets to decide on a given access. That, or
> a mechanism for translating the attributes as they pass between
> machines. Or both.

Indeed.

> 
> > > Btw, I will be in Ottawa next week.  Perhaps it might be worth organizing 
> > > a lunch or similar for people who are there and interested in discussing 
> > > this.
> > 
> > I'd be interested.--b.
> 
> Can't make it (again) this year.
> 
> 
> Casey Schaufler
> casey@schaufler-ca.com
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
