Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l91DvN7d019128
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 09:57:23 -0400
Received: from e4.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l91DvJr5007025
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 13:57:19 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l91DvHQ3000404
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 09:57:17 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l91DvH1g692830
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 09:57:17 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l91DvFxS017290
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2007 09:57:16 -0400
Subject: [ANNOUNCE] The Linux Test Project has been Released for SEPTEMBER
	2007
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Reply-To: subrata@linux.vnet.ibm.com
To: ltp-list <ltp-list@lists.sourceforge.net>,
        ltp-announce <ltp-announce@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org,
        containers@lists.osdl.org, redhat-lspp@redhat.com,
        selinux@tycho.nsa.gov, linux-audit@redhat.com
Content-Type: multipart/mixed; boundary="=-E81cmOWnASCL309x8OC2"
Date: Mon, 01 Oct 2007 19:27:09 +0530
Message-Id: <1191247029.4651.9.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-E81cmOWnASCL309x8OC2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dear All,

The Linux Test Project test suite has been released for the month of
SEPTEMBER 2007. The latest version of the test-suite contains 3000+
tests for the Linux OS and can be found at http://ltp.sourceforge.net/.
Latest happenings in LTP can also be found at:
http://ltp.sourceforge.net/wiki/,
http://ltp.sourceforge.net/wikiArchives.php, and,
IRC: irc.freenode.org #ltp.

Our web site also contains other information such as:
- A Linux test tools matrix
- Technical papers
- How To's on Linux testing
- Code coverage analysis tool.

Release Highlights:

* Enabling Kernel Version Comparisns for Lots of Testcase(s),
* Removal of Connectathon Testcases for want of GPLV2 license,
* Patching of NUMA Testcases for better Statistics Collection,
* Fixes for KDUMP scripts errors,
* Mandatory generation of failed testcases file,
* Fix of LTP output format as pointed out by Andrew Morton,
* Update of OPENHPI testsuite to 2.10.0,

Note(s) from the Maintainer:
LTP output will see new formats in the coming days. This will make
interpreting output more easily and conceptually. Hope that Real Time
Linux Testcases will see the light of the day by this month end.

We would encourage the community to post results to
ltp-results@lists.sf.net,
patches, new tests, bugs or comments/questions to ltp-list@lists.sf.net,
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=103382
(for New Bug(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=303382
(for New Patch(s)),
http://sourceforge.net/tracker/?func=add&group_id=3382&atid=353382
(for New Feature Request(s))

Please also see the ChangeLog Attached (SEPTEMBER 2007):

Happy testing, 
Regards-- 
Subrata,

--=-E81cmOWnASCL309x8OC2
Content-Disposition: attachment; filename=Sep-2007_Changelog.txt
Content-Type: text/plain; name=Sep-2007_Changelog.txt; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by jazzhorn.ncsc.mil id l91DvJr5007025

1)  Log Message: "seebs@users.sf.net" wanted to fix some anomalies in "ac=
ct01" testcase
File(s) Affected:
ltp/testcases/kernel/syscalls/acct/acct01.c

2)  Log Message: "risrajak@linux.vnet.ibm.com" made modifications to chec=
k whether the Kernel is UTSNAMESPACE or SYSVIPC_NAMSPACE enabled
File(s) Affected:
ltp/testcases/kernel/containers/container_test.sh
ltp/testcases/kernel/containers/sysvipc/Makefile
File(s) Added:
ltp/testcases/kernel/containers/sysvipc/check_ipcns_enabled.c

3)  Log Message: "rsalveti@linux.vnet.ibm.com" fixed exit code for inotif=
y01 and inotify02 when running with kernel < 2.6.13
File(s) Affected:
ltp/testcases/kernel/syscalls/inotify/inotify01.c
ltp/testcases/kernel/syscalls/inotify/inotify02.c

4)  Log Message: Fixing "ioperm02" testcase for kernel comparisns
File(s) Affected:
ltp/testcases/kernel/syscalls/ioperm/ioperm02.c

5)  Log Message: "Sivakumar.C@in.ibm.com" induced time for Statistics col=
lection in RHEL
File(s) Affected:
ltp/testcases/kernel/numa/numa01.sh

6)  Log Message: Removing these Testcases as they do not satisfy GPLv2 Li=
cense Agreement
File(s) Deleted:
ltp/testcases/network/nfs/cthon04
	Makefile README READWIN.txt Testitems domount.c getopt.c runtests server=
 tests.h tests.init unixdos.h
ltp/testcases/network/nfs/cthon04/basic
	Makefile runtests runtests.mvs subr.c test1.c test2.c test3.c test4.c te=
st4a.c test5.c test5a.c test5b.c test6.c test7.c test7a.c test7b.c test8.=
c test9.c
ltp/testcases/network/nfs/cthon04/basic/console
	build.bat test1.mak test2.mak test3.mak test4a.mak test4.mak test5a.mak =
test5b.mak test5.mak test6.mak test7a.mak test7b.mak test7.mak test8.mak =
test9.mak
ltp/testcases/network/nfs/cthon04/basic/dos
	build.bat test1.mak test2.mak test3.mak test4a.mak test4.mak test5a.mak =
