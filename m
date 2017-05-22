Date: Mon, 22 May 2017 10:26:09 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Dan Jurgens <danielj@mellanox.com>
cc: chrisw@sous-sol.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, dledford@redhat.com, sean.hefty@intel.com,
 hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Subject: Re: [PATCH v7 6/9] selinux: Allocate and free infiniband security
 hooks
In-Reply-To: <1495198139-69993-7-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1705221025540.3502@namei.org>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
 <1495198139-69993-7-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 19 May 2017, Dan Jurgens wrote:

> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Implement and attach hooks to allocate and free Infiniband object
> security structures.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>
