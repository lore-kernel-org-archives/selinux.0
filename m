Date: Fri, 20 Oct 2017 11:54:20 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Chenbo Feng <chenbofeng.kernel@gmail.com>
cc: netdev@vger.kernel.org, SELinux <Selinux@tycho.nsa.gov>,
 linux-security-module@vger.kernel.org,
 Jeffrey Vander Stoep <jeffv@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, lorenzo@google.com,
 Daniel Borkmann <daniel@iogearbox.net>,
 Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>,
 Chenbo Feng <fengc@google.com>
In-Reply-To: <20171018200026.146093-4-chenbofeng.kernel@gmail.com>
Message-ID: <alpine.LFD.2.20.1710201153050.11171@t440.gateway.2wire.net>
References: <20171018200026.146093-1-chenbofeng.kernel@gmail.com>
 <20171018200026.146093-4-chenbofeng.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH net-next v7 3/5] security: bpf: Add LSM hooks
 for bpf object related syscall
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 18 Oct 2017, Chenbo Feng wrote:

> From: Chenbo Feng <fengc@google.com>
> 
> Introduce several LSM hooks for the syscalls that will allow the
> userspace to access to eBPF object such as eBPF programs and eBPF maps.
> The security check is aimed to enforce a per object security protection
> for eBPF object so only processes with the right priviliges can
> read/write to a specific map or use a specific eBPF program. Besides
> that, a general security hook is added before the multiplexer of bpf
> syscall to check the cmd and the attribute used for the command. The
> actual security module can decide which command need to be checked and
> how the cmd should be checked.
> 
> Signed-off-by: Chenbo Feng <fengc@google.com>


Acked-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>
