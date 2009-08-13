Subject: Re: [PATCH 2/3] security: introducing security_request_module
From: Eric Paris <eparis@redhat.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        sds@tycho.nsa.gov, davem@davemloft.net,
        shemminger@linux-foundation.org, kees@ubuntu.com, morgan@kernel.org,
        casey@schaufler-ca.com, dwalsh@redhat.com
In-Reply-To: <20090813175405.GA6824@us.ibm.com>
References: <20090813134451.29186.41664.stgit@paris.rdu.redhat.com>
	 <20090813134457.29186.7182.stgit@paris.rdu.redhat.com>
	 <20090813140306.GC30731@us.ibm.com>
	 <1250177334.2182.88.camel@dhcp231-106.rdu.redhat.com>
	 <20090813175405.GA6824@us.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 14:19:10 -0400
Message-Id: <1250187550.2115.19.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-08-13 at 12:54 -0500, Serge E. Hallyn wrote:
> Quoting Eric Paris (eparis@redhat.com):
> > On Thu, 2009-08-13 at 09:03 -0500, Serge E. Hallyn wrote:
> > > Quoting Eric Paris (eparis@redhat.com):
> > > > Calling request_module() will trigger a userspace upcall which will load a
> > > > new module into the kernel.  This can be a dangerous event if the process
> > > > able to trigger request_module() is able to control either the modprobe
> > > > binary or the module binary.  This patch adds a new security hook to
> > > > request_module() which can be used by an LSM to control a processes ability
> > > > to call request_module().
> > > 
> > > Is there a specific case in which you'd want to deny this ability
> > > from a real task?
> > 
> > qemu and any network facing daemon are all programs I don't want to be
> > able to even ask the kernel to load a module.  Clearly you are right,
> 
> ...  What if the network facing daemon might want to use a kernel crypto
> module?  What if qemu needs the tun module loaded?

Loading code into the kernel is a dangerous operation.  We should find
the places where high risk processes are doing this and either choose to
accept the security risk or make sure they are loaded before the
dangerous code is run, aka libvirt knows if the guest needs the tun
device and it should be allowed to trigger it's loading.  It's shouldn't
be the guest doing the triggering.

It was also pointed out to me that stopping processes from being able to
trigger module loads could be useful to keep a subverted process from
loading an uncommon or unloaded module with a vulnerability which they
could then use to exploit the kernel.  It's all about hardening.

It won't be a simple task for SELinux policy to do something useful with
this hook as they need to identify all of the legitimate callers of
request_module(), but then again, that should be a lot easier than 90%
of what SELinux already has to do, and until SELinux policy decides to
make use of the new permission things will 'just work'

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
