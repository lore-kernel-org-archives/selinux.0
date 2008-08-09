Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m79Jh233002064
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 15:43:02 -0400
Received: from g5t0006.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m79Jh2Ze018848
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 19:43:02 GMT
From: Paul Moore <paul.moore@hp.com>
To: paulmck@linux.vnet.ibm.com
Subject: Re: [RFC PATCH] netlabel: Replace protocol/NetLabel linking with refrerence counts
Date: Sat, 9 Aug 2008 15:42:28 -0400
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
References: <20080809144322.11314.76039.stgit@flek.lan> <20080809170840.GF8125@linux.vnet.ibm.com>
In-Reply-To: <20080809170840.GF8125@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808091542.28776.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 09 August 2008 1:08:40 pm Paul E. McKenney wrote:
> On Sat, Aug 09, 2008 at 10:43:22AM -0400, Paul Moore wrote:
> > NetLabel has always had a list of backpointers in the CIPSO DOI
> > definition structure which pointed to the NetLabel LSM domain
> > mapping structures which referenced the CIPSO DOI struct.  The
> > rationale for this was that when an administrator removed a CIPSO
> > DOI from the system all of the associated NetLabel LSM domain
> > mappings should be removed as well; a list of backpointers made
> > this a simple operation.
> >
> > Unfortunately, while the backpointers did make the removal easier
> > they were a bit of a mess from an implementation point of view
> > which was making further development difficult.  Since the removal
> > of a CIPSO DOI is a realtively rare event it seems to make sense to
> > remove this backpointer list as the optimization was hurting us
> > more then it was helping.  However, we still need to be able to
> > track when a CIPSO DOI definition is being used so replace the
> > backpointer list with a reference count.  In order to preserve the
> > current functionality of removing the associated LSM domain
> > mappings when a CIPSO DOI is removed we walk the LSM domain mapping
> > table, removing the relevant entries.
>
> Looks good from an RCU viewpoint!

Great, thanks for all your help :)

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
