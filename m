Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k52Hs5Za020088
	for <selinux@tycho.nsa.gov>; Fri, 2 Jun 2006 13:54:05 -0400
Received: from web36607.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k52Hs3Wn022588
	for <selinux@tycho.nsa.gov>; Fri, 2 Jun 2006 17:54:04 GMT
Message-ID: <20060602175358.48647.qmail@web36607.mail.mud.yahoo.com>
Date: Fri, 2 Jun 2006 10:53:58 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: RE: [PATCH] selinux: Kernel access key retention support for SELinux
To: "Frank L. Mayer" <mayerf@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588210227@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- "Frank L. Mayer" <mayerf@tresys.com> wrote:

> > > Discretionary access control is what the basic
> Linux access control 
> > > model is.  Mandatory access control is what
> SELinux provides.
> > 
> > With user settable MCS labels SELinux provides a 
> > Discretionary Access Control mechanism.
> 
> And with non-user settable MLS and/or Type labels
> SELinux provides MAC.
> Hence Steve's point.  Frank

My point is that SELinux is not ONLY a MAC mechanism.
SELinux does indeed provide MAC. It also provides DAC.
SELinux has more than MAC now. Thus, holding SELinux
up as an example of MAC is no longer correct, because
SELinux includes a DAC mechanism in MCS.

It's easy enough to confuse people with our
rich set of trusted systems jargon when it is
used correctly (my favorite is the difference
between a Bell & LePadula label and a level)
without improperly identifying a popular and
visible product (SELinux) as a particular thing
(A MAC system) when that identification is not
correct (because SELinux also supports DAC).


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
