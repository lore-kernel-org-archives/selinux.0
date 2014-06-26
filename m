Message-ID: <53AC26E5.2040006@tycho.nsa.gov>
Date: Thu, 26 Jun 2014 09:57:57 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>
Subject: Re: Fwd: Booting time is increased after applying kernel 3.10
References: <CAEFn6A4mzF208e1s_OHEzJ-1Kq-DUGgzVNbQXrW6NbB0e8DSpQ@mail.gmail.com>
 <CAB9W1A3HhfPimsRB4Qtf91hCM8u2Ds+yzK9XBYr6eEcdDP+wWQ@mail.gmail.com>
 <58493927.vocElXfMed@sifl>
 <CAB9W1A2VnkCh3ru7ZKST0e55DnpMxPEbzDdczwDY7o0tsZdjnw@mail.gmail.com>
In-Reply-To: <CAB9W1A2VnkCh3ru7ZKST0e55DnpMxPEbzDdczwDY7o0tsZdjnw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jaejyn Shin <flagon22bass@gmail.com>, selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/25/2014 03:49 PM, Stephen Smalley wrote:
> I suspect it won't matter in practice, but the reason for it is that
> permissions or other state may have been cached during bootup prior to
> initial policy load that may no longer be valid.

So, as far as the netif/node/port caches are concerned, the potential
concern is that if we perform any netif/node/port SID lookups prior to
initial policy load, then the kernel security server will always return
the netif/node/port initial SIDs, and those SIDs will be cached for any
such interfaces, IP addresses, or port numbers looked up prior to the
policy load and continue to be used after the policy load even if the
policy defines a different context for that interface, address, or port.
 This should only be an issue if some action is performed that would
trigger a netif/node/port lookup prior to initial policy load (e.g.
network interface configuration, binding to a network port, sending or
receiving a packet), and if the policy defines a netif, node, or port
context other than the one associated with the initial netif, node, or
port SIDs for any such interface, address, or port.

So in Android at least it is a non-issue (policy is loaded by init from
the initramfs before any network interface configuration).  I'm a bit
unclear on what happens in Fedora these days from the initramfs, and how
it might deal with e.g. a nfsroot or something similar where network
interfaces may be configured and network traffic may already be
occurring before policy can be loaded from the real root filesystem.

As far as the AVC state is concerned, security_compute_av() will return
all-permissions-allowed until policy is first loaded, so the AVC may
contain cached permissions for the kernel SID for any requested
permissions prior to initial policy load, which is why we flush its
contents.  However, this should only matter for the kernel SID.

We will also perform an avc_ss_reset() on the setenforce 1 by init if
the system is enforcing to flush any permissions added to the AVC while
permissive.  So even if we were to drop the avc_ss_reset() from the
initial policy load, we would still get it on enforcing systems as a
side effect of the setenforce 1.  However, that could yield different
avc denials on a permissive vs enforcing system.

So I am not sure we can safely remove the avc_ss_reset() from initial
policy load in the mainline kernel, as we are not guaranteed that there
is no network interface configuration prior to initial policy load and
we are not guaranteed that there will be a setenforce 1.  It would
perhaps be better there to instead just avoid calling synchronize_net
altogether if possible or only call it once for the entire avc_ss_reset,
not on each of the netif/node/port callbacks.
