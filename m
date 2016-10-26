Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9QHp7Sm008622
 for <selinux@tycho.nsa.gov>; Wed, 26 Oct 2016 13:51:11 -0400
To: SELinux <selinux@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Mapping of subject context to CIPSO
Message-ID: <b2df6e05-1354-2ec0-178d-01b92cc1db85@schaufler-ca.com>
Date: Wed, 26 Oct 2016 10:51:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I am looking for a way to dump the mapping of
a process context to its associated CIPSO representation.
I could hack a kernel to do this, but if there's an
obvious way to do it already I'd rather not.

Thank you.
