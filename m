Date: Thu, 13 Aug 2009 09:03:06 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Eric Paris <eparis@redhat.com>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        sds@tycho.nsa.gov, davem@davemloft.net,
        shemminger@linux-foundation.org, kees@ubuntu.com, morgan@kernel.org,
        casey@schaufler-ca.com, dwalsh@redhat.com
Subject: Re: [PATCH 2/3] security: introducing security_request_module
Message-ID: <20090813140306.GC30731@us.ibm.com>
References: <20090813134451.29186.41664.stgit@paris.rdu.redhat.com> <20090813134457.29186.7182.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090813134457.29186.7182.stgit@paris.rdu.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Eric Paris (eparis@redhat.com):
> Calling request_module() will trigger a userspace upcall which will load a
> new module into the kernel.  This can be a dangerous event if the process
> able to trigger request_module() is able to control either the modprobe
> binary or the module binary.  This patch adds a new security hook to
> request_module() which can be used by an LSM to control a processes ability
> to call request_module().

Is there a specific case in which you'd want to deny this ability
from a real task?

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
