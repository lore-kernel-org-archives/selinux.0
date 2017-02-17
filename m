Date: Fri, 17 Feb 2017 14:24:46 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 james.l.morris@oracle.com, paul@paul-moore.com, jslaby@suse.cz
Subject: Re: [PATCH] prlimit,security,selinux: add a security hook for prlimit
In-Reply-To: <1487256718-26141-1-git-send-email-sds@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.20.1702171424020.4873@namei.org>
References: <1487256718-26141-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 16 Feb 2017, Stephen Smalley wrote:

> When SELinux was first added to the kernel, a process could only get
> and set its own resource limits via getrlimit(2) and setrlimit(2), so no
> MAC checks were required for those operations, and thus no security hooks
> were defined for them. Later, SELinux introduced a hook for setlimit(2)
> with a check if the hard limit was being changed in order to be able to
> rely on the hard limit value as a safe reset point upon context
> transitions.

[...]


Queued for 4.11 at
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git#next-queue




-- 
James Morris
<jmorris@namei.org>
