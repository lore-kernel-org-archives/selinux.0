Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7T7m4rT028876
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 03:48:05 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7T7lBwc022526
	for <selinux@tycho.nsa.gov>; Sun, 29 Aug 2004 07:47:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com, "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Re: rpc.mountd failure...
Date: Sun, 29 Aug 2004 17:47:47 +1000
Cc: Tom London <selinux@comcast.net>, James Morris <jmorris@redhat.com>,
   laforge@gnumonks.org
References: <412A0E73.5020001@comcast.net>
In-Reply-To: <412A0E73.5020001@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408291747.47554.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 24 Aug 2004 01:34, Tom London <selinux@comcast.net> wrote:
> Noticed the following, running .524 kernel and latest policy from Rawhide.
>
> > Aug 23 08:20:18 fedora nfs: Starting NFS services:  succeeded
> > Aug 23 08:20:18 fedora nfs: rpc.rquotad startup succeeded
> > Aug 23 08:20:18 fedora nfs: rpc.nfsd startup succeeded
> > Aug 23 08:20:18 fedora kernel: audit(1093274418.647:0): avc:  denied
> > { name_bind } for  pid=2564 exe=/usr/sbin/rpc.mountd
> > scontext=system_u:system_r:nfsd_t
> > tcontext=system_u:object_r:ipp_port_t tclass=udp_socket
> > Aug 23 08:20:18 fedora portmap[2565]: connect from 127.0.0.1 to
> > set(mountd): request from unprivileged port
> > Aug 23 08:20:18 fedora rpc.mountd: unable to register (mountd, 3, udp).
> > Aug 23 08:20:18 fedora nfs: rpc.mountd startup failed
> > Aug 23 08:20:18 fedora rpcidmapd: rpc.idmapd -SIGHUP succeeded

I think that this is a lack in the kernel code.

We have to prevent such access because otherwise if the NFS server is started 
or re-started when cups is not running then cups will be prevented from 
working at all.  Also in some situations you might have a running NFS server 
with no cups installed and want to install it without rebooting.

When the kernel code selects an arbitary port to bind to it should only select 
from the set of ports that the application in question is permitted to bind 
to.  This would also permit us to restrict an application to two ports (I 
believe that restricting to only one port would not work well for a restart) 
via the SE Linux policy and then use firewall rules controlling access to 
those two ports (currently trying to control access to an RPC service via 
iptables is really difficult).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
