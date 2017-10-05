Message-ID: <59D65A03.2000202@iogearbox.net>
Date: Thu, 05 Oct 2017 18:12:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Chenbo Feng <chenbofeng.kernel@gmail.com>, netdev@vger.kernel.org,
 SELinux <Selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org
CC: Chenbo Feng <fengc@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20171004182932.140028-1-chenbofeng.kernel@gmail.com>	
 <20171004182932.140028-4-chenbofeng.kernel@gmail.com>
 <1507210095.27146.5.camel@tycho.nsa.gov>
In-Reply-To: <1507210095.27146.5.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH net-next 3/4] selinux: bpf: Add selinux check
 for eBPF syscall operations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/05/2017 03:28 PM, Stephen Smalley wrote:
[...]
>> +static int selinux_bpf_prog(struct bpf_prog *prog)
>> +{
>> +	u32 sid = current_sid();
>> +	struct bpf_security_struct *bpfsec;
>> +
>> +	bpfsec = prog->aux->security;
>
> I haven't looked closely at the bpf code, but is it guaranteed that
> prog->aux cannot be NULL here?  What's the difference in lifecycle for
> bpf_prog vs bpf_prog_aux?  Could the aux field be shared across progs
> created by different processes?

prog->aux cannot be NULL here, its lifetime is 1:1 with prog,
it holds slow-path auxiliary data unlike prog itself which is
additionally set to read-only after initial setup until teardown;
aux is also never shared across BPF progs, so always 1:1 relation
to prog itself.

Things that can be shared across multiple BPF programs and user
space processes are BPF maps themselves. From user space side
they can be passed via fd or pinned/retrieved from bpf fs, so
as currently implemented the void *security member you'd hold
in struct bpf_map would refer to the initial creator process of
the map here that doesn't strictly need to be alive anymore;
similarly for prog itself, when its shared between multiple
user space processes, *security ctx would point to the one that
installed it into the kernel initially.
