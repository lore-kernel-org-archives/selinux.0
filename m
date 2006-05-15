Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4F6gxQU010896
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 02:42:59 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4F6gvEw028164
	for <selinux@tycho.nsa.gov>; Mon, 15 May 2006 06:42:58 GMT
Date: Mon, 15 May 2006 02:42:55 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Patrick McHardy <kaber@trash.net>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        netfilter-devel@lists.netfilter.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@tresys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: [RFC] SECMARK 1.1
In-Reply-To: <Pine.LNX.4.64.0605150236270.1824@d.namei>
Message-ID: <Pine.LNX.4.64.0605150242440.1900@d.namei>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei>
 <Pine.LNX.4.64.0605140133560.5506@d.namei> <446778F0.6000705@trash.net>
 <Pine.LNX.4.64.0605150004590.645@d.namei> <446811D3.5080905@trash.net>
 <Pine.LNX.4.64.0605150153590.1275@d.namei> <446819FE.8050300@trash.net>
 <Pine.LNX.4.64.0605150221000.1275@d.namei> <44681F0F.9030601@trash.net>
 <Pine.LNX.4.64.0605150236270.1824@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 15 May 2006, James Morris wrote:

> 
> Doh.  It should be try_module_get().  Sound ok?

Of course, I mean request_module().


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
