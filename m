Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72I9uOi004688
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:09:56 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72I9neA006379
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 18:09:50 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.7/8.13.7) with ESMTP id k72I9qrL021407
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:09:53 -0400
Received: (from kmacmill@localhost)
	by localhost.localdomain (8.13.7/8.13.7/Submit) id k72I9phF021406
	for selinux@tycho.nsa.gov; Wed, 2 Aug 2006 14:09:51 -0400
Subject: [PATCH 0/2] Ver 2 Introduce symtab_datum_t
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 14:09:51 -0400
Message-Id: <1154542191.27457.85.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set adds a new structure - symtab_datum_t - and converts all
of the datum types to place this struct as their first member. This
unifies the storage of data common to all symtab datums and allows free
casting between specific datum types (e.g., role_datum_t) and
symtab_datum_t. A minor cleanup using this new struct is also included.

A later patch set will build on this to also store scope information in
the symtab_datum_t.

This patch set includes the additional cast pointed out by Josh and has
been rebased to the current head. Again, it conflicts with other patch
sets that are pending - I can rebase this after applying those if
needed.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
