Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8598Sli024277
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 05:08:28 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8598Sfb003149
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 09:08:28 GMT
Date: Fri, 5 Sep 2008 19:08:17 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v4 10/14] selinux: Set socket NetLabel based on
 connection endpoint
In-Reply-To: <20080903004956.15669.8029.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0809051908020.2526@tundra.namei.org>
References: <20080903003647.15669.45349.stgit@flek.lan> <20080903004956.15669.8029.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Sep 2008, Paul Moore wrote:

> Previous work enabled the use of address based NetLabel selectors, which while
> highly useful, brought the potential for additional per-packet overhead when
> used.  This patch attempts to solve that by applying NetLabel socket labels
> when sockets are connect()'d.  This should alleviate the per-packet NetLabel
> labeling for all connected sockets (yes, it even works for connected DGRAM
> sockets).
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
> 
>  include/net/cipso_ipv4.h            |    5 ++
>  include/net/netlabel.h              |   13 ++++++
>  net/ipv4/cipso_ipv4.c               |   47 +++++++++++++++++++++
>  net/netlabel/netlabel_kapi.c        |   77 +++++++++++++++++++++++++++++++++++
>  security/selinux/hooks.c            |    4 +-
>  security/selinux/include/netlabel.h |    8 ++++
>  security/selinux/include/objsec.h   |    3 +
>  security/selinux/netlabel.c         |   48 +++++++++++++++++++++-
>  8 files changed, 201 insertions(+), 4 deletions(-)

Acked-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