test5b.mak test5.mak test6.mak test7a.mak test7b.mak test7.mak test8.mak =
test9.mak
ltp/testcases/network/nfs/cthon04/basic/scripts
	basic2.bat basic3.bat basic.bat cthon00.mst cthon01.mst cthon02.mst ctho=
n03.mst cthon04.mst cthon.bat runcthon.prl
ltp/testcases/network/nfs/cthon04/general
	large4.sh large.c Makefile makefile.tst mkdummy nroff.in rmdummy runtest=
s runtests.wrk stat.c
ltp/testcases/network/nfs/cthon04/lock
	Makefile runtests tlock.c
ltp/testcases/network/nfs/cthon04/special
	bigfile2.c bigfile.c dupreq.c excltest.c freesp.c fstat.c holey.c Makefi=
le negseek.c nfsidem.c nstat.c op_chmod.c op_ren.c op_unlk.c READWIN.txt =
rename.c=20
	rewind.c runtests runtests.wrk stat2.c stat.c telldir.c touchn.c truncat=
e.c
ltp/testcases/network/nfs/cthon04/special/console
	build1.bat build.bat dupreq.mak excltest.mak fstat.mak holey.mak negseek=
.mak nfsidem.mak nstat.mak op_chmod.mak op_ren.mak op_unlk.mak rename.mak=
=20
	rewind.mak stat2.mak stat.mak touchn.mak truncate.mak
ltp/testcases/network/nfs/cthon04/special/dos
	build1.bat build.bat dupreq.mak excltest.mak fstat.mak holey.mak negseek=
.mak nfsidem.mak nstat.mak op_chmod.mak op_ren.mak op_unlk.mak rename.mak=
=20
	rewind.mak stat2.mak stat.mak touchn.mak truncate.mak
ltp/testcases/network/nfs/cthon04/special/scripts
	run.bat
ltp/testcases/network/nfs/cthon04/tools
	dirdmp.c dirprt.c Makefile pmapbrd.c pmaptst.c README tcp.c tcpd.c udp.c=
 udpd.c

7)  Log Message: This guides you to the new location of CTHON04, as, thes=
e Testcases has been removed from LTP for want of GPLv2 License Agreement
File(s) Added:
ltp/testcases/network/nfs/CTHON04_README

8)  Log Message: =C2=A8ciju@linux.vnet.ibm.com=C2=A8 fixed some Script er=
rors while configuring ltp-kdump
File(s) Affected:
ltp/testcases/kdump/master
ltp/testcases/kdump/setup

9)  Log Message: KDUMP Scripts must be made executable before testing (In=
itial CVS Checkin error)
File(s) Affected:
ltp/testcases/kdump/Makefile

10) Log Message: Dont use the optional POSIX postfix operator as some cra=
ppy shells actually omit it, by =C2=A8vapier@gentoo.org=C2=A8
File(s) Affected:
ltp/testcases/network/generate.sh

11) Log Message: Included Mandatory Failed file generation and creation o=
f both outout and failed files even if absolute path is not an option to =
runltp
File(s) Affected:
ltp/runltp

12) Log Message: Ricardo cleaned up duplicate code for enhancements in ou=
tput and failed files generation
File(s) Affected:
ltp/runltp

13) Log Message: Updating  Credits to include new contributions from memb=
ers
File(s) Affected:
ltp/CREDITS

14) Log Message: Jeff Burke wanted additional INFO when the test fails in=
 the calloc portion of the test
File(s) Affected:
ltp/testcases/kernel/mem/mem/mem02.c

15) Log Message: Randy temporarily fixed the var_args expander in lib/tst=
_res.c
File(s) Affected:
ltp/lib/tst_res.c

16) Log Message: Patrick fixed the too chort char array
File(s) Affected:
ltp/testcases/open_posix_testsuite/conformance/interfaces/sem_getvalue/5-=
1.c

17) Log Message: Ricardo Fixed the way by which tst_resm should be called=
 from Shell Test Script
File(s) Affected:
ltp/runtest/tcp_cmds
ltp/testcases/network/tcp_cmds/ping/ping01

18) Log Message: James Puderer fixed -d option in LTP for better handling=
 of temporary directory
File(s) Affected:
ltp/runltp

19) Log Message: issue a warning if unable to actually test if F_SETLEASE=
 is not defined
File(s) Affected:
ltp/testcases/kernel/syscalls/fcntl/fcntl23.c
ltp/testcases/kernel/syscalls/fcntl/fcntl24.c
ltp/testcases/kernel/syscalls/fcntl/fcntl25.c
ltp/testcases/kernel/syscalls/fcntl/fcntl26.c
ltp/testcases/kernel/syscalls/fcntl/fcntl27.c
ltp/testcases/kernel/syscalls/fcntl/fcntl28.c

20) Log Message: add -D_GNU_SOURCE since we have tests in here that test =
GNU-specific features (like F_SETLEASE)
File(s) Affected:
ltp/testcases/kernel/syscalls/fcntl/Makefile

21) Log Message: Update to OpenHPI 2.10.0 (see www.openhpi.org for more i=
nfo)
File(s) Affected:
ltp/testcases/open_hpi_testsuite

--=-E81cmOWnASCL309x8OC2--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
