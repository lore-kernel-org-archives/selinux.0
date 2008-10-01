Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9191kfX009961
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 05:01:46 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9190gHK016535
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 09:00:42 GMT
Date: Wed, 1 Oct 2008 19:01:43 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 08/16] netlabel: Replace protocol/NetLabel linking
 with refrerence counts
In-Reply-To: <20080916125638.17132.26966.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0810011901140.6732@tundra.namei.org>
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125638.17132.26966.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Sep 2008, Paul Moore wrote:

> NetLabel has always had a list of backpointers in the CIPSO DOI definition
> structure which pointed to the NetLabel LSM domain mapping structures which
> referenced the CIPSO DOI struct.  The rationale for this was that when an
> administrator removed a CIPSO DOI from the system all of the associated
> NetLabel LSM domain mappings should be removed as well; a list of
> backpointers made this a simple operation.
> 
> Unfortunately, while the backpointers did make the removal easier they were
> a bit of a mess from an implementation point of view which was making
> further development difficult.  Since the removal of a CIPSO DOI is a
> realtively rare event it seems to make sense to remove this backpointer
> list as the optimization was hurting us more then it was helping.  However,
> we still need to be able to track when a CIPSO DOI definition is being used
> so replace the backpointer list with a reference count.  In order to
> preserve the current functionality of removing the associated LSM domain
> mappings when a CIPSO DOI is removed we walk the LSM domain mapping table,
> removing the relevant entries.
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
