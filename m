Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m859CnsD025091
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 05:12:49 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m859Cmfb004307
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 09:12:49 GMT
Date: Fri, 5 Sep 2008 19:12:47 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v4 12/14] netlabel: Changes to the NetLabel security
 attributes to allow LSMs to pass full contexts
In-Reply-To: <20080903005013.15669.42041.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0809051912350.2526@tundra.namei.org>
References: <20080903003647.15669.45349.stgit@flek.lan> <20080903005013.15669.42041.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Sep 2008, Paul Moore wrote:

> This patch provides support for including the LSM's secid in addition to
> the LSM's MLS information in the NetLabel security attributes structure.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
> 
>  include/net/netlabel.h         |    2 +-
>  security/selinux/ss/services.c |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
