Subject: avc:  granted null messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain
Date: Tue, 18 Dec 2007 16:49:12 -0500
Message-Id: <1198014552.11568.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If a (buggy) caller passes a requested permission value of zero to
avc_has_perm, it correctly returns a permission denial (if enforcing),
but avc_audit will report it as a granted message with a "null" access
vector (also if enforcing) due to the way in which avc_audit checks for
the denied case.  This was reported for nscd in
https://bugzilla.redhat.com/show_bug.cgi?id=352601,
but applies to both the libselinux AVC and the kernel AVC.

In permissive mode, avc_has_perm permits the operation, and avc_audit
reports nothing at all.

So the question is how do we want to handle this case?

It is a bug in the caller, but making it a BUG_ON() in the kernel and an
assert() in libselinux doesn't seem very graceful, especially if in
permissive mode.

We could easily adjust avc_audit() to report it as a denied message with
a 'null' access vector, although running audit2allow on that output will
yield a broken policy module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
