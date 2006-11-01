Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kA1HQB2f026513
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 12:26:11 -0500
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kA1HOWdL016787
	for <selinux@tycho.nsa.gov>; Wed, 1 Nov 2006 17:24:33 GMT
Date: Wed, 1 Nov 2006 12:26:07 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, jbrindle@tresys.com,
        selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>,
        gcwilson@us.ibm.com
Subject: Re: SELinux Networking Enhancements
In-Reply-To: <4548C6D7.1050709@hp.com>
Message-ID: <Pine.LNX.4.64.0611011225520.7222@d.namei>
References: <000601c6fd2e$ceea6ab0$cc0a010a@tcssec.com>
 <Pine.LNX.4.64.0610312242270.27961@d.namei> <4548B792.7070604@hp.com>
 <Pine.LNX.4.64.0611011059190.6253@d.namei> <4548C6D7.1050709@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Nov 2006, Paul Moore wrote:

> I got the impression that Venkat was intending this to work for external labels
> (both XFRM and NetLabel) as well as internal labels (SECMARK).  I would be a lot
> happier if the name didn't limit it to just XFRM labeling.

If you want a secmark match, make it a separate module.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
