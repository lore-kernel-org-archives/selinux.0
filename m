Subject: [PATCH 0/6] Drop legacy boolean/users support (setlocaldefs)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 09:40:03 -0400
Message-Id: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch series completely removes the legacy support for
local boolean and user definitions (setlocaldefs) from libsepol and
libselinux and updates libsemanage and policycoreutils for the resulting
interface changes and removals.  As such, it requires bumping the .so
versions, which has already been done on the policyrep branch (and these
patches are therefore intended to be applied there first, and then
merged to trunk later along with the policyrep work).

The preservebools support is left temporarily intact since the
corresponding kernel support for automatically preserving booleans
across policy reload is not yet in a released kernel.org kernel.

The complete diffstat for all 6 patches is:

 libselinux/include/selinux/selinux.h             |   10 
 libselinux/man/man3/security_load_booleans.3     |   22 -
 libselinux/man/man3/selinux_binary_policy_path.3 |    5 
 libselinux/man/man3/selinux_booleans_path.3      |    1 
 libselinux/src/booleans.c                        |  213 ---------------
 libselinux/src/file_path_suffixes.h              |    2 
 libselinux/src/load_policy.c                     |   23 -
 libselinux/src/selinux_config.c                  |   41 --
 libselinux/src/selinux_internal.h                |    3 
 libselinux/src/selinuxswig.i                     |    6 
 libsemanage/src/booleans_activedb.c              |    2 
 libsepol/man/man3/sepol_genbools.3               |   16 -
 libsepol/man/man3/sepol_genusers.3               |   54 ---
 libsepol/man/man8/genpolbools.8                  |   16 -
 libsepol/man/man8/genpolusers.8                  |   42 ---
 libsepol/src/genbools.c                          |  179 -------------
 libsepol/src/genusers.c                          |  315 -----------------------
 libsepol/src/libsepol.map                        |    4 
 policycoreutils/audit2why/audit2why.c            |   14 -
 policycoreutils/setsebool/setsebool.c            |    2 
 20 files changed, 35 insertions(+), 935 deletions(-)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
