Date: Sat, 9 Sep 2017 08:09:01 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
 John Johansen <john.johansen@canonical.com>,
 James Morris <james.l.morris@oracle.com>, gregkh@linuxfoundation.org,
 serge@hallyn.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1709090808200.15026@namei.org>
References: <20170908164001.21138-1-sds@tycho.nsa.gov>
 <CAHC9VhSga+mg8VTtVoafdbpQ2K62PEBGrWidB8SUwWtRO+hahA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH] usb, signal, security: only pass the cred,
 not the secid, to kill_pid_info_as_cred and security_task_kill
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 8 Sep 2017, Paul Moore wrote:

> Looks fine to me from a SELinux perspective.  If Casey and John are
> happy with this I can volunteer to pull it into the selinux/next tree
> (once the merge window closes), otherwise if someone else wants to
> merge this my ack is below.
> 

As this impacts multiple LSMs, I'd prefer to take it via my tree.


-- 
James Morris
<jmorris@namei.org>
