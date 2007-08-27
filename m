Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RCxFpI032465
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 08:59:15 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7RCxDnP022692
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 12:59:14 GMT
Message-ID: <D709A20F2164C84E8B7014B0301F5EF8521174@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <method@manicmethod.com>, casey@schaufler-ca.com
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        James Morris
	 <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Mon, 27 Aug 2007 08:57:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > It makes me uncomfortable to hear you say that XFRM is 
> SELinux specific
> > and that it needs to be integrated with NetLabel, which 
> currently isn't.
> > I know that Smack isn't upstream yet. Nonetheless, I would 
> hate to see
> > underlying mechanisms that currently provide useful 
> facilities become
> > SELinux specific.
> >   
> 
> Joy will know better but I don't think there is anything 
> really SELinux 
> specific about XRFM. As far as the racoon support goes it just 
> serializes and sends over a string context, algorithm and 
> DOI.

This is correct.

> The LSM 
> would responsible for verifying the context when it is set. One thing 
> you'd have to figure out as an LSM writer is how to reconcile 
> multiple 
> incoming labels, much like we are trying to do right now. There are 
> already function pointers in the security_ops struct for 
> managing xfrm 
> security data, it shouldn't be any problem for you to use them.

Right.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
