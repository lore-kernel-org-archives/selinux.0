Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3KFkKrF028523
 for <selinux@tycho.nsa.gov>; Thu, 20 Apr 2017 11:46:21 -0400
Date: Thu, 20 Apr 2017 17:45:10 +0200 (CEST)
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux@tycho.nsa.gov
Message-ID: <1967496203.202650.1492703110228@pim.register.it>
In-Reply-To: <1492703075.669.1.camel@tycho.nsa.gov>
References: <58517705.198270.1492699110308@pim.register.it>
 <1492703075.669.1.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: remove lock files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello Stephen.

Usually, when a lock file is released, the corresponding file is removed from the filesystem for keeping it clean and tidy.

I might be wrong... But why not ?

If nothing is handling the semanage store, then there shouldn't be a reason for keeping it locked. The presence of a lock file, usually means that the lock is active.

Regards,

Guido

> On the 20th of April 2017 alle 17.44 Stephen Smalley <sds@tycho.nsa.gov> wrote:
> 
> 
> On Thu, 2017-04-20 at 16:38 +0200, Guido Trentalancia wrote:
> > Remove semanage read and transaction lock files upon releasing
> > them.
> 
> Why?
> 
> > 
> > Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> > ---
> >  src/semanage_store.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff -pruN a/src/semanage_store.c b/src/semanage_store.c
> > --- a/src/semanage_store.c	2016-10-14 17:31:26.000000000 +0200
> > +++ b/src/semanage_store.c	2017-04-03 09:32:24.093627962 +0200
> > @@ -1904,6 +1904,7 @@ void semanage_release_trans_lock(semanag
> >  		close(sh->u.direct.translock_file_fd);
> >  		sh->u.direct.translock_file_fd = -1;
> >  	}
> > +	unlink(semanage_files[SEMANAGE_TRANS_LOCK]);
> >  	errno = errsv;
> >  }
> >  
> > @@ -1917,6 +1918,7 @@ void semanage_release_active_lock(semana
> >  		close(sh->u.direct.activelock_file_fd);
> >  		sh->u.direct.activelock_file_fd = -1;
> >  	}
> > +	unlink(semanage_files[SEMANAGE_READ_LOCK]);
> >  	errno = errsv;
> >  }
