Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAKLoQ0A017093
 for <selinux@tycho.nsa.gov>; Fri, 20 Nov 2015 16:50:26 -0500
Received: by qgea14 with SMTP id a14so81878542qge.0
 for <selinux@tycho.nsa.gov>; Fri, 20 Nov 2015 13:49:10 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov, linux-audit@redhat.com
Cc: linux-security-module@vger.kernel.org
Subject: ANN: Experimental Fedora Rawhide kernels (selinux-next and audit-next)
Date: Fri, 20 Nov 2015 16:49:08 -0500
Message-ID: <8944982.Ef97cAsKlg@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

For the past few weeks I've been building experimental Fedora Rawhide kernels 
with all of the SELinux and audit kernel patches targeted for linux-next 
included. It has worked out reasonably well, and with the exception of getting 
a working Linux 4.4-rc1 build this week, it has proven to be relatively easy 
to manage. If you would like to help with testing and don't mind the 
instability that comes with development kernels, the Fedora COPR repository 
link is below.

I've been doing at least one build each week, sometimes more, and I expect to 
continue with that frequency. I also perform a quick sanity check on each 
successful build, including running the SELinux and audit testsuites; however, 
there may be times when the kernel is simply broken, so exercise caution and 
please don't run these kernels on anything critical.

 * https://copr.fedoraproject.org/coprs/pcmoore/kernel-secnext

-- 
paul moore
www.paul-moore.com
