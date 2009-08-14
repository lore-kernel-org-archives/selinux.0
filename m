Date: Fri, 14 Aug 2009 11:56:23 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        sds@tycho.nsa.gov, davem@davemloft.net,
        shemminger@linux-foundation.org, kees@ubuntu.com, morgan@kernel.org,
        casey@schaufler-ca.com, dwalsh@redhat.com
Subject: Re: [PATCH 1/3] Networking: use CAP_NET_ADMIN when deciding to call
 request_module
In-Reply-To: <20090813134451.29186.41664.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.0908141155290.12192@tundra.namei.org>
References: <20090813134451.29186.41664.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 13 Aug 2009, Eric Paris wrote:

> The networking code checks CAP_SYS_MODULE before using request_module() to


I applied all three patches to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

and fixed up the documentation per Serge's suggestion.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
