Subject: [PATCH 0/2] Rewrite setfiles to use matchpathcon
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1106935580.32737.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 28 Jan 2005 13:06:20 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patchset (in the next two messages) eliminates the code
duplication between setfiles (from policycoreutils) and matchpathcon
(from libselinux) by generalizing and extending the matchpathcon support
in libselinux and then rewriting setfiles to use matchpathcon and
additional interfaces exported by libselinux.  matchpathcon(3) was
originally introduced in libselinux to allow other programs such as
udev, rpm, and restorecon to perform lookups against the file contexts
configuration in a similar manner to setfiles, but the code was
initially duplicated between matchpathcon(3) and setfiles(1) because of
the specialized needs of setfiles.  The following patchset removes that
duplication.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
