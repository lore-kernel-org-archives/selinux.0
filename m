Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27198
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 11:08:00 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA20302
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 16:07:59 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil  with ESMTP id QAA20298
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 16:07:58 GMT
Received: from coalstove.epoch.ncsc.mil (coalstove [144.51.25.13])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19032
	for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2001 11:07:57 -0500 (EST)
Date: Fri, 16 Mar 2001 11:07:56 -0500 (EST)
From: hdholm@epoch.ncsc.mil (Howard Holm)
Message-Id: <200103161607.LAA06866@coalstove.epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Updated release
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

An updated release of Security-enhanced Linux has been posted on the
NSA web site (www.nsa.gov/selinux).

Changes include:

- Updated information on the developers' mailing list and archives was
  made available.
- Answers to Frequently Asked Questions were added to the site. 
- Kernel patches are now provided for 2.4.2 and 2.2.18. 
  - The 2.4.2 patch includes changes to virtualize the persistent SID
    mapping interfaces and the file mandatory access controls.
  - The 2.2.18 patch includes several bug fixes to the old 2.2-based
    patch. It also includes a new implementation of System V IPC
    mandatory access controls. These controls have not yet been ported to
    the 2.4 kernel.
  - Both the 2.2.18 and 2.4.2 patches incorporate a change in the
    implementation of the new system calls that is not backward
    compatible with the old implementation. Hence, the updated libsecure
    must be compiled and all modified utilities must be relinked against it.
- The util-linux patch is now provided for the util-linux-2.10s sources
  from kernel.org.
- The procps patch is now provided for the procps-010114 sources from
  http://www.cs.uml.edu/~acahalan/procps.
- The vixie-cron patch is now provided for the vixie-cron-3.0.1-61
  sources from RedHat.
- A small fix was made to the spasswd wrapper program to ensure that it
  is not mistakenly used by an administrator to try to change another
  user's password. A README was added to explain the purpose of this
  program.
- The shadow password file is no longer moved by the installation
  scripts, and the modified versions of libpwdb, sulogin, and the shadow
  utilities are no longer provided. The relocation of the shadow password
  file was creating compatibility problems with a number of applications
  despite the updatedlibpwdb. A different approach for maintaining a
  separate security context on the shadow password file will be
  implemented in the future.
- The modified versions of rshd and wu-ftpd were removed from the
  distribution and each of these daemons were limited to their initial
  domain in the example policy configuration.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Information Assurance Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
