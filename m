Date: Thu, 7 Dec 2017 10:51:28 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Paul Moore <pmoore@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <151257617428.11847.3254426726512996878.stgit@chester>
Message-ID: <alpine.LFD.2.20.1712071051200.8348@localhost>
References: <151257617428.11847.3254426726512996878.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH] selinux: skip bounded transition processing if
 the policy isn't loaded
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 6 Dec 2017, Paul Moore wrote:

> From: Paul Moore <paul@paul-moore.com>
> 
> We can't do anything reasonable in security_bounded_transition() if we
> don't have a policy loaded, and in fact we could run into problems
> with some of the code inside expecting a policy.  Fix these problems
> like we do many others in security/selinux/ss/services.c by checking
> to see if the policy is loaded (ss_initialized) and returning quickly
> if it isn't.
> 
> Reported-by: syzbot <syzkaller-bugs@googlegroups.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>
