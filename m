Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBG1JRJC029281
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 20:19:27 -0500
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBG1K0kq003881
	for <selinux@tycho.nsa.gov>; Sat, 16 Dec 2006 01:20:00 GMT
Date: Fri, 15 Dec 2006 20:19:56 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: paul.moore@hp.com
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] A bugfix patchset for NetLabel
In-Reply-To: <20061215214926.018950000@hp.com>
Message-ID: <XMMS.LNX.4.64.0612151840370.26929@d.namei>
References: <20061215214926.018950000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 15 Dec 2006, paul.moore@hp.com wrote:

> This patch set fixes two bugs that were found recently when adding new CIPSOv4
> DOI definitions.  These patches are pretty small and have been tested by a few
> different people on several different platforms.

Applied to git://git.infradead.org/~jmorris/selinux-2.6#fixes

> Please apply these for 2.6.20 and they should probably be pushed to the 2.6.19
> stable tree as well; is there anything special I need to do for that?

I'm not sure that they qualify.

The first is a privileged operation, right?

For the second, what are the implications of mapping to zero?


Also review Documentation/stable_kernel_rules.txt.





-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
