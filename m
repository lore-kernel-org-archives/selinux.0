Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9A0VnJh026172
	for <selinux@tycho.nsa.gov>; Sun, 9 Oct 2011 20:31:49 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p9A0VmpA022046
	for <selinux@tycho.nsa.gov>; Mon, 10 Oct 2011 00:31:48 GMT
Date: Mon, 10 Oct 2011 11:31:39 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <pmoore@redhat.com>
cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] bluetooth: Properly clone LSM attributes to newly created
 child connections
In-Reply-To: <20111007194059.12345.13398.stgit@sifl>
Message-ID: <alpine.LRH.2.00.1110101131050.16955@tundra.namei.org>
References: <20111007194059.12345.13398.stgit@sifl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 7 Oct 2011, Paul Moore wrote:

> Reported-by: James M. Cape <jcape@ignore-your.tv>
> Signed-off-by: Paul Moore <pmoore@redhat.com>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
