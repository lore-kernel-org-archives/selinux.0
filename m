Date: Tue, 10 Nov 2015 04:16:25 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Lukasz Pawelczyk <l.pawelczyk@samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Alexey Dobriyan <adobriyan@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Calvin Owens <calvinowens@fb.com>,
 Casey Schaufler <casey@schaufler-ca.com>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Eric Paris <eparis@parisplace.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Morris <james.l.morris@oracle.com>, Jann Horn <jann@thejh.net>,
 Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
 John Johansen <john.johansen@canonical.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>,
 Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
 NeilBrown <neilb@suse.de>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <serge.hallyn@canonical.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, Tejun Heo <tj@kernel.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 containers@lists.linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Lukasz Pawelczyk <havner@gmail.com>
Subject: Re: [PATCH v4 03/11] lsm: add file opener's cred to a setprocattr
 arguments
Message-ID: <20151110041625.GA19875@ZenIV.linux.org.uk>
References: <1444826525-9758-1-git-send-email-l.pawelczyk@samsung.com>
 <1444826525-9758-4-git-send-email-l.pawelczyk@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444826525-9758-4-git-send-email-l.pawelczyk@samsung.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Oct 14, 2015 at 02:41:57PM +0200, Lukasz Pawelczyk wrote:
>  	int (*getprocattr)(struct task_struct *p, char *name, char **value);
> -	int (*setprocattr)(struct task_struct *p, char *name, void *value,
> -				size_t size);
> +	int (*setprocattr)(struct task_struct *p, const struct cred *f_cred,
> +			   char *name, void *value, size_t size);

*grumble*

Why the hell is that thing taking char *name - not even const char *?
