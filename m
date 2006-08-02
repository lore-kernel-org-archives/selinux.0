Message-ID: <36282A1733C57546BE392885C061859201466C35@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        tjaeger@cse.psu.edu
Subject: RE: [PATCH 10/10] MLSXFRM-v02: Auto-labeling of child sockets
Date: Wed, 2 Aug 2006 09:32:03 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> >>Am I missing something here?  Am I thinking about this wrong?
> > 
> > While selinux_socket_accept() does set/initialize the child 
> "socket's" sid
> > with the parent's sid, this sid is replaced with the one from the
> > child "sock" in selinux_sock_graft().
> > 
> > Again, are you noticing descrepancies at execution time or 
> just browsing
> > the patch? If the former, could you point to the code path?
> 
> I understand how the sk_security_struct->sid, if present, is 
> used to set
> the inode_security_struct->sid in selinux_socket_accept().  
> However, if
> I understand the code correctly in the normal accept() case the
> selinux_socket_accept() hook is called before a connection if taken of
> the accept queue, meaning that socket->sk (and hence 
> sk_security_struct)
> do not yet exist.

Not true. The child "sock" will already have been created and tied to
the request_sock before the request_sock gets onto the accept queue. Look
at:
tcp_v4_syn_recv_sock, inet_csk_reqsk_queue_add, reqsk_queue_add and
finally at inet_accept.

> The solution I'm thinking of is rather simple, if we agree 
> that this is
> a problem I can post a quick patch.

I am agreeing that "if it ain't broke, don't fix it" :)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
