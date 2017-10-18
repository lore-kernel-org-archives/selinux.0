Date: Wed, 18 Oct 2017 14:11:55 +0100 (WEST)
Message-Id: <20171018.141155.1830215730026401984.davem@davemloft.net>
To: chenbofeng.kernel@gmail.com
Cc: netdev@vger.kernel.org, Selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, jeffv@google.com,
 alexei.starovoitov@gmail.com, lorenzo@google.com, daniel@iogearbox.net,
 sds@tycho.nsa.gov, james.l.morris@oracle.com, paul@paul-moore.com,
 fengc@google.com
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171018.134729.837318478487425125.davem@davemloft.net>
References: <20171016191135.8046-1-chenbofeng.kernel@gmail.com>
 <20171018.134729.837318478487425125.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Subject: Re: [PATCH net-next v6 0/5] bpf: security: New file mode
 and LSM hooks for eBPF object permission control
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: David Miller <davem@davemloft.net>
Date: Wed, 18 Oct 2017 13:47:29 +0100 (WEST)

> Series applied.

I had to revert as this breaks the build:

net/netfilter/xt_bpf.c: In function ¡__bpf_mt_check_path¢:
net/netfilter/xt_bpf.c:59:7: error: too few arguments to function ¡bpf_obj_get_user¢
  fd = bpf_obj_get_user(path);
       ^~~~~~~~~~~~~~~~
