Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NFb6gA027648
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 11:37:06 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NFRFNa023740
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 15:27:16 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: sshd policy
Date: Fri, 24 Jun 2005 01:27:06 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200506231632.32753.russell@coker.com.au> <1119528580.17098.19.camel@localhost.localdomain>
In-Reply-To: <1119528580.17098.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200506240127.09518.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 23 June 2005 22:09, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> > can_network_server($1_launcher_t)
>
> Protocol? Port?

I had just copied the policy from $1_t.  It seems that none of this will work, 
but if in future we find a way to make it work then you are correct that the 
above statement can be restricted.

> > allow $1_launcher_t self:unix_dgram_socket create_socket_perms;
> > allow $1_launcher_t self:unix_stream_socket
>
> create_stream_socket_perms;
> ...
>
> > allow $1_t $1_launcher_t:tcp_socket rw_socket_perms;
> > allow $1_t $1_launcher_t:unix_stream_socket rw_socket_perms;
>
> Should launcher be able to rw the dgram socket as well?

It doesn't seem to need it, I merely allowed what was necessary to get it 
working.

> Should those rules be put together, or am I misunderstanding how
> it works?

As they are different they don't go together well.

> > # do not allow statfs()
> > dontaudit $1_t fs_type:filesystem getattr;
>
> Is this sufficient? Can you look and see if samba needs this as well?
> In particular, after mounting SMB filesystem, df generates denials,
> and that's a bugzilla currently. However, I think fs_type didn't
> quite work for that case - I was seeing denials on the top level
> directory, whether it was fs_type or not. Related rules are
> also in gnome-vfs-daemon.te (not sure if that's merged).

Strange, a quick inspection of the latest rawhide policy indicates that this 
shouldn't happen.

> > allow $1_t port_type:tcp_socket name_connect;
>
> Protocol? Port?

We need sshd to connect to most/all ports.  ssh tunneling is widely used to 
create secure network access for protocols such as POP (NB POP-SSL isn't much 
use because most clients don't seem to support checking the server 
certificate).

> > if (use_samba_home_dirs) {
> > allow $1_t cifs_t:dir { search getattr };
> > allow $1_t cifs_t:file { getattr read };
> > }
>
> Please no more NFS/CIFS block of this kind - I specifically tried to
> macro-ize this. Also, why is this necessary? Why is sshd reading
> the home directories?

~/.ssh/authorized_keys

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
