Date: Wed, 1 Mar 2017 13:09:23 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org, jslaby@suse.cz,
 xiaolong.ye@intel.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: fix kernel BUG on prlimit(..., NULL, NULL)
In-Reply-To: <CAHC9VhT4F-6gh=K23rEaje6Aspzp=5OCawx+LEi9HWXvd5tSZQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1703011308560.4214@namei.org>
References: <1488292508-32506-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhT4F-6gh=K23rEaje6Aspzp=5OCawx+LEi9HWXvd5tSZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 28 Feb 2017, Paul Moore wrote:

> I was going to merge this patch but upon closer inspection it appears
> that you never sent 79bcf325e6b32b3c to Linux, it is sitting in your
> next-queue branch.  What is the plan for your next-queue branch, are
> you going to merge it into your next branch after the merge window
> closes?  If so, feel free to add my ack.

Yes, at -rc1.

> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks.


-- 
James Morris
<jmorris@namei.org>
