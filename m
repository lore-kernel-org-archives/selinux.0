Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l62FKVdF009599
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 11:20:31 -0400
Received: from e35.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l62FKTgI002925
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 15:20:29 GMT
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l62FKRf5023109
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 11:20:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l62FKPbg266966
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 09:20:25 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l62FKO9U029236
	for <selinux@tycho.nsa.gov>; Mon, 2 Jul 2007 09:20:25 -0600
Date: Mon, 2 Jul 2007 10:20:21 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, selinux@tycho.nsa.gov
Subject: Re: [patch] refpolicy update for cap_setfcap
Message-ID: <20070702152021.GA3243@sergelap.austin.ibm.com>
References: <20070628191707.GA13973@sergelap.austin.ibm.com> <1183388743.4084.6.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1183388743.4084.6.camel@gorn.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Christopher J. PeBenito (cpebenito@tresys.com):
> On Thu, 2007-06-28 at 15:17 -0400, Serge E. Hallyn wrote:
> > A tentative patch to support file capabilities introduces a new
> > CAP_SETFCAP capability.  This patch adds setfcap to the refpolicy
> > access_vectors.
> 
> I'd prefer to wait until the file caps code starts going upstream.  It
> looks like discussions about it continue, assuming I am understanding
> the threads I've unburied from the apparmor flood.

Sure, it's in -mm, but I assume it won't be heading up to Linus' tree
until a list of comments from Andrew Morgan have been suitably
addressed.

thanks,
-serge

> > Index: policy/flask/access_vectors
> > ===================================================================
> > --- policy/flask/access_vectors (revision 2359)
> > +++ policy/flask/access_vectors (working copy)
> > @@ -363,6 +363,7 @@
> >         lease
> >         audit_write
> >         audit_control
> > +       setfcap
> >  }
> > 
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing
> > list.
> > If you no longer wish to subscribe, send mail to
> > majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> > 
> > 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
