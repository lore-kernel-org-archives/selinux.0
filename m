Date: Mon, 22 May 2017 10:31:52 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Dan Jurgens <danielj@mellanox.com>
cc: chrisw@sous-sol.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, dledford@redhat.com, sean.hefty@intel.com,
 hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Subject: Re: [PATCH v7 7/9] selinux: Implement Infiniband PKey "Access" access
 vector
In-Reply-To: <1495198139-69993-8-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1705221031310.3502@namei.org>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
 <1495198139-69993-8-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 19 May 2017, Dan Jurgens wrote:

> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Add a type and access vector for PKeys. Implement the ib_pkey_access
> hook to check that the caller has permission to access the PKey on the
> given subnet prefix. Add an interface to get the PKey SID. Walk the PKey
> ocontexts to find an entry for the given subnet prefix and pkey.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>
