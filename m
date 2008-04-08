Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m38L24Vk029107
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 17:02:04 -0400
Received: from g4t0015.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m38L23qY017308
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2008 21:02:03 GMT
From: Paul Moore <paul.moore@hp.com>
To: hadi@cyberus.ca
Subject: Re: [RFC PATCH 2/2] LSM: Make the Labeled IPsec hooks more stack friendly
Date: Tue, 8 Apr 2008 17:01:48 -0400
Cc: linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
References: <20080407231143.8087.77531.stgit@flek.lan> <20080407231635.8087.42161.stgit@flek.lan> <1207650292.30750.43.camel@localhost>
In-Reply-To: <1207650292.30750.43.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804081701.48667.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 08 April 2008 6:24:52 am jamal wrote:
> On Mon, 2008-07-04 at 19:16 -0400, Paul Moore wrote:
> > The xfrm_get_policy() and xfrm_add_pol_expire() put some rather
> > large structs on the stack to work around the LSM API.
>
> You missed a spot which applies similar logic:
> net/key/af_key.c::pfkey_spddelete()

Thanks, I'll check all the pfkey bits to see if anything else jumps out 
too ... and figure out why my config wasn't building pfkey :)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
