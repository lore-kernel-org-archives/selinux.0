Date: Wed, 1 Mar 2017 13:11:52 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: james.l.morris@oracle.com, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, jslaby@suse.cz, selinux@tycho.nsa.gov,
 xiaolong.ye@intel.com
Subject: Re: [PATCH] selinux: fix kernel BUG on prlimit(..., NULL, NULL)
In-Reply-To: <1488292508-32506-1-git-send-email-sds@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.20.1703011311340.4214@namei.org>
References: <1488292508-32506-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 28 Feb 2017, Stephen Smalley wrote:

> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git#next-queue


-- 
James Morris
<jmorris@namei.org>
