Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1OKfdRb026025
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 15:41:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1OKdmlK011490
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 20:39:48 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i1OKdmOX011487
	for <selinux@tycho.nsa.gov>; Tue, 24 Feb 2004 20:39:48 GMT
Subject: Re: [selinux] Re: identity
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: =?ISO-8859-1?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
Cc: James Morris <jmorris@redhat.com>, Russell Coker <russell@coker.com.au>,
   SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1077653032.22405.36.camel@kusturica>
References: 
	 <Xine.LNX.4.44.0402240945330.24455-100000@thoron.boston.redhat.com>
	 <1077634629.21221.80.camel@moss-spartans.epoch.ncsc.mil>
	 <1077653032.22405.36.camel@kusturica>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1077655261.21221.191.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 24 Feb 2004 15:41:01 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-02-24 at 15:03, Magosányi Árpád wrote:
> I tend to view "auditing framework" as a subset of "security framework",
> and think that separating access control and audit is either unfeasible
> or impossible, given that most of the stuff to be audited is access
> control decision. Plus the access control logic can benefit from the
> additional data which should be available for auditing purposes.
> First it is a PITA that one have to dig out file name or IP address,
> but you will soon realise that you can do access control decisions
> based the data just mined out if you want.
> 
> On the other hand, there are some data (those which have to be used
> for access control decisions) which should be dug out twice if you
> want to separate auditing from access control.
> 
> And on the third hand:
> Just tell me that FAU_GEN is not an aim of SELinux, and I will forget
> the project forever.

An aim of SELinux itself?  No.  See the overview
(http://www.nsa.gov/selinux/), FAQ  
(http://www.nsa.gov/selinux/faq.cfm#I12), and prior postings to this
list on the topic of auditing, e.g.
http://marc.theaimsgroup.com/?l=selinux&m=97907408104978&w=2.  We agree
that auditing is important, and would encourage integration of SELinux
with an auditing framework (which can benefit both SELinux and the
auditing framework), but SELinux itself is not intended to meet auditing
requirements.  Note that LSM cannot meet auditing requirements, and the
right solution is not to bloat LSM into a universal hook framework but
instead to provide a separate framework for auditing.  The additional
state requested by Russell (including an immutable user identity for
audit records) belongs in an audit context, not the SELinux context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
