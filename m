Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87DgiO4017114
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 09:42:44 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l87DggZj005335
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:42:42 GMT
Subject: Re: Graphical depiction of TE policy
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joe Nall <joe@nall.com>
Cc: Dave Sugar <dsugar@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <1BE2F3D7-695B-4308-B1C7-00D1C75B4315@nall.com>
References: <A9D9EDA4-EA98-465B-89C5-389E4C4E6945@nall.com>
	 <1189168154.3607.3.camel@localhost.localdomain>
	 <1BE2F3D7-695B-4308-B1C7-00D1C75B4315@nall.com>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 09:42:35 -0400
Message-Id: <1189172555.9692.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-07 at 07:50 -0500, Joe Nall wrote:
> On Sep 7, 2007, at 7:29 AM, Dave Sugar wrote:
> 
> > Joe,
> >
> > There has been some work done on graphically representing security
> > policy.  A project we worked on here called CDS Framework is a tool to
> > graphically generate policy which is then translated into SELinux TE
> > policy.  See http://oss.tresys.com/projects/cdsframework
> >
> > While this is not exactly what you are asking about it is related  
> > and I
> > wanted to mention it.
> >
> > Dave Sugar
> 
> Chris pointed it out to me a few weeks ago and it is very cool. We  
> want to do the opposite and create diagrams to show security  
> evaluators from policy that we have already written.
> 
> joe
> 

At one point I modified the information flow analysis in Apol to output
dot files. We never turned it into a proper feature because the graphs
ended up being _very_ large - rendering them would take 20-30 minutes.
It could be useful, however, if you could limit the types or
low-bandwidth information flows that you cared about in some way.

If you look at apol_infoflow_graph_create in
http://oss.tresys.com/projects/setools/browser/trunk/libapol/src/infoflow-analysis.c you can see how the information flow graph is created. At the end of that routine it wouldn't be hard to output a dot file. No idea where the code I had to it is went to, but it was no more that 10-15 lines of code.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
