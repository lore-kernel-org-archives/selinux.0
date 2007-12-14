Subject: Re: [LTP] Se-Linux Updates for LTP
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jburke@redhat.com
Cc: James Morris <jmorris@redhat.com>, Joy Latten <latten@us.ibm.com>,
        Daniel Walsh <dwalsh@redhat.com>, subrata@linux.vnet.ibm.com,
        ltp-list <ltp-list@lists.sourceforge.net>,
        George Kraft <gk4@us.ibm.com>, klausk@br.ibm.com,
        Robert Williamson <robbiew@us.ibm.com>,
        Michael Reed <mreed10@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Larson <plars@us.ibm.com>
In-Reply-To: <4761CF71.1020101@redhat.com>
References: <1197044724.4411.17.camel@subratamodak.linux.ibm.com>
	 <1197266491.4482.2.camel@subratamodak.linux.ibm.com>
	 <1197295269.18120.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20071210171503.GA25223@sergelap.austin.ibm.com>
	 <1197382969.9034.29.camel@subratamodak.linux.ibm.com>
	 <20071211155219.GA22416@sergelap.austin.ibm.com>
	 <1197458260.4710.95.camel@subratamodak.linux.ibm.com>
	 <1197477042.1125.83.camel@moss-spartans.epoch.ncsc.mil>
	 <4761CF71.1020101@redhat.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 14 Dec 2007 10:11:07 -0500
Message-Id: <1197645067.31325.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-12-13 at 19:33 -0500, Jeff Burke wrote:
> Stephen, Joy, Dan and James
> 	Using Stephens latest patch. Here are the results for the selinux tests
> ltp-full-20071130, RHEL5.1 + selinux-policy-2.4.6-106.el5_1.3:

Hi Jeff,

I'll take a look.  The patch worked for me on Fedora 7.  Don't know for
certain how that differs from RHEL5.1 in terms of SELinux functionality
and base policy, but the testsuite is rather sensitive to changes I'm
afraid.

> I have also attached the selinux.outfile for both the i386 and x86_64
> testing
> 
> i386, x86_64, ppc, s390x All fail in a similar manor.
> ------------------------------------------------------------------------
> Test Start Time: Thu Dec 13 17:55:32 2007
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> SELinux01                      PASS       0
> SELinux02                      FAIL       1
> SELinux03                      PASS       0
> SELinux04                      PASS       0
> SELinux05                      PASS       0
> SELinux06                      PASS       0
> SELinux07                      PASS       0
> SELinux08                      PASS       0
> SELinux09                      PASS       0
> SELinux10                      FAIL       2
> SELinux11                      PASS       0
> SELinux12                      PASS       0
> SELinux13                      PASS       0
> SELinux14                      PASS       0
> SELinux15                      PASS       0
> SELinux16                      PASS       0
> SELinux17                      PASS       0
> SELinux18                      PASS       0
> SELinux19                      PASS       0
> SELinux20                      PASS       0
> SELinux21                      PASS       0
> SELinux22                      PASS       0
> SELinux23                      PASS       0
> SELinux24                      PASS       0
> SELinux25                      PASS       0
> SELinux26                      PASS       0
> SELinux27                      PASS       0
> SELinux28                      FAIL       1
> SELinux29                      FAIL       1
> SELinux30                      PASS       0
> SELinux31                      PASS       0
> SELinux32                      PASS       0
> SELinux33                      PASS       0
> SELinux34                      PASS       0
> SELinux35                      PASS       0
> SELinux36                      PASS       0
> SELinux37                      PASS       0
> SELinux38                      PASS       0
> 
> -----------------------------------------------
> Total Tests: 38
> Total Failures: 4
> Kernel Version: 2.6.18-53.el5
> Machine Architecture: x86_64
> ------------------------------------------------------------------------
> 
> ia64 does not compile:
> ------------------------------------------------------------------------
> make -C ltp-full-*/testcases/kernel/security/selinux-testsuite/tests
> make[1]: Entering directory
> `/mnt/tests/kernel/security/selinux/ltp-selinux/20071130/ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests'
> make[2]: Entering directory
> `/mnt/tests/kernel/security/selinux/ltp-selinux/20071130/ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests/domain_trans'
> make[2]: Nothing to be done for `all'.
> make[2]: Leaving directory
> `/mnt/tests/kernel/security/selinux/ltp-selinux/20071130/ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests/domain_trans'
> make[2]: Entering directory
> `/mnt/tests/kernel/security/selinux/ltp-selinux/20071130/ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests/entrypoint'
> make[2]: Nothing to be done for `all'.
> make[2]: Leaving directory
> `/mnt/tests/kernel/security/selinux/ltp-selinux/20071130/ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests/entrypoint'
> make[2]: Entering directory
> `/mnt/tests/kernel/security/selinux/ltp-selinux/20071130/ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests/execshare'
> cc     selinux_execshare_child.c  -lselinux -o selinux_execshare_child
> cc     selinux_execshare_parent.c  -lselinux -o selinux_execshare_parent
> selinux_execshare_parent.c: In function ‘main’:
> selinux_execshare_parent.c:80: warning: passing argument 1 of ‘clone’
> from incompatible pointer type
> /tmp/ccOYLyhB.o: In function `main':
> selinux_execshare_parent.c:(.text+0x6f2): undefined reference to `clone'
> collect2: ld returned 1 exit status
> make[2]: *** [selinux_execshare_parent] Error 1
> make[2]: Leaving directory
> `/mnt/tests/kernel/security/selinux/ltp-selinux/20071130/ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests/execshare'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory
> `/mnt/tests/kernel/security/selinux/ltp-selinux/20071130/ltp-full-20071130/testcases/kernel/security/selinux-testsuite/tests'
> make: *** [bldselinux] Error 2
> ------------------------------------------------------------------------
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
