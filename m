Message-ID: <36282A1733C57546BE392885C061859201466BEC@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        tjaeger@cse.psu.edu
Subject: RE: [PATCH 10/10] MLSXFRM-v02: Auto-labeling of child sockets
Date: Tue, 1 Aug 2006 18:30:04 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Paul Moore [mailto:paul.moore@hp.com]
> Sent: Tuesday, August 01, 2006 5:17 PM
> To: Venkat Yekkirala
> Cc: selinux@tycho.nsa.gov; jmorris@namei.org; sds@tycho.nsa.gov;
> tjaeger@cse.psu.edu
> Subject: Re: [PATCH 10/10] MLSXFRM-v02: Auto-labeling of child sockets
> 
> 
> Venkat Yekkirala wrote:
> > This automatically labels the TCP, Unix stream, and dccp 
> child sockets
> > as well as openreqs to be at the same MLS level as the 
> peer. This will
> > result in the selection of appropriately labeled IPSec 
> Security Associations.
> > 
> > This also uses the sock's sid (as opposed to the isec sid) 
> in SELinux enforcement
> > of secmark in rcv_skb and postroute_last hooks.
> > 
> > Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
> 
> NOTE: I dropped netdev from the cc line as this seems like more of a
> SELinux issue and not a generic network problem.
> 
> I'm in the process of merging the NetLabel patch into the MLSXFRM
> patches in DaveM's net-2.6.19 tree and I'm noticing that in general
> while the sock's sid is updated to match the incoming connection, the
> associated socket's inode is still set to the parent 
> socket/inode's sid
> and not the child sock's sid.  As a result the inode's sid and sock's

Have you noticed it in the code or in actual execution?

> sid of accept()ed connections could be different leading to 
> some strange
> (and I believe improper) behavior ...
> 
> Am I missing something here?  Am I thinking about this wrong?

While selinux_socket_accept() does set/initialize the child "socket's" sid
with the parent's sid, this sid is replaced with the one from the
child "sock" in selinux_sock_graft().

Again, are you noticing descrepancies at execution time or just browsing
the patch? If the former, could you point to the code path?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
