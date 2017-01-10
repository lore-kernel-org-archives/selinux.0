Date: Tue, 10 Jan 2017 19:23:21 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: paul@paul-moore.com, selinux@tycho.nsa.gov, yangshukui@huawei.com,
 casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
 james.l.morris@oracle.com
Subject: Re: [PATCH] security,selinux,smack: kill security_task_wait hook
Message-ID: <20170110182321.GA32298@redhat.com>
References: <1484069312-26653-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484069312-26653-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/10, Stephen Smalley wrote:
>
> As reported by yangshukui, a permission denial from security_task_wait()
> can lead to a soft lockup in zap_pid_ns_processes() since it only expects
> sys_wait4() to return 0 or -ECHILD. Further, security_task_wait() can
> in general lead to zombies; in the absence of some way to automatically
> reparent a child process upon a denial, the hook is not useful.  Remove
> the security hook and its implementations in SELinux and Smack.  Smack
> already removed its check from its hook.
>
> Reported-by: yangshukui <yangshukui@huawei.com>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Great ;)

Acked-by: Oleg Nesterov <oleg@redhat.com>
