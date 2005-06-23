Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NHRRgA028827
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 13:27:27 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NHH5RO029162
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 17:17:05 GMT
Subject: Re: sshd policy
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200506240127.09518.russell@coker.com.au>
References: <200506231632.32753.russell@coker.com.au>
	 <1119528580.17098.19.camel@localhost.localdomain>
	 <200506240127.09518.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 13:15:02 -0400
Message-Id: <1119546902.4739.6.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> > > allow $1_launcher_t self:unix_dgram_socket create_socket_perms;
> > > allow $1_launcher_t self:unix_stream_socket
> >
> > create_stream_socket_perms;
> > ...
> >
> > > allow $1_t $1_launcher_t:tcp_socket rw_socket_perms;
> > > allow $1_t $1_launcher_t:unix_stream_socket rw_socket_perms;
> >
> > Should launcher be able to rw the dgram socket as well?
> 
> It doesn't seem to need it, I merely allowed what was necessary to get it 
> working.
> 
> > Should those rules be put together, or am I misunderstanding how
> > it works?
> 
> As they are different they don't go together well.

Different? One side gets the rights to create sockets, and the other
side gets the right to write to given sockets... seems like a
communication channel to me. That's why I asked about the dgram
socket.

> > > # do not allow statfs()
> > > dontaudit $1_t fs_type:filesystem getattr;
> >
> > Is this sufficient? Can you look and see if samba needs this as well?
> > In particular, after mounting SMB filesystem, df generates denials,
> > and that's a bugzilla currently. However, I think fs_type didn't
> > quite work for that case - I was seeing denials on the top level
> > directory, whether it was fs_type or not. Related rules are
> > also in gnome-vfs-daemon.te (not sure if that's merged).
> 
> Strange, a quick inspection of the latest rawhide policy indicates that this 
> shouldn't happen.

How do you figure that - test samba?
I have to admit that I haven't rechecked that in a while,
but last I checked it generated denials..

> > > allow $1_t port_type:tcp_socket name_connect;
> >
> > Protocol? Port?
> 
> We need sshd to connect to most/all ports.  ssh tunneling is widely used to 
> create secure network access for protocols such as POP (NB POP-SSL isn't much 
> use because most clients don't seem to support checking the server 
> certificate).

Okay.

> 
> > > if (use_samba_home_dirs) {
> > > allow $1_t cifs_t:dir { search getattr };
> > > allow $1_t cifs_t:file { getattr read };
> > > }
> >
> > Please no more NFS/CIFS block of this kind - I specifically tried to
> > macro-ize this. Also, why is this necessary? Why is sshd reading
> > the home directories?
> 
> ~/.ssh/authorized_keys

I don't see where it's allowed access to ROLE_home_ssh_t..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
