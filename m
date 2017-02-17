Date: Sat, 18 Feb 2017 09:55:58 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul@paul-moore.com>
cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 jslaby@suse.cz, Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>
Subject: Re: [PATCH] prlimit,security,selinux: add a security hook for prlimit
In-Reply-To: <CAHC9VhSxXcXkvPrLM3tjhqMxdK8kwEt2AWB46Pqc3PqomA3qMw@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.1702180955330.31346@namei.org>
References: <1487256718-26141-1-git-send-email-sds@tycho.nsa.gov>
 <alpine.LRH.2.20.1702171424020.4873@namei.org>
 <CAHC9VhSxXcXkvPrLM3tjhqMxdK8kwEt2AWB46Pqc3PqomA3qMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 17 Feb 2017, Paul Moore wrote:

> > Queued for 4.11 at
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git#next-queue
> 
> Stephen pushed a v2 patch to fix a build problem, are you going to
> fixup your tree?

Yep, I reverted the first patch and applied the v2.


-- 
James Morris
<jmorris@namei.org>
