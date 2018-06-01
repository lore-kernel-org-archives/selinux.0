Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w51BgB6X008647
 for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2018 07:42:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 40y2Vp1Nc1z2Vp8w
 for <selinux@tycho.nsa.gov>; Fri,  1 Jun 2018 11:42:10 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 40y2Vm3L7qz2Vp8T
 for <selinux@tycho.nsa.gov>; Fri,  1 Jun 2018 11:42:08 +0000 (UTC)
Date: Fri, 1 Jun 2018 04:41:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>, lustre-devel@lists.lustre.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 devel@driverdev.osuosl.org, selinux@tycho.nsa.gov
Message-ID: <20180601114151.GA25225@infradead.org>
References: <20180601091133.GA27521@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180601091133.GA27521@kroah.com>
Subject: Re: [PATCH] staging: lustre: delete the filesystem from the
 tree.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks,

all that churn without much visible progress to a mergeable codebase
was really ennoying.

I'd recommend if people want to merge lustre they start with a managable
subset first, e.g. the fs client code with simple IP-only networking.
