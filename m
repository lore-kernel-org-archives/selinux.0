Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s59EqqT9032255
 for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2014 10:52:53 -0400
Message-ID: <5395CAA0.4010900@tresys.com>
Date: Mon, 9 Jun 2014 10:54:24 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Refpolicy Mail List <refpolicy@oss1.tresys.com>, SELinux Mail List
 <selinux@tycho.nsa.gov>
Subject: ANN: Reference Policy moved to GitHub
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since open source development workflows have moved towards services like GitHub and Bitbucket, we have decided to move Reference Policy's repositories to GitHub.  The project wiki is now available here:

https://github.com/TresysTechnology/refpolicy/wiki

The repository can be checked out using the following:

$ git clone https://github.com/TresysTechnology/refpolicy.git
$ cd refpolicy
$ git submodule init
$ git submodule update

Alternatively, use GitHub's forking features to clone the repositories to your own GitHub account.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
