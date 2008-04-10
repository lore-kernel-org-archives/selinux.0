Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3ALQC5Y031218
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 17:26:12 -0400
Received: from g4t0016.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3ALQB8I007074
	for <selinux@tycho.nsa.gov>; Thu, 10 Apr 2008 21:26:12 GMT
From: Paul Moore <paul.moore@hp.com>
To: linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] Labeled networking patches for 2.6.26
Date: Thu, 10 Apr 2008 17:25:59 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
References: <20080409204936.26774.55254.stgit@flek.lan>
In-Reply-To: <20080409204936.26774.55254.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200804101725.59604.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a quick follow-up on testing, I've run this for a few hours on two 
Fedora systems with both labeled and unlabeled IPsec in use with SAs 
rekeying every 5 minutes and didn't notice anything evil.

At this point I'd strip the "RFC" from the patchset and ask that they be 
considered for inclusion in 2.6.26 assuming there are no objections.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
