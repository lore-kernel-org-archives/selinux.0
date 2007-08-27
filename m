Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RD2nsE032740
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 09:02:49 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7RD2laM003186
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 13:02:47 GMT
Message-ID: <D709A20F2164C84E8B7014B0301F5EF8521178@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, casey@schaufler-ca.com
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley
	 <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris
	 <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Mon, 27 Aug 2007 09:02:32 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> 
> Actually, after reading Josh's mail I'm now thinking 
> "netfilter label" is 
> probably a better choice.  After all, the bikeshed will need 
> to be repainted 
> in a few years ... ;)

I like "netfilter label" as well (I take it most admins know what
netfilter is; otherwise firewall label?)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
