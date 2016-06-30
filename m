From: Daniel Jurgens <danielj@mellanox.com>
To: Paul Moore <pmoore@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "chrisw@sous-sol.org"
 <chrisw@sous-sol.org>, "dledford@redhat.com" <dledford@redhat.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, "sean.hefty@intel.com"
 <sean.hefty@intel.com>, "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>
Subject: Re: [PATCH 03/12] selinux: Implement Infiniband flush callback
Date: Thu, 30 Jun 2016 20:39:34 +0000
Message-ID: <AM4PR0501MB225711F81F1E2904ABD5142CC4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
 <1466711578-64398-4-git-send-email-danielj@mellanox.com>
 <20160630151005.GC22107@yuval-lap.uk.oracle.com>
 <AM4PR0501MB22578AA5FF8B4062F650C581C4240@AM4PR0501MB2257.eurprd05.prod.outlook.com>
 <CAGH-Kgtn0EFxYc+UOvVQk-0Bco0oOG=STZA+aGYza4TmbNXq3A@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 6/30/2016 2:52 PM, Paul Moore wrote:
> I'm still working on understanding IB, but my current thinking is very
> similar to Yuval's suggestions.  There is a risk of creating a general
> purpose mechanism to solve a specific, isolated problem, but adding a
> LSM notification mechanism does seem like a reasonable thing to do.
>
> My current thinking is to have the LSM framework itself, e.g.
> security/security.c, maintain a list of callbacks (BTW, please make it
> a RCU protected list) with other non-LSM subsystems registering
> callbacks, and specific LSMs making notification calls into the LSM
> framework itself which would handle iterating through the registered
> callbacks.  Since we're going down the general purpose solution route,
> I might add an event field and a void pointer to the callback, for
> example:
>
>   void lsm_notifier_callback(unsigned int event, void *ptr);
>
> ... I would expect at first we would only have a POLICY_CHANGE event
> (ptr set to NULL), but we may want/need to add other events in the
> future.
>
> Make sense?

Yes, I think so.  I'll make this change.
