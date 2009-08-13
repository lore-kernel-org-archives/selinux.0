Subject: Re: [PATCH 2/3] security: introducing security_request_module
From: Eric Paris <eparis@redhat.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        sds@tycho.nsa.gov, davem@davemloft.net,
        shemminger@linux-foundation.org, kees@ubuntu.com, morgan@kernel.org,
        casey@schaufler-ca.com, dwalsh@redhat.com
In-Reply-To: <20090813140306.GC30731@us.ibm.com>
References: <20090813134451.29186.41664.stgit@paris.rdu.redhat.com>
	 <20090813134457.29186.7182.stgit@paris.rdu.redhat.com>
	 <20090813140306.GC30731@us.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 11:28:54 -0400
Message-Id: <1250177334.2182.88.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-08-13 at 09:03 -0500, Serge E. Hallyn wrote:
> Quoting Eric Paris (eparis@redhat.com):
> > Calling request_module() will trigger a userspace upcall which will load a
> > new module into the kernel.  This can be a dangerous event if the process
> > able to trigger request_module() is able to control either the modprobe
> > binary or the module binary.  This patch adds a new security hook to
> > request_module() which can be used by an LSM to control a processes ability
> > to call request_module().
> 
> Is there a specific case in which you'd want to deny this ability
> from a real task?

qemu and any network facing daemon are all programs I don't want to be
able to even ask the kernel to load a module.  Clearly you are right,
that the best protection is done by controlling access to modprobe and
the modules on disk (which we are working to fix vs what happened in the
xen fb exploit I showed earlier) but stopping it from the other
direction is, I feel, a useful defense in depth.

If they can't get modprobe called, they can't take over the system
directly, even if they did change a module or change modprobe.  I agree
it's not strong security as if they can change modprobe or modules they
might be able to just wait until something else calls modprobe (next
reboot maybe?) to take over the system.  But I'd find it very
interesting to know that a high threat target tried to do anything which
attempted to load a module....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
