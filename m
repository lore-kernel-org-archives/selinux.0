Subject: Re: [PATCH v4 2/2] selinux:  generate flask headers during kernel
 build
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4AC2C32D.3010405@ak.jp.nec.com>
References: <1254244173.2252.138.camel@moss-pluto.epoch.ncsc.mil>
	 <1254244459.2252.143.camel@moss-pluto.epoch.ncsc.mil>
	 <1254247383.2252.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4AC2C32D.3010405@ak.jp.nec.com>
Content-Type: text/plain
Date: Wed, 30 Sep 2009 11:25:19 -0400
Message-Id: <1254324319.30591.59.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-30 at 11:32 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:
> > There are several legacy permissions that are no longer used by SELinux.
> > We could remove these from the kernel's classmap.h definitions without
> > breaking anything (subsequent permissions would get mapped to policy
> > values appropriately by the new logic), but removing them from the
> > policy would be harder as it would break all kernels that predate these
> > patches.  Thus, I'm not sure we benefit from removing them from
> > classmap.h.
> > 
> > The unused permissions include:
> > # LSM hook never merged to mainline
> > file swapon
> > # compat_net=1 checks
> > socket { recv_msg send_msg }
> > # Only added so that subsequent permissions (execmod) would get the same value as class file
> > chr_file { execute_no_trans entrypoint }
> > # Original socket controls; never merged to mainline
> > tcp_socket { connectto newconn acceptfrom }
> > # legacy network or compat_net=1 checks
> > node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send enforce_dest dccp_recv dccp_send }
> > # legacy network or compat_net=1 checks
> > netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send }
> > # Original socket controls; never merged to mainline - only connectto is used
> > unix_stream_socket { newconn acceptfrom }
> > # Patches merged prematurely by Fedora, never merged to mainline
> > packet { flow_in flow_out }
> 
> It is just a report. I could not reach origin of the matter yet.
> 
> When I applies your patch as is, build, install and reboot,
> I could not find any *obvious* matter (such as boot failed). Good.
> 
> Then, I modified the classmap.h for the test purpose.
> The object classes and access vectors are ramdomized as the
> attached claasmap.h.
> This patch enables to map value of them using text identifier,
> so we can expect it works fine independent from the order of
> classes and access vectors.

Your classmap.h file violates the requirement that the kernel
definitions for the common file perms and common sock perms line up with
each other for the set of permissions checked by file hooks that can be
applied to either files or sockets.  I noted that as a caveat in one of
my messages.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
