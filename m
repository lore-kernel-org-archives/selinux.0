Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s5QFNWuk005131
 for <selinux@tycho.nsa.gov>; Thu, 26 Jun 2014 11:23:32 -0400
Message-ID: <53AC3AEB.3090001@tresys.com>
Date: Thu, 26 Jun 2014 11:23:23 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: ANN: SELinux Userspace moved to GitHub
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Since open source development workflows have moved towards services like
GitHub and Bitbucket, we have decided to move the SELinux Userspace
repositories to GitHub. The project wiki is now available here:

  https://github.com/SELinuxProject/selinux/wiki

The repository can be checked out using the following:

  $ git clone https://github.com/SELinuxProject/selinux.git

Or if you already have the repository checked out, you can change to the
new location via:

  $ git remote set-url origin https://github.com/SELinuxProject/selinux.git

Alternatively, use GitHub's forking features to clone the repositories
to your own GitHub account.


Likewise, we have moved the CIL repository to GitHub. The CIL wiki is
now available here:

  https://github.com/SELinuxProject/cil/wiki

With the new repo location:

  $ git clone https://github.com/SELinuxProject/cil.git
