Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s48KYSZH005126
 for <selinux@tycho.nsa.gov>; Thu, 8 May 2014 16:34:28 -0400
Received: by mail-qa0-f47.google.com with SMTP id s7so3132459qap.34
 for <selinux@tycho.nsa.gov>; Thu, 08 May 2014 13:34:29 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@tycho.nsa.gov, vlad halilov <vlad.halilov@gmail.com>
Subject: Re: selinux and static label for sVirt
Date: Thu, 08 May 2014 16:34:26 -0400
Message-ID: <1675546.P9Rft7smSN@sifl>
In-Reply-To: <CAHw9pMX-T9CHgahLLKjAfA_tOeFuKSwniikV_-ejw3GsCOQW0Q@mail.gmail.com>
References: <CAHw9pMX-T9CHgahLLKjAfA_tOeFuKSwniikV_-ejw3GsCOQW0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, May 08, 2014 05:45:56 PM vlad halilov wrote:
> Hello. I trying to run kvm wih mls policy on RHEL6.5 and got strange error.
> 
> Steps:
> 
> 1) installing with virtulaization software bundle;
> 2) install selinux mls and some more: xorg-x11-xauth policycoreutils-python
> selinux-policy-mls netlabel_tools setools-console;
> 3) enable mls in selinux/config, set permissive mode, autorelabel fs &
> reboot;
> 4) login by root@ssh with X (permissive mode still in effect) and create vm.
> 
> Now, after creating any vm, it can executed only with dynamic label. On
> trying to set static label (s0, s1 or any other with compartments) i got
> an error:
> 
> 2014-05-08 13:23:06.711+0000: 1607: error
> 
> :virSecuritySELinuxGenSecurityLabel:552 : unable to allocate socket
> security context 's0': Invalid argument

If you are going to use static labels with sVirt you need to specify the 
entire SELinux label and not just the MLS field.  I recommend searching for 
the "Red Hat Enterprise Linux 6 Virtualization Security Guide" for more 
information on using sVirt with RHEL6.

-- 
paul moore
www.paul-moore.com
