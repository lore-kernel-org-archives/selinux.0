Reply-To: <mayerf@tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Colin Walters'" <walters@verbum.org>,
   "'Joshua D. Guttman'" <guttman@mitre.org>
Cc: "'Karl MacMillan'" <kmacmillan@tresys.com>,
   "'SELinux List'" <SELinux@tycho.nsa.gov>,
   "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>,
   "'Amy L. Herzog'" <aherzog@mitre.org>,
   "'John D. Ramsdell'" <ramsdell@mitre.org>,
   "'Galen B. Williamson'" <gwilliam@mitre.org>,
   "'Grant M. Wagner'" <gmw@tycho.ncsc.mil>, "'David Caplan'" <dac@tresys.com>
Subject: RE: Announce: SELinux conditional policy extensions
Date: Fri, 13 Feb 2004 14:24:00 -0500
Message-ID: <001101c3f266$eefeae40$020d010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1076649558.17927.14.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> A different approach that comes to mind is binary policy "patches". 
> So say you have a base policy which includes the unmodified ping.te. 
> But as described in README-COND, you also want to sometimes allow
> users to execute ping.  So you create a separate file ping-user.te,
> which contains the necessary added permissions.  This would be
> compiled specially by checkpolicy to a binary policy "patch" relative
> to the base policy, which could be loaded and also unloaded at
> runtime by the kernel. 

I think Steve already noted the reference to the precursor work that did
essentially this.  The conditional policy is the evolution of that work.
 
> Implementing unloading would require implementing negation, but that
> seems useful enough on its own too that it would be worthwhile.

We've aactually spent considerable time thinking about the problem of
"unloading" and you underestimate that complexity of the problem.  The primary
complicating factor is that multiple rules within a policy may (and very often
do) grant the same access, so you cannot simply remove access granted by a rule
to be unloaded as another (still loaded rule) might have already granted that
access.  In the simple case of policy patches that we previously released, the
only safe solution was to reconstruct the policy each time.  

Indeed, we are just beginning to more formally deal with the issue of loading
and unloading "policy modules" as part of our next step in our development
efforts aimed at improved policy management infrastructure (of which the
conditional policy extensions was a previous step).  We haven't advanced far
along this path, but right now we do not see the need to further change the
kernel mechanism in order to support policy modules that are loadable during
runtime (e.g., package install).  The real challenge is label management but
that's a different discussion.....

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
