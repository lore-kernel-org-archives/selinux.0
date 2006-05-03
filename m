Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k43DRA38028124
	for <selinux@tycho.nsa.gov>; Wed, 3 May 2006 09:27:10 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k43DR995004179
	for <selinux@tycho.nsa.gov>; Wed, 3 May 2006 13:27:09 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [ANN] Setools-2.4
Date: Wed, 3 May 2006 09:27:08 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158816FF33@exchange.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <sundaram@fedoraproject.org>
Cc: <selinux@tycho.nsa.gov>, <fedora-selinux-list@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Tue, 2006-05-02 at 15:28 -0400, Kevin Carr wrote:
> > A new version of setools is available on the Tresys website.
> > http://www.tresys.com/selinux/
> >
> > Change-Log
> > ==========
> > apol: File contexts tab now allows for MLS range searching if the
loaded
> > database is from a MLS filesystem.	Policy statistics dialog now
> > shows MLS and ocontexts summaries.
> >
> > libapol: Added support for loading base policies containing
optionals.
> > Added support for searching range transitions containing attributes.
> >
> > libseaudit: Bugfix to support parsing FC5-style audit logs.
> 
> Curious: Is FC5 style different from a standard one?

This was nothing substantial, just a bug that showed up in the parser.

Kevin Carr
Tresys Technology
410.290.1411 x137



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
