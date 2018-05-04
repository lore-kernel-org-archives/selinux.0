Date: Fri, 04 May 2018 13:31:08 -0400 (EDT)
Message-Id: <20180504.133108.824679852510791586.davem@davemloft.net>
To: dh.herrmann@gmail.com
Cc: linux-kernel@vger.kernel.org, jmorris@namei.org, paul@paul-moore.com,
 teg@jklm.no, sds@tycho.nsa.gov, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, eparis@parisplace.org,
 serge@hallyn.com, casey@schaufler-ca.com, netdev@vger.kernel.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504142822.15233-3-dh.herrmann@gmail.com>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
 <20180504142822.15233-3-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [PATCH v2 2/4] net: hook socketpair() into LSM
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri,  4 May 2018 16:28:20 +0200

> Use the newly created LSM-hook for socketpair(). The default hook
> return-value is 0, so behavior stays the same unless LSMs start using
> this hook.
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Tom Gundersen <teg@jklm.no>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
