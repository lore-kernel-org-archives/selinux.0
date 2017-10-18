Message-ID: <59E7C42D.1010402@iogearbox.net>
Date: Wed, 18 Oct 2017 23:14:21 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
MIME-Version: 1.0
To: Chenbo Feng <chenbofeng.kernel@gmail.com>, netdev@vger.kernel.org,
 SELinux <Selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org
CC: Jeffrey Vander Stoep <jeffv@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, lorenzo@google.com,
 Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>,
 Paul Moore <paul@paul-moore.com>, Chenbo Feng <fengc@google.com>
References: <20171018200026.146093-1-chenbofeng.kernel@gmail.com>
 <20171018200026.146093-2-chenbofeng.kernel@gmail.com>
In-Reply-To: <20171018200026.146093-2-chenbofeng.kernel@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Subject: Re: [PATCH net-next v7 1/5] bpf: Add file mode
 configuration into bpf maps
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/18/2017 10:00 PM, Chenbo Feng wrote:
> From: Chenbo Feng <fengc@google.com>
>
> Introduce the map read/write flags to the eBPF syscalls that returns the
> map fd. The flags is used to set up the file mode when construct a new
> file descriptor for bpf maps. To not break the backward capability, the
> f_flags is set to O_RDWR if the flag passed by syscall is 0. Otherwise
> it should be O_RDONLY or O_WRONLY. When the userspace want to modify or
> read the map content, it will check the file mode to see if it is
> allowed to make the change.
>
> Signed-off-by: Chenbo Feng <fengc@google.com>
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
