Subject: Re: Restricting network communications of mounted filesystems
To: Colin Powers <Colin.Powers@nexor.com>,
 "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
References: <DB6PR0301MB25686B836200CDD7728F63829E1E0@DB6PR0301MB2568.eurprd03.prod.outlook.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e3fe3e6a-a03f-cc2f-0b98-e2b192586199@tycho.nsa.gov>
Date: Thu, 11 Aug 2016 11:52:13 -0400
MIME-Version: 1.0
In-Reply-To: <DB6PR0301MB25686B836200CDD7728F63829E1E0@DB6PR0301MB2568.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/11/2016 10:31 AM, Colin Powers wrote:
> Hi folks,
> 
> I have a question about the way network communications of mounted filesystems works with SELinux. I wonder if anyone could provide some insight or a link to somewhere with more information.
> 
> So let's say I have a RHEL6 machine with two network interfaces and I want to be very selective about which process can access which network interface.
> 
> I can use iptables SECMARK to label all traffic on eth0 as my_eth0_packet_t and all traffic on eth1 as my_eth1_packet_t, then grant send/recv permissions appropriately.
> 
> But let's say I want to be able to mount CIFS shares only using eth0. Does iptables SECMARK work in this scenario?
> If so, what process is actually doing the network communications - what SELinux type do I need to grant permission to send/recv my_eth0_packet_t?
> If not - how does the network comms work in this scenario and what are the options to achieve my goal of limiting traffic to eth0?

Disclaimer: I don't really know how CIFS works, so take this with a
grain of salt.

Looking at the kernel code, fs/cifs/connect.c calls __sock_create(),
passing 1 for the last argument (kern), so its socket is created as a
kernel-internal socket rather than a user socket. The socket is
therefore labeled with the kernel SID/context rather than any particular
userspace process context, and can be reused for multiple processes.

The socket layer access control checks are completely skipped on such
sockets (sock_has_perm handles this case specially).  The packet layer
access control checks are still applied, but they will always be between
the kernel context and the packet context.

So I don't think you can enforce this restriction for CIFS traffic on a
per-process basis currently.
