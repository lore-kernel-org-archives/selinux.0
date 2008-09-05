Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m858tnBN021285
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 04:55:49 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m858tADN002143
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 08:55:11 GMT
Date: Fri, 5 Sep 2008 18:55:48 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v4 04/14] selinux: Fix missing calls to
 netlbl_skbuff_err()
In-Reply-To: <20080903004908.15669.36176.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0809051855300.2526@tundra.namei.org>
References: <20080903003647.15669.45349.stgit@flek.lan> <20080903004908.15669.36176.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2 Sep 2008, Paul Moore wrote:

> At some point I think I messed up and dropped the calls to netlbl_skbuff_err()
> which are necessary for CIPSO to send error notifications to remote systems.
> This patch re-introduces the error handling calls into the SELinux code.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
> 
>  include/net/netlabel.h              |    6 ++++--
>  net/netlabel/netlabel_kapi.c        |    5 +++--
>  security/selinux/hooks.c            |   19 +++++++++++++++----
>  security/selinux/include/netlabel.h |    9 +++++++++
>  security/selinux/netlabel.c         |   20 +++++++++++++++++++-
>  5 files changed, 50 insertions(+), 9 deletions(-)
> 

Acked-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
