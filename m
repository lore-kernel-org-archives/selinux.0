Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MJmMkx032191
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:48:22 -0400
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MJlMEW027679
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 19:47:22 GMT
Date: Fri, 22 Sep 2006 15:48:03 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: Re: Labeled networking packets
In-Reply-To: <45140058.60902@hp.com>
Message-ID: <Pine.LNX.4.64.0609221547330.9713@d.namei>
References: <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
  <1158929251.7748.224.camel@moss-spartans.epoch.ncsc.mil>
 <1158930147.17541.10.camel@twoface.columbia.tresys.com>  <4513F790.9020603@hp.com>
 <1158937085.17541.27.camel@twoface.columbia.tresys.com> <45140058.60902@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Sep 2006, Paul Moore wrote:

> Honestly, I can't think of why you would want to use both SA and
> NetLabel labeling on the same connection - that's just stupid :)
> However, I can see users wanting to have then active on the same host,
> imagine a SELinux box talking to both legacy Trusted OSs and other
> SELinux boxes - this is the case I was talking about earlier.

Agreed.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
