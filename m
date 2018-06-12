From: Peter Enderborg <peter.enderborg@sony.com>
To: <peter.enderborg@sony.com>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 Daniel Jurgens <danielj@mellanox.com>, Doug Ledford
 <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Serge E . Hallyn" <serge@hallyn.com>
Date: Tue, 12 Jun 2018 10:08:59 +0200
Message-ID: <20180612080912.7827-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 00/13 selinux-next] selinux: Cleanup printk logging
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch replaces printk with pr_* for the selinux files.
I get a lot of checkpatch warnings when doing my other work,
lets get rid of the warnings.

For the policydb.c there also a removal of KERN_CONT with
two longer prints.

I have NOT cleaned up splitting lines with long prints. I think
the current conclusion is that it is better to have long lines
that it to have splitting print lines.

There is one patch per file for this files:
conditional.c
ebitmap.c	 
policydb.c
avtab.c
hooks.c	  
avtab.c	  
services.c	  
selinuxfs.c	  
netlink.c	  
sidtab.c	  
netport.c	  
netif.c	  
avc.c	 
netnode.c   
