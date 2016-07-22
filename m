Date: Fri, 22 Jul 2016 10:46:52 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Dan Jurgens <danielj@mellanox.com>, chrisw@sous-sol.org,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, dledford@redhat.com,
 sean.hefty@intel.com, hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Subject: Re: [PATCH v2 5/9] selinux: Create policydb version for Infiniband
 support
Message-ID: <20160722164652.GA19770@obsidianresearch.com>
References: <1468537011-20407-1-git-send-email-danielj@mellanox.com>
 <1468537011-20407-6-git-send-email-danielj@mellanox.com>
 <CAHC9VhTRQ_jvdOPn-eszzHkb1+HL7ySaM5qK2pgX=9GFdjOcpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHC9VhTRQ_jvdOPn-eszzHkb1+HL7ySaM5qK2pgX=9GFdjOcpg@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 22, 2016 at 12:29:25PM -0400, Paul Moore wrote:
> We had a discussion about this in the last patchset and I think things
> may have gotten confused.  From what I remember, according to the IB
> developers the proper term is "end port"; if that is true, we probably
> should use "end port", but I would prefer if we drop the underscore in
> most of the places, e.g. "ib_endport" instead of "ib_end_port".

Yes, the proper term is end port, (contrasted with switch port).

Jason
