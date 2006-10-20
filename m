Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9KNP381027772
	for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2006 19:25:03 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9KNOJfe026673
	for <selinux@tycho.nsa.gov>; Fri, 20 Oct 2006 23:24:19 GMT
Date: Fri, 20 Oct 2006 19:24:58 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: "'jbrindle@tresys.com '" <jbrindle@tresys.com>,
        "'selinux@tycho.nsa.gov '" <selinux@tycho.nsa.gov>,
        "'sds@tycho.nsa.gov '" <sds@tycho.nsa.gov>
Subject: RE: SELinux Networking Enhancements
In-Reply-To: <36282A1733C57546BE392885C0618592238484@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0610201924040.9153@d.namei>
References: <36282A1733C57546BE392885C0618592238484@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Oct 2006, Venkat Yekkirala wrote:

> Venkat's response:
> Hi James, can you please tell me exactly what rules (and only those)
> that one should be able to specify in the forwarding case in the
> following example:
> 
> I have a machine 192.168.16.10 that needs to be able to do web-browsing
> only, via the router.

You mean rules on thr router to to enforce MAC between two other systems?

I think this is currently out of scope.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
