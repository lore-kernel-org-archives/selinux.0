Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6K5rbxh008506
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 01:53:38 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6K5rTFO016944
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 05:53:36 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: david@hardeman.nu
Subject: Re: [refpolicy-patch 02/23] anaconda policy update
Date: Sun, 20 Jul 2008 15:53:20 +1000
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, cpebenito@tresys.com
References: <20080719205002.462190042@hardeman.nu> <20080719210251.406319184@hardeman.nu>
In-Reply-To: <20080719210251.406319184@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807201553.24020.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 20 July 2008 06:50, david@hardeman.nu wrote:
> Anaconda is a RH installation program, RH should know their own program and
> the changes are quite trivial

Might it be better to leave the Anaconda and dpkg policy in the distribution 
trees?  It doesn't seem to provide much benefit to non Red Hat users to have 
Anaconda policy.

Does Red Hat actually do anything useful with the Anaconda policy?  Last time 
I checked the installation was run in permissive mode (there doesn't really 
seem to be a benefit in enforcing mode) so it's not as if anaconda.te is 
needed to permit the install to operation.  Even so there is unconfined_t 
which could be used for an enforcing-mode install (last time I checked it was 
not possible to directly install a Red Hat distribution with strict policy).

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
