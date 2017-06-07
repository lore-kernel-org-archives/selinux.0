Message-ID: <1496859237.15470.12.camel@tycho.nsa.gov>
Subject: Re: icmp and rawip socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Wed, 07 Jun 2017 14:13:57 -0400
In-Reply-To: <20170607173742.GA739@julius.enp8s0.d30>
References: <20170607173742.GA739@julius.enp8s0.d30>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-06-07 at 19:37 +0200, Dominick Grift wrote:
> Was it intentional to add icmp_socket class? Because this use to be
> rawip_socket. rawip_socket includes more than just icmp (IGMP/OSPF)
> but still I thought that the extended socket classes only applied to
> what is otherwise generic "socket"

It was intentional, yes, and described in the patch description (for
both the kernel and refpolicy) and in the inline documentation for the
policy capability in refpolicy.  I chose to address all known gaps in
our ability to distinguish among sockets at once.

Note btw that icmp_socket is only used for the unprivileged ICMP
sockets (aka "ping sockets") created via socket(PF_INET, SOCK_DGRAM,
IPPROTO_ICMP) or socket(PF_INET6, SOCK_DGRAM, IPPROTO_ICMP6). 
rawip_socket is still used for SOCK_RAW ICMP sockets.
 
