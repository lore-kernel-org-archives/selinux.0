From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/6] Keys: Key management updates
Date: Fri, 16 Jun 2006 13:56:54 +0100
To: mdlemay@epoch.ncsc.mil, sds@tycho.nsa.gov, jmorris@redhat.com
Cc: selinux@tycho.nsa.gov, dhowells@redhat.com
Message-Id: <20060616125654.26378.36519.stgit@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


These patches update a few key management related things, mainly security
related.  They have the following prerequisite patches from Andrew Morton's -mm
tree:

	selinux-add-hooks-for-key-subsystem.patch
	keys-fix-race-between-two-instantiators-of-a-key.patch

Some of these patches have been modified from the originals I've been given so
that they'll all apply in sequence.  Note that the quota flag and the
"kernel/user requested this key" flag have been combined into a single flag
mask argument.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
