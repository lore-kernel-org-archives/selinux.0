Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k42JS650010359
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 15:28:06 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k42JS54f012540
	for <selinux@tycho.nsa.gov>; Tue, 2 May 2006 19:28:05 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [ANN] Setools-2.4
Date: Tue, 2 May 2006 15:28:04 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158816FEE5@exchange.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <selinux@tycho.nsa.gov>, <fedora-selinux-list@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new version of setools is available on the Tresys website.
http://www.tresys.com/selinux/

Change-Log
==========
apol: File contexts tab now allows for MLS range searching if the loaded
database is from a MLS filesystem.	Policy statistics dialog now
shows MLS and ocontexts summaries.

libapol: Added support for loading base policies containing optionals.
Added support for searching range transitions containing attributes.

libseaudit: Bugfix to support parsing FC5-style audit logs.

seaudit: Added date filters.

secmds: Added support to indexcon and searchcon for MLS filesytems.
Added support to findcon and replcon for MLS filesystems.
	
sechecker: Added incomplete network access (inc_net_access) module.
Added unreachable domains (unreachable_doms) module.  Added impossible
range transitions (imp_range_trans) module.

sesearch: Allow user to search range transitions by attributes and
indirect matching.  Added RBAC searching.

Kevin Carr
Tresys Technology
410.290.1411 x137



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
