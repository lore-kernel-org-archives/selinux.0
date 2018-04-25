Date: Thu, 26 Apr 2018 04:44:38 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: David Herrmann <dh.herrmann@gmail.com>
cc: linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 Eric Paris <eparis@parisplace.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
In-Reply-To: <20180423133015.5455-1-dh.herrmann@gmail.com>
Message-ID: <alpine.LRH.2.21.1804260443110.11568@namei.org>
References: <20180423133015.5455-1-dh.herrmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH 0/3] Introduce LSM-hook for socketpair(2)
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 23 Apr 2018, David Herrmann wrote:

> This patch series tries to close this gap and makes both behave the
> same. A new LSM-hook is added which allows LSMs to cache the correct
> peer information on newly created socket-pairs.

Looks okay to me.

Once it's respun with the Smack backend and maybe the hook name change, 
I'll merge this unless DaveM wants it to go in via his networking tree.


-- 
James Morris
<jmorris@namei.org>
