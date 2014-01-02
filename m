Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s02NjCtx000625
 for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2014 18:45:12 -0500
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux patches for 3.14
Date: Thu, 02 Jan 2014 18:45:06 -0500
Message-ID: <231455217.pFFWomdpV7@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

With 3.13-rc6 out, it looks like it is time to pass along the SELinux pull 
request for 3.14.  The tree below includes the patches listed here as well as 
the 3.13-rcX fixes I've sent you previously (I've omitted the 3.13-rcX fixes 
in the list below for the sake of clarity).  Of the five new patches here, all 
but Richard's patch are fixes, and minor ones at that.

On a sorta related note, over the past month or two, I've learned that my 
simplistic approach to managing the SELinux tree is just a wee bit too 
simplistic.  After the 3.14 merge window closes I'm going to move to a branch 
based approach which should make things a bit easier for everyone (okay, 
mostly me) when it comes to -next and -stable.

Enjoy,
-Paul

---

The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:

  Linux 3.12 (2013-11-03 15:41:51 -0800)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux master

----------------------------------------------------------------
                                                                             
Paul Moore (8):                                                                 
      Merge tag 'v3.12'                                                         
      selinux: ensure that the cached NetLabel secattr matches the desired SID  
      selinux: pull address family directly from the request_sock struct        
                                                                                
Richard Haines (1):                                                             
      SELinux: Update policy version to support constraints info                
                                                                                
Tim Gardner (1):                                                                
      SELinux: security_load_policy: Silence frame-larger-than warning          
                                                                                
Wei Yongjun (1):                                                                
      SELinux: remove duplicated include from hooks.c

-- 
paul moore
security and virtualization @ redhat
