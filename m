Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBFKecIi020965
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2004 15:40:39 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBFKcuxm002510
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2004 20:38:56 GMT
Subject: Re: patch: add policy for gpg helpers
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20041209174633.GA8179@jmh.mhn.de>
References: <20041209174633.GA8179@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1103143388.31218.33.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 15 Dec 2004 15:43:08 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Thu, 2004-12-09 at 12:46, Thomas Bleher wrote:
> This patch adds support for gpg-helpers. These can be used to
> automatically fetch gpg keys over the network. Properly configured,
> $1_gpg_t doesn't need network access anymore. Unfortunately, eg Debian
> doesn't yet include all the necessary helpers, so I left the
> can_network() for $1_gpg_t in for now.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
