Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBMDeRtd017045
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 08:40:27 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 3E73B20D58
 for <selinux@tycho.nsa.gov>; Tue, 22 Dec 2015 08:40:04 -0500 (EST)
Subject: Re: [RFC PATCH 13/17] calipso: Allow request sockets to be relabelled
 by the lsm.
To: Huw Davies <huw@codeweavers.com>, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <1450784813-18304-14-git-send-email-huw@codeweavers.com>
From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Message-ID: <567952B2.2080905@stressinduktion.org>
Date: Tue, 22 Dec 2015 14:40:02 +0100
MIME-Version: 1.0
In-Reply-To: <1450784813-18304-14-git-send-email-huw@codeweavers.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 22.12.2015 12:46, Huw Davies wrote:
>  	tot_len += sizeof(*opt2);
> -	opt2 = sock_kmalloc(sk, tot_len, GFP_ATOMIC);
> +	if (sk)
> +		opt2 = sock_kmalloc(sk, tot_len, GFP_ATOMIC);
> +	else
> +		opt2 = kmalloc(tot_len, GFP_ATOMIC);
>  	if (!opt2)
>  		return ERR_PTR(-ENOBUFS);

This change looks dangerous to me in terms of control of memory
depletion from a remote host. Could you use sk_to_full_sk and account
options towards the listener socket?
