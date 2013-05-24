Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4OIPXVN027287
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2013 14:25:33 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4OIPXMi019896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 24 May 2013 14:25:34 -0400
From: Paul Moore <pmoore@redhat.com>
To: eparis@redhat.com
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH v3] selinux: fix problems in netnode when BUG() is compiled out
Date: Fri, 24 May 2013 14:25:32 -0400
Message-ID: <1527561.BHgFlbIGtA@sifl>
In-Reply-To: <1854129.fLaNtYFx1j@sifl>
References: <20130404144600.6650.16381.stgit@localhost> <1854129.fLaNtYFx1j@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, April 29, 2013 11:09:47 AM Paul Moore wrote:
> On Thursday, April 04, 2013 10:46:00 AM Paul Moore wrote:
> > When the BUG() macro is disabled at compile time it can cause some
> > problems in the SELinux netnode code: invalid return codes and
> > uninitialized variables.  This patch fixes this by making sure we take
> > some corrective action after the BUG() macro.
> > 
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Paul Moore <pmoore@redhat.com>
> > 
> > ---
> > 
> > In the process of cleaning up a local git tree I realized I had this
> > patch still sitting in my tree that for some reason hadn't been
> > merged upstream.  Originally sent back on December 5, 2012.
> > ---
> > 
> >  security/selinux/netnode.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> > index c5454c0..03a72c3 100644
> > --- a/security/selinux/netnode.c
> > +++ b/security/selinux/netnode.c
> > @@ -166,6 +166,7 @@ static void sel_netnode_insert(struct sel_netnode
> > *node) break;
> > 
> >  	default:
> >  		BUG();
> > 
> > +		return;
> > 
> >  	}
> >  	
> >  	/* we need to impose a limit on the growth of the hash table so check
> > 
> > @@ -225,6 +226,7 @@ static int sel_netnode_sid_slow(void *addr, u16
> > family,
> > u32 *sid) break;
> > 
> >  	default:
> >  		BUG();
> > 
> > +		ret = -EINVAL;
> > 
> >  	}
> >  	if (ret != 0)
> >  	
> >  		goto out;
> 
> It would be nice to get this into 3.10.

*COUGH*
Hello?  3.10?  Hello?
*COUGH*

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
