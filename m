Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m91GsrXV014290
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 12:54:53 -0400
Received: from g5t0006.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m91GrnYT010068
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 16:53:49 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v6 16/16] netlabel: Add configuration support for local labeling
Date: Wed, 1 Oct 2008 12:54:50 -0400
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125737.17132.50669.stgit@flek.lan> <alpine.LRH.1.10.0810012011050.6732@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810012011050.6732@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810011254.50845.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 October 2008 6:13:39 am James Morris wrote:
> On Tue, 16 Sep 2008, Paul Moore wrote:
> > Add the necessary NetLabel support for the new CIPSO mapping,
> > CIPSO_V4_MAP_LOCAL, which allows full LSM label/context support.
>
> Now, CIPSO is useful :-)

 :-P

I told you guys I'd make this compelling, I just needed a 
<cough>few</cough> years :)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
