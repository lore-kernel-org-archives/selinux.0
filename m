From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070228201419.115784233@hp.com>
Date: Wed, 28 Feb 2007 15:14:19 -0500
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Subject: [RFC 0/4] NetLabel fixups/cleanups
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a collection of various fixups/cleanups (mostly the latter) that
various people have requested over the past few months.  The most noteworthy
change in this patchset is an effort to get the NetLabel support out of the
SELinux security server and into the general SELinux code.

The patch is based off the current net-2.6 git tree, although I suspect with a
little bit of fuzz it should apply to 2.6.20 and 2.6.21-rc1 for those who like
to live dangerously.  This patchset most likely needs a little more work and
testing before I feel comfortable submitting it for inclusion, but a little
birdie suggested I post them as an RFC patchset.

So without further ado, here they are ... please take a look at the patches and
send me any comments you may have.  I know you're not a bashful bunch ;)

Thanks.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
