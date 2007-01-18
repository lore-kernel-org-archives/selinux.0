Subject: [ANN] Stable branch created for selinux core userland
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Manoj Srivastava <manoj.srivastava@stdc.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 16:12:58 -0500
Message-Id: <1169154778.22731.433.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

A stable branch for the selinux core userland libraries and utilities
has been created in the subversion repository at sourceforge.  You can
check out a copy via:
$ svn co https://selinux.svn.sourceforge.net/svnroot/selinux/branches/stable/1_0 selinux-stable

This is a stable branch for use by users and distributions that want
maximal stability (bug fixes only), and will be the basis for future
stable releases on nsa.gov/selinux.

All new development will proceed on the trunk, with the package versions
rolling over to 2.y.z (initially 2.0.0).  Note that the trunk may at
times be unstable and incompatible with the stable branch, although we
will periodically stabilize it for release as a devel release on
nsa.gov/selinux, and we will seek to retain binary (ABI) compatibility
for existing binaries (via symbol versioning) for such releases.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
