Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7BMvo1r022603
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 18:57:50 -0400
Received: from g4t0016.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7BMvoKW013372
	for <selinux@tycho.nsa.gov>; Mon, 11 Aug 2008 22:57:50 GMT
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/7] Labeled networking patches for 2.6.28
Date: Mon, 11 Aug 2008 18:57:42 -0400
References: <20080811212640.22551.17728.stgit@flek.lan>
In-Reply-To: <20080811212640.22551.17728.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808111857.42859.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 11 August 2008 6:23:49 pm Paul Moore wrote:
> [NOTE: in the process of writing the examples below I found a bug in
> the 'netlabelctl cipsov4 del ...' operation, I'm looking into it
> right now but in the meantime only add :) ]

I made some stupid mistakes in netlbl_cipsov4_remove() which should now 
be fixed in the git tree.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
