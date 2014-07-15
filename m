Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6FERF2g021991
 for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2014 10:27:15 -0400
From: Paul Moore <pmoore@redhat.com>
To: Christian Evans <frodox@zoho.com>
Subject: Re: NetLabel lead to kernel panic with some SELinux levels
Date: Tue, 15 Jul 2014 10:27:15 -0400
Message-ID: <1586883.dRC2px0RBW@sifl>
In-Reply-To: <147394c7bdf.1664242132703898203.-4933980174869987134@zoho.com>
References: <147394c7bdf.1664242132703898203.-4933980174869987134@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, July 15, 2014 01:25:07 PM Christian Evans wrote:
> While using network with configured NetLabel it lead to kernel panic on some
> SELinux levels.
> 
> I used netlabel_tools-0.19-7.el6.x86_64.rpm and kernel rhel7
> 3.10.0-123.el7.x86_64. Also I reproduced it on RHEL 6.3/7.0, CentOs
> 6.5/7.0, Fedora 20. That is what I have been tested. I think it can be
> reproduced on older versions/kernels too.

Thanks for reporting this, I've been able to reproduce this on at least one 
system and I'm looking into it now.

-- 
paul moore
security and virtualization @ redhat
