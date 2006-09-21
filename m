Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LI8JYL021404
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 14:08:19 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LI7J9P029419
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 18:07:20 GMT
Date: Thu, 21 Sep 2006 14:08:14 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org, sds@epoch.ncsc.mil,
        jmorris@redhat.com, tgraf@suug.ch
Subject: Re: [PATCH 1/6] NetLabel: correct improper handling of non-NetLabel
 peer contexts
In-Reply-To: <20060921170335.013411000@hp.com>
Message-ID: <Pine.LNX.4.64.0609211406030.7534@d.namei>
References: <20060921165703.251871000@hp.com> <20060921170335.013411000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 21 Sep 2006, paul.moore@hp.com wrote:

> Fix a problem where NetLabel would always set the value of 
> sk_security_struct->peer_sid in selinux_netlbl_sock_graft() to the context of
> the socket, causing problems when users would query the context of the
> connection.  This patch fixes this so that the value in
> sk_security_struct->peer_sid is only set when the connection is NetLabel based,
> otherwise the value is untouched.

I'll let Thomas comment on the Netlink changes, as he's been working with 
you on them.

These changes otherwise seem ok.  How much testing has this had with and 
without Netlabel enabled?



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
