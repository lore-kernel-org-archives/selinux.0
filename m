Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3BNCsIl031078
 for <selinux@tycho.nsa.gov>; Mon, 11 Apr 2016 19:12:54 -0400
Date: Mon, 11 Apr 2016 17:12:50 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Daniel Jurgens <danielj@mellanox.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Subject: Re: [RFC PATCH v2 00/13] SELinux support for Infiniband RDMA
Message-ID: <20160411231250.GB5861@obsidianresearch.com>
References: <1459985638-37233-1-git-send-email-danielj@mellanox.com>
 <20160411201155.GC371@obsidianresearch.com>
 <DB5PR05MB111168B6670B36F12979705BC4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
 <20160411221210.GA5861@obsidianresearch.com>
 <DB5PR05MB1111E6A72480FF78AAB12747C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB5PR05MB1111E6A72480FF78AAB12747C4940@DB5PR05MB1111.eurprd05.prod.outlook.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Apr 11, 2016 at 10:30:54PM +0000, Daniel Jurgens wrote:

> > SMI is not umad. SMI should only refer to the SMA access channel on a
> > specific node, and I have no idea why someone would want to restrict
> > local SMA access independently of generic umad qp0 access. Just call
> > it QP0 or QP1 or umad.
> > 
> > SMI is an obscure internal term that should not be user facing.
 
> The point of control here is MAD agent registration and MAD transmit and
> receive.  When a MAD agent is created it inherits the security ID of
> it's parent task.  For MAD agents that have a QP of type IB_QPT_SMI,
> when an attempt is made to send a MAD the security ID of the MAD agent
> is checked for access to the SMI vector of the IB device (to become End
> Port).  This is only for MAD agents that have a qp with of type
> IB_QPT_SMI.  So having umad as the access vector is too broad.

Like I said, the user facing name should be QP0 in that case.

Jason
