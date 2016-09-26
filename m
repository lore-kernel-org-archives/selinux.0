From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Android Fork
Date: Mon, 26 Sep 2016 10:33:37 -0700
Message-Id: <1474911219-20465-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Below, are the last two majore patches to close the Android fork.

Patch "libselinux: add ifdef'ing for ANDROID and BUILD_HOST" I
combined into 1 patch since some ANDROID and BUILD_HOST defines
are on the same line, I can split it appart if its really needed.

Note, that you need the Android make recipe for some of these
configurations to work as Android doesn't use all the src files.

The Build files are left out, for now, so AOSP can pull from
upstream without it breaking the AOSP build.

Once merged AOSP can take the build files, once they drop
external/libselinux, and then the last patch u[stream will
be the enabling patch with the build files.

[PATCH 1/2] libselinux: introduce configurable backends
[PATCH 2/2] libselinux: add ifdef'ing for ANDROID and BUILD_HOST
