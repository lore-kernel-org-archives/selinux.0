Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t756sC23030927
 for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2015 02:54:13 -0400
Received: by pabxd6 with SMTP id xd6so10866280pab.2
 for <selinux@tycho.nsa.gov>; Tue, 04 Aug 2015 23:54:10 -0700 (PDT)
Date: Wed, 5 Aug 2015 14:54:06 +0800
From: Jason Zaman <jason@perfinion.com>
To: Bond Masuda <bond.masuda@jlbond.com>
Subject: Re: How do you relabel all SELinux file contexts of an offline
 system's file system?
Message-ID: <20150805065406.GA17019@meriadoc.omgwtfbbq>
References: <55C13DA1.2070601@jlbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C13DA1.2070601@jlbond.com>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 04, 2015 at 03:33:05PM -0700, Bond Masuda wrote:
> Hello,
> 
> Normally, if I need to ensure that all the SELinux file contexts are
> correct, I run:
> 
> restorecon -R -v /
> 
> However, in the current situation, I need to do that on a system that is
> offline, where I have it's root and entire file system mounted under
> /mnt. I tried:
> 
> chroot /mnt /usr/sbin/restorecon -R -v /mnt
> 
> hoping it would have the same effect, but it does not appear to. When I
> boot the offline system, it shows a lot of SELinux mislabelings.
> 
> Is there a way to fix SELinux file contexts of another system while it
> is offline?
> 
> Thanks for any help...
> -Bond

Look at setfiles, you want something like this:

setfiles -vr /mnt/ /etc/selinux/strict/contexts/files/file_contexts /mnt/

from setfiles(8):
       -r rootpath
              use an alternate root path.

-- Jason
