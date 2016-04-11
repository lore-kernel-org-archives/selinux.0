Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3B1sYMC016894
 for <selinux@tycho.nsa.gov>; Sun, 10 Apr 2016 21:54:34 -0400
Date: Mon, 11 Apr 2016 11:54:13 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Kees Cook <keescook@chromium.org>, Paul Moore <pmoore@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH net-next] security: drop the unused hook skb_owned_by
In-Reply-To: <25cbac8df32da8527bac7187f606e6351862702d.1460110723.git.pabeni@redhat.com>
Message-ID: <alpine.LRH.2.20.1604111154030.8394@namei.org>
References: <25cbac8df32da8527bac7187f606e6351862702d.1460110723.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 8 Apr 2016, Paolo Abeni wrote:

> The skb_owned_by hook was added with the commit ca10b9e9a8ca
> ("selinux: add a skb_owned_by() hook") and later removed
> when said commit was reverted.
> 
> Later on, when switching to list of hooks, a field named
> 'skb_owned_by' was included into the security_hook_head struct,
> but without any users nor caller.
> 
> This commit removes the said left-over field.
> 
> Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next

-- 
James Morris
<jmorris@namei.org>
