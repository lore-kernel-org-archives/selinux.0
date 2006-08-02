Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72I3DGI004370
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:03:13 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72I32a2000889
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 18:03:02 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k72I3BPA026424
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:03:11 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k72I3BJk003826
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:03:11 -0400
Received: from localhost.localdomain (vpn-248-64.boston.redhat.com [10.13.248.64])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id k72I39lN023395
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:03:10 -0400
From: kmacmillan@mentalrootkit.com
To: selinux@tycho.nsa.gov
Cc: 
Subject: Ver 2 Introduce symtab_datum_t
Reply-To: kmacmillan@mentalrootkit.com
Date: Wed, 02 Aug 2006 14:03:05 -0400
Message-Id: <11545417871050-git-send-email-kmacmillan@mentalrootkit.com>
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
sets that are pending - I can rebase this after applying those if needed.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
