Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB9IN43R023444
 for <selinux@tycho.nsa.gov>; Wed, 9 Dec 2015 13:23:04 -0500
From: "Higgs, Stephen" <Stephen.Higgs@icfi.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: mcs design help
Date: Wed, 9 Dec 2015 18:22:17 +0000
Message-ID: <17785f5ed91b4948872f64fa18dfb31f@VNUCITEX02.ICFI.icfconsulting.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi All,

I'm looking for any implementation suggestions for my following the following: on a database server that restricts logins to confined users, allow selinux users with sysadm_r the ability to administer most aspects of the system, but restrict access to some mysql database files.

I approached this by labeling the mysql database files with an mcs category (c127), and then added a domain transition to the mysqld process to run with a context that includes c127.  The confined login was configured to initialize with s0:c0.  Finally (and I'm really not sure this was the best way), I needed to ensure the administrator could not disable/circumvent selinux so I added the following restriction to the newrole and setenforce binaries (c0.c1023).

My test user (also in the sudoers file) can do administrative functions, cannot access the database files, and cannot disable selinux.  Any suggestions on how to improve on what I have done?

--Stephen
