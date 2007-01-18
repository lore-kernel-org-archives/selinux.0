Subject: RE: FW: Current/Future Plans to Support Stacking LSM Modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tom Fortmann <tfortmann@xcapesolutions.net>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>
In-Reply-To: <006801c73a73$643b81e0$030a0a0a@ACER>
References: <003801c739a6$461871f0$030a0a0a@ACER>
	 <1168977133.22731.149.camel@moss-spartans.epoch.ncsc.mil>
	 <006801c73a73$643b81e0$030a0a0a@ACER>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 07:48:12 -0500
Message-Id: <1169124492.22731.199.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-01-17 at 14:09 -0600, Tom Fortmann wrote:
> Stephen,
> 
> The security measures we are trying to implement require us to actually
> inspect, and in some case modify, the application data flowing over a socket
> connection.  Our goal is to secure legacy server applications at the socket
> layer.  We have done some proof of concept work at the netfilter layer, but
> the ultimate solution is better suited above the TCP/IP packet layer.
> 
> Does SELinux provide a mechanism for us to do this, and or does it call the
> secondary LSM hooks that provide this type of access.  Specifically the
> socket_xxxx hooks?

I'm not clear as to why you can't use a netfilter module.  SELinux
provides socket and network access controls through a combination of LSM
hooks and netfilter, and the SELinux SECMARK mechanism lets you label
packets using iptables and control them using policy.   See
selinux_socket_sock_rcv_skb() (registered via LSM) and
selinux_ip_postroute_last() (registered via netfilter).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
