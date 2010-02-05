Subject: Re: [PATCH 2/2] libsepol: remove dead code in
 check_avtab_hierarchy_callback()
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: method@manicmethod.com, Jacques Thomas <jthomas@cs.purdue.edu>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4B6BAFD0.2050607@ak.jp.nec.com>
References: <4AF71B05.8030707@cs.purdue.edu>
	 <4B035FA4.6080605@ak.jp.nec.com> <4B056D3D.2050303@cs.purdue.edu>
	 <4B1411B5.5050406@cs.purdue.edu> <4B146B17.50706@ak.jp.nec.com>
	 <4B14934F.9050401@cs.purdue.edu>
	 <1263570719.20826.21.camel@moss-pluto.epoch.ncsc.mil>
	 <4B54339F.8070501@ak.jp.nec.com> <4B5685EC.1000500@ak.jp.nec.com>
	 <4B6BAFD0.2050607@ak.jp.nec.com>
Content-Type: text/plain
Date: Fri, 05 Feb 2010 09:50:54 -0500
Message-Id: <1265381454.18100.50.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-05 at 14:42 +0900, KaiGai Kohei wrote:
> What is the current status of this patch?
> Its kernel side patch has been already merged into James's -next tree.
> 
> http://git.kernel.org/?p=linux/kernel/git/jmorris/security-testing-2.6.git;a=commit;h=7d52a155e38d5a165759dbbee656455861bf7801

I had to use -l to get it to apply (whitespace mangled).

Before applying it, when trying to install the test_policy.pp module
from the selinux testsuite with expand-check=1
in /etc/selinux/semanage.conf, I get:
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_file_blue_t : file {  ioctl read getattr lock open }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_file_red_t : file {  write append }
libsepol.hierarchy_check_constraints: 2 total errors found during hierarchy check

And after applying it, I get the following:
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_file_blue_t : file {  ioctl read getattr lock open }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : process {  fork transition sigchld sigkill sigstop signull signal getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh rlimitinh setcurrent setkeycreate setsockcreate }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : capability {  dac_override dac_read_search }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : file {  ioctl read write getattr lock append open }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : dir {  ioctl read getattr lock search open }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : fd {  use }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : lnk_file {  ioctl read getattr lock }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : fifo_file {  ioctl read write getattr lock append open }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : unix_stream_socket {  ioctl read write create getattr setattr append bind connect listen accept getopt setopt shutdown }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : unix_dgram_socket {  ioctl read write create getattr setattr append bind connect getopt setopt shutdown sendto }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_child_t : association {  sendto }
libsepol.check_avtab_hierarchy_callback: hierarchy violation between types test_bounds_child_t and test_bounds_file_red_t : file {  write append }
libsepol.hierarchy_check_constraints: 12 total errors found during hierarchy check

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
