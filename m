From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, brindle@quarksecurity.com
Subject: Libsepol Mac Build Errors
Date: Fri, 23 Sep 2016 13:55:49 -0700
Message-Id: <1474664152-18727-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The patches below fix some warnings reported by Josh Brindle on
the libsepol build.

Josh can you test these and see if those three warning go away
and give an ack if they are ok?

[PATCH 1/3] libsepol: fix unused variable 'size' on mac build
[PATCH 2/3] libsepol: fix unused variable 'len' on mac build
[PATCH 3/3] libsepol: fix unitialized variable 'nread' on mac build
