Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0IHD1dN009980
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 12:13:01 -0500
Received: from host496.ipowerweb.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0IHDtih001544
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 17:13:56 GMT
From: "Tom Fortmann" <tfortmann@xcapesolutions.net>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "'James Morris'" <jmorris@namei.org>
References: <003801c739a6$461871f0$030a0a0a@ACER> <1168977133.22731.149.camel@moss-spartans.epoch.ncsc.mil> <006801c73a73$643b81e0$030a0a0a@ACER> <1169124492.22731.199.camel@moss-spartans.epoch.ncsc.mil>
Subject: RE: FW: Current/Future Plans to Support Stacking LSM Modules
Date: Thu, 18 Jan 2007 11:13:51 -0600
Message-ID: <00a101c73b24$069aacd0$030a0a0a@ACER>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1169124492.22731.199.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen,

We are currently working at the netfilter level.  We have a working
netfilter module that examines packets in a NF_IP_LOCAL_IN and
NF_IP_LOCAL_OUT hook.  The problem with working at this level is the
additional complexity involved with altering the data.  Any change in the
application data value or length causes changes in the IP and TCP headers.
Moving up above layer 3 would eliminate these issues and simplify our
design.

It looks like the selinux_socket_sock_rcv_skb() hook may give me what I need
on the receive side - access to received data after the layers 3 processing
is complete.  Can you point me to more detailed information on how this hook
works and what can and can't be done to the skb at this time?  Also, is
there a similar hook on the transmit side?

Thanks again for helping me work through the learning curve of SELinux.

Thomas Fortmann
Sr. Software Engineer
Xcape Solutions, Inc.

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Thursday, January 18, 2007 6:48 AM
To: Tom Fortmann
Cc: selinux@tycho.nsa.gov; James Morris
Subject: RE: FW: Current/Future Plans to Support Stacking LSM Modules

On Wed, 2007-01-17 at 14:09 -0600, Tom Fortmann wrote:
> Stephen,
> 
> The security measures we are trying to implement require us to actually
> inspect, and in some case modify, the application data flowing over a
socket
> connection.  Our goal is to secure legacy server applications at the
socket
> layer.  We have done some proof of concept work at the netfilter layer,
but
> the ultimate solution is better suited above the TCP/IP packet layer.
> 
> Does SELinux provide a mechanism for us to do this, and or does it call
the
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
