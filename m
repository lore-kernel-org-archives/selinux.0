Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9ALjwxW002295
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 17:45:58 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9ALjwxu013359
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2008 21:45:58 GMT
Date: Sat, 11 Oct 2008 08:45:56 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 01/17] netlabel: Fix some sparse warnings
In-Reply-To: <20081006191948.15686.24567.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0810110845340.2822@tundra.namei.org>
References: <20081006191516.15686.80823.stgit@flek.lan> <20081006191948.15686.24567.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 6 Oct 2008, Paul Moore wrote:

> Fix a few sparse warnings.  One dealt with a RCU lock being held on error,
> another dealt with an improper type caused by a signed/unsigned mixup while
> the rest appeared to be caused by using rcu_dereference() in a
> list_for_each_entry_rcu() call.  The latter probably isn't a big deal, but
> I derive a certain pleasure from knowing that the net/netlabel is nice and
> clean.
> 
> Thanks to James Morris for pointing out the issues and demonstrating how
> to run sparse.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Reviewed-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
