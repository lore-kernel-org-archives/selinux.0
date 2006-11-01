Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA1G0gIB023586
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 11:00:42 -0500
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA1FxqOY008320
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 15:59:53 GMT
Date: Wed, 1 Nov 2006 11:00:38 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: Re: SELinux Networking Enhancements
In-Reply-To: <4548B792.7070604@hp.com>
Message-ID: <Pine.LNX.4.64.0611011059190.6253@d.namei>
References: <000601c6fd2e$ceea6ab0$cc0a010a@tcssec.com>
 <Pine.LNX.4.64.0610312242270.27961@d.namei> <4548B792.7070604@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Nov 2006, Paul Moore wrote:

> > Ok, so, there'd be an iptables match which looked up the security context 
> > on the SA the packet arrives/departs on?  Sounds like it could work.  
> > Perhaps call it xfrmlabel ?
> 
> What we name it probably isn't that important, but I sorta prefer Venkat's
> original suggestion of secfilter (or secidfilter, or <generic security
> token>filter) since it sounds like this new component would be strictly for
> filtering and not labeling.

Well, it's matching labels on xfrms.  The filtering concept is implicit in 
it being an iptables match, and secid/sec is vague.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
