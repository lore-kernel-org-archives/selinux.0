Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3BMCECc017758
 for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2016 18:12:14 -0400
Date: Mon, 11 Apr 2016 16:12:10 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 00/13] SELinux support for Infiniband RDMA
Message-ID: <20160411221210.GA5861@obsidianresearch.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <20160411201155.GC371@obsidianresearch.com>
 <DB5PR05MB111168B6670B36F12979705BC4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB5PR05MB111168B6670B36F12979705BC4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 11, 2016 at 08:38:50PM +0000, Daniel Jurgens wrote:

> > This seems superficially similar to netlabel, which I guess targets a
> > certain niche, but I'm really wondering with all the other container
> > patches if this was supposed to be done with namespaces...
> 
> I can't speak to the goals of the other container patches.
> 
> Netlabel can't label kernel bypassed packets.  It can be used for IPoIB
> though.

I guess I'm surprised the first pass at this wasn't to ride on
netlabel at least for all the parts that use IPoIB for addressing (eg
typical rdmacm)

> >> An Infiniband device (ibdev) is labeled by name and port number.  There is a
> >> single access vector for ibdevs as well, called "smi".
> > 
> > This is called an End Port (SMI is something else in the IB
> > spec). Please use the standard terminology.
> I see your point on the end port, I'll address this is the next series
> by updating the commit messages and replacing ibdev with ibendport.
> 
> I don't understand where you think I've gone wrong on SMI.

Well, this makes no sense:
 There is a single access vector for ibdevs as well, called "smi".

SMI is not umad. SMI should only refer to the SMA access channel on a
specific node, and I have no idea why someone would want to restrict
local SMA access independently of generic umad qp0 access. Just call
it QP0 or QP1 or umad.

SMI is an obscure internal term that should not be user facing.

Jason
