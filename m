Date: Mon, 22 May 2017 10:13:16 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Dan Jurgens <danielj@mellanox.com>
cc: Chris Wright <chrisw@sous-sol.org>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, dledford@redhat.com,
 sean.hefty@intel.com, hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Subject: Re: [PATCH v7 2/9] IB/core: Enforce PKey security on QPs
In-Reply-To: <1495198139-69993-3-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1705220959450.3502@namei.org>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
 <1495198139-69993-3-git-send-email-danielj@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 19 May 2017, Dan Jurgens wrote:

> security/security.c                  | 385 ++++++++++++++++++++++

This looks wrong -- merge problem?


> +	if (pps->alt.state != IB_PORT_PKEY_NOT_VALID) {
> +		get_pkey_and_subnet_prefix(&pps->alt,
> +					   &pkey,
> +					   &subnet_prefix);
> +
> +		ret = enforce_qp_pkey_security(pkey,
> +					       subnet_prefix,
> +					       sec);
> +	}
> +
> +	if (ret)
> +		goto out;

The above if/goto is unnecessary.

> +
> +out:
> +	return ret;
> +}



-- 
James Morris
<jmorris@namei.org>
