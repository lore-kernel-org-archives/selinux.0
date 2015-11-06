From: Jan Stancek <jstancek@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, paul@paul-moore.com, jstancek@redhat.com
Subject: [selinux-testsuite PATCH 0/4] inet_socket and mmap patches
Date: Fri,  6 Nov 2015 14:07:20 +0100
Message-Id: <cover.1446805443.git.jstancek@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Here are 4 patches that fix failures I have came across in recently
added tests: "inet_socket" and "mmap" on RHEL distros.

I have tested this series on:
                   i386   x86_64   ia64   ppc64   ppc64le   s390x
RHEL5.6/11           *      *        *      *       N/A       *
RHEL6.2/4/5/6/7      *      *       N/A     *       N/A       *
RHEL7.0/1/2         N/A     *       N/A     *        *        *

I have hit one known kernel issue on RHEL7.0/1:
  Bug 1102641 - BUG: It is not possible to communicate between local
                program and local ipv6 address when at least one
                'netlabelctl unlbl' rule is added
  https://bugzilla.redhat.com/show_bug.cgi?id=1102641

This didn't prevent tests from completing, but since harness we use
is using IPv6 by default, it was getting stuck on connect after test
completed.

Other than this one known kernel issue, all tests have passed.

Jan Stancek (4):
  tests/inet_socket: check 'ip xfrm policy ctx' support
  inet_socket: secon: use current pid
  mmap/mprotect_heap: make sure memory is allocated from heap
  mmap/mprotect_file_private_execmod: clear READ_IMPLIES_EXEC

 tests/inet_socket/ipsec-load               |  4 ++--
 tests/inet_socket/test                     | 31 ++++++++++++++++++------------
 tests/mmap/mprotect_file_private_execmod.c | 13 +++++++++++++
 tests/mmap/mprotect_heap.c                 |  9 ++++++++-
 4 files changed, 42 insertions(+), 15 deletions(-)

-- 
1.8.3.1
