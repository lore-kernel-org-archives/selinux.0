Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6VEnq0T021114
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 10:49:52 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6VEnlI8024599
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 14:49:48 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.7/8.13.7) with ESMTP id k6VEnngd003823
	for <selinux@tycho.nsa.gov>; Mon, 31 Jul 2006 10:49:50 -0400
Received: (from kmacmill@localhost)
	by localhost.localdomain (8.13.7/8.13.7/Submit) id k6VEnnx6003822
	for selinux@tycho.nsa.gov; Mon, 31 Jul 2006 10:49:49 -0400
Subject: [PATCH 0/2] Introduce symtab_datum_t
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 10:49:49 -0400
Message-Id: <1154357389.26550.76.camel@localhost.localdomain>
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

This patch set likely conflicts with all of the other ones floating
around - if it is easier to apply those first I can easily rebase this
one once those go in.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
