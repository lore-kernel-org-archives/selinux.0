Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4ENaHx4020615
 for <selinux@tycho.nsa.gov>; Mon, 14 May 2018 19:36:17 -0400
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105])
 ([67.169.65.224])
 by smtp426.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID
 6934a590f7fa4f181e34f76104c395cf for <selinux@tycho.nsa.gov>;
 Mon, 14 May 2018 23:36:11 +0000 (UTC)
To: selinux <selinux@tycho.nsa.gov>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <991a548d-1cdc-5e15-89d9-a36a557429d2@schaufler-ca.com>
Date: Mon, 14 May 2018 16:36:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Anyone using the SELinux test suite on Fedora 28?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Has anyone had success with the SELinux test suite on Fedora 28?
I find the chcon and newrole are unhappy with the contexts used
in the suite.
