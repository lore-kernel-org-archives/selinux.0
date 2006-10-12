Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9C7XqOm017336
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 03:33:52 -0400
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9C7XChT014048
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 07:33:12 GMT
Date: Thu, 12 Oct 2006 02:33:38 -0500
From: Klaus Weidner <klaus@atsec.com>
To: selinux@tycho.nsa.gov, redhat-lspp@redhat.com
Subject: MLS enforcing PTYs, sshd, and newrole
Message-ID: <20061012073338.GG28525@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

in recent LSPP discussions, the subject of end-to-end enforcement of MLS
restrictions in a labeled networking environment came up again, and I had
volunteered to summarize it.

Here's the current situation as I understand it (please correct me if I
misunderstand it).

Background: A user who logs in via sshd over a labeled network connection
through xinetd will get a default MLS level assigned based on the
connection's level.  Then, when using newrole to change MLS levels,
newrole creates a PTY pair and relabels one end to the new level, while
the other end stays at the original level.

There's currently no effective enforcement of MLS restrictions between
the endpoints of a PTY pair, as described in the following bug:

     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=200110

The effect is that the user could "cat" secret data and have it sent over
an "unclassified" network connection; or use "newrole" to easily
reclassify data without needing any MLS override privileges.

Adding MLS enforcement for PTYs is tricky. There are mainly two options
to give SELinux a chance to enforce rules and constraints:

(a) always relabel both ends synchronously and trust the existing
    MLS constraint checks to prevent unauthorized data flows

(b) do an MLS check in the middle of the PTY to ensure data flow is
    permitted between the ends

Option (a) doesn't work since sshd is a trusted application with MLS
overrides, so it'll happily ignore any MLS level mismatches on data
coming from the relabeled PTY end facing the network. 

Option (b) is also undesirable since it would either need to permit MLS
overrides based on the endpoint labels (which would bring back the sshd
override problem), or if it doesn't permit overrides it would be useless
for cases where you do want them.

Both options are currently not implemented and are likely to break
applications for people who don't care about meeting LSPP requirements,
which is obviously undesirable.

This was the basis for a fairly radical alternate proposal: Leave the PTY
behavior the way it is now, but make sure that they never get relabeled
so that the MLS check is unnecessary. That means no more "newrole -l".

So, an attempt to get a LSPP compliant configuration might look something
like the following (nobody is proposing making this the shipped default,
it would be set up locally by those who want it):

- don't allow non-admin users to run the newrole program at all, for
  example by setting its DAC rights to be root-executable only.

- for network login via sshd, nothing really changes. The user gets a
  session using the network connection's current context, and stays at
  that level for the entire session.

- local login always launches a session at the default context for the
  user

If you need local console (or serial) login at different MLS levels for
the same user, you can create multiple Linux users for each human user
that share the same uid and home directory, and use "semanage login" to
map them to appropriate levels. So you'd have smith_secret_cat1,
smith_unclassified and so on.

(That's currently not well compatible with polyinstantiation based on
username - it would be preferable to use the numerical UID (or canonical
username) instead of the login name for the polydir. But that would be a
fairly easy fix.)

It should still work to put a multilevel X desktop on top of this, since
that presumably uses a mechanism other than "newrole" to launch terminals
or windows at different levels. But that's only guesswork due to not
having seen any code for this...

Comments?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
