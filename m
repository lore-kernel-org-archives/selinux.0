Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k962og1o011349
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 22:50:42 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k962nSqJ011920
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 02:49:29 GMT
Date: Thu, 5 Oct 2006 22:50:39 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Eric Paris <eparis@redhat.com>, johnpol@2ka.mipt.ru,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 0/3] Fix for IPsec leakage with SELinux enabled - V.03
In-Reply-To: <45256E25.6020201@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0610052247520.32762@d.namei>
References: <45256E25.6020201@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These patches look ok to me.  I've tested them and applied them to the git 
tree [1].

Stephen, please let me know if you see any problems.


-- 
James Morris
<jmorris@namei.org>


[1] Git - git://git.infradead.org/~jmorris/selinux-2.6.git
Web - http://git.infradead.org/?p=users/jmorris/selinux-2.6.git;a=summary


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
