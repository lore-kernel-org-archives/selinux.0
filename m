Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93Gg0ji017643
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 12:42:00 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93GfOO7005777
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 16:41:25 GMT
Date: Tue, 3 Oct 2006 12:41:57 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Linda Knippers <linda.knippers@hp.com>
cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com, paul.moore@hp.com, vyekkirala@TrustedCS.com
Subject: Re: RHEL5 Kernel with labeled networking
In-Reply-To: <45228EAA.5050105@hp.com>
Message-ID: <Pine.LNX.4.64.0610031240430.23290@d.namei>
References: <1159834998.28144.115.camel@localhost.localdomain>
 <452282F2.1000107@hp.com> <1159890356.28144.136.camel@localhost.localdomain>
 <Pine.LNX.4.64.0610031207260.21081@d.namei> <45228EAA.5050105@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Oct 2006, Linda Knippers wrote:

> Dumb question....should compat_net be "1" by default?

Ideally, no, the new secmark controls were posted in May and everyone 
should be using them.  I only added the compat_net option to help 
with transition, and it could disappear at any time.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
