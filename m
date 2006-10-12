Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CMZM15011492
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 18:35:22 -0400
Received: from mail8.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9CMY42c018063
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 22:34:04 GMT
Date: Thu, 12 Oct 2006 18:35:18 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: paul.moore@hp.com
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, eparis@redhat.com
Subject: Re: [PATCH 0/3] Collection of small NetLabel bugfixes
In-Reply-To: <20061011231046.825517000@hp.com>
Message-ID: <Pine.LNX.4.64.0610121834540.2050@d.namei>
References: <20061011231046.825517000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Oct 2006, paul.moore@hp.com wrote:

> When doing some more testing today I ran into a few bugs, this patchset
> addresses those bugs.  This patchset is backed against today's net-2.6 git
> tree.
> 
> Please apply these patches for 2.6.19, thanks.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-net-2.6.git


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
