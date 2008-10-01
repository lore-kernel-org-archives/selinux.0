Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m91GYd6O010312
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 12:34:39 -0400
Received: from g5t0008.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m91GXZYT004684
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 16:33:35 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v6 01/16] selinux: Cleanup the NetLabel glue code
Date: Wed, 1 Oct 2008 12:34:36 -0400
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125554.17132.61538.stgit@flek.lan> <alpine.LRH.1.10.0810011135140.5277@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810011135140.5277@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810011234.37020.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 September 2008 9:35:46 pm James Morris wrote:
> On Tue, 16 Sep 2008, Paul Moore wrote:
> > We were doing a lot of extra work in selinux_netlbl_sock_graft()
> > what wasn't necessary so this patch removes that code.  It also
> > removes the redundant second argument to
> > selinux_netlbl_sock_setsid() which allows us to simplify a few
> > other functions.
> >
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
>
> Nice cleanup :-)
>
> Acked-by: James Morris <jmorris@namei.org>

Thanks, every once in a while I get lucky ;)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
