Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6S4HZjU011844
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 00:17:35 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6S4HWUP017329
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 04:17:33 GMT
Date: Fri, 28 Jul 2006 00:17:31 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Valdis.Kletnieks@vt.edu
cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov, jbrindle@tresys.com
Subject: Re: [PATCH] SELinux: new /proc/self/attr/ipccreate for expliciteipc
 object labeling
In-Reply-To: <200607272116.k6RLGrFC026797@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.64.0607280016340.13981@d.namei>
References: <6FE441CD9F0C0C479F2D88F959B015882989A9@exchange.columbia.tresys.com>
            <1154019529.5028.19.camel@localhost.localdomain>
 <200607272116.k6RLGrFC026797@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jul 2006, Valdis.Kletnieks@vt.edu wrote:

> > A note of interest, this only leaves 1 bit in the process security
> > class.  I don't currently have any plans to use any more, but it is
> > something to remember.
> 
> Does anybody have a good plan for what to do when we run out?

Probably create another process class and abstract it so policy just sees 
a single class.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
