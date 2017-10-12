Date: Thu, 12 Oct 2017 11:31:34 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Chenbo Feng <chenbofeng.kernel@gmail.com>
cc: netdev@vger.kernel.org, SELinux <Selinux@tycho.nsa.gov>,
 linux-security-module@vger.kernel.org,
 Jeffrey Vander Stoep <jeffv@google.com>,
 Lorenzo Colitti <lorenzo@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Chenbo Feng <fengc@google.com>
In-Reply-To: <20171004182932.140028-3-chenbofeng.kernel@gmail.com>
Message-ID: <alpine.LFD.2.20.1710121129510.17334@t440.gateway.2wire.net>
References: <20171004182932.140028-1-chenbofeng.kernel@gmail.com>
 <20171004182932.140028-3-chenbofeng.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH net-next 2/4] security: bpf: Add LSM hooks for
 bpf object related syscall
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 4 Oct 2017, Chenbo Feng wrote:

>  int bpf_map_new_fd(struct bpf_map *map, int flags)
>  {
> +	if (security_bpf_map(map, OPEN_FMODE(flags)))
> +		return -EPERM;
> +

Don't hardcode -EPERM here, return the actual error from 
security_bpf_map().

> +	if (security_bpf_prog(prog))
> +		return -EPERM;
> +

Same.

> +	err = security_bpf(cmd, &attr, size);
> +	if (err)
> +		return -EPERM;

Same.


- James
