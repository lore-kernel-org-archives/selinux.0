MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: SELinux userspace infrastructure language
Date: Thu, 31 May 2007 13:35:20 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588BF01FF@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "Karl MacMillan" <kmacmill@redhat.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some discussion has started off-list about what language to use for the
implementation of the new policy intermediary format and we'd like to
bring this discussion into the community to get feedback from users and
other developers.

In the policyrep branch we've basically started taking OOisms and
pythonisms and reimplementing them in C which is non-ideal. There is
also madness behind the string handling in some newer work we are doing.
We discussed the possibility of using python or C++ for our libraries so
that they are more represenative of the datastructures that are being
created elsewhere and being reimplemented in C. 

Libsemanage could easily be implemented in pure python, it doesn't do
much hard work, libsepol, on the other hand, is used by a lot of
external stuff so it's a more difficult sell. It would be nice to
potentially use the STL for a lot of the stuff we are doing in libsepol.

Libsemanage need not be rewritten immediately (or at all if not
considered a necessity) but the new policy representation work will be
happening in the near term so the language chosen for it will
immediately be used. This language would be required for any systems
with managed policies (eg., using policy modules and semanage) so that
is something to be considered.

What are some opinions from users and other people developing systems
with SELinux?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
