Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n811GaBW004719
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 21:16:36 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n811Hp47029251
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 01:17:52 GMT
Date: Tue, 1 Sep 2009 11:16:34 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/2] New LSM hooks for the TUN driver
In-Reply-To: <20090828220400.3900.64377.stgit@flek.lan>
Message-ID: <alpine.LRH.2.00.0909011116180.23172@tundra.namei.org>
References: <20090828220400.3900.64377.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Aug 2009, Paul Moore wrote:

> This is the third, and hopefully final, version of the new LSM TUN hooks.  This
> version incorporates all outstanding feedback as well as my sign-off and ACKs
> from both Eric and Serge (see patches).  However, the patches are still missing
> an ACK from netdev - I haven't heard any objections but I'm not certain anyone
> from netdev has really taken a look yet.



Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
