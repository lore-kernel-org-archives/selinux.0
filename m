Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8GFATPK024119
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 11:10:29 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8GFASej002044
	for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2011 15:10:28 GMT
Subject: Re: [PATCH 35/67] policycoreutils: sandbox: FIXME add level based
 kill
From: Eric Paris <eparis@redhat.com>
To: Guido Trentalancia <guido@trentalancia.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Date: Fri, 16 Sep 2011 11:10:21 -0400
In-Reply-To: <1316151193.2364.38.camel@vortex>
References: <4E7255EB.3000804@redhat.com> <1316148577.2364.28.camel@vortex>
	 <1316151193.2364.38.camel@vortex>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316185823.14578.2.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-09-16 at 07:33 +0200, Guido Trentalancia wrote:
> On Fri, 2011-09-16 at 06:49 +0200, Guido Trentalancia wrote:
> > On Thu, 2011-09-15 at 15:45 -0400, Daniel J Walsh wrote:
> > > @@ -941,6 +1011,9 @@ childerr:
> > >         waitpid(child, &status, 0);
> > >         status_to_retval(status, status);
> > >  
> > > +       if (execcon && kill_all)
> > > +               killall(execcon);
> > > +
> > >         if (tmpdir_r) cleanup_tmpdir(tmpdir_r, tmpdir_s, pwd, 1);
> > >  
> > >  err: 
> > 
> > Was it not just "kill" instead of "kill_all" ?
> 
> I just realised that variable is going to get renamed in another patch
> ([PATCH 36/67] policycoreutils: sandbox: cntrl-c should kill entire). So
> I think this patch requires 36/67, that's it but was not evident at
> first sight.

Thanks, mistake on my part.  Will move the required change from patch
#36 into patch #35 before committing.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
