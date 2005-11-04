Subject: Re: changes in ~2.6.13 break postfix policy?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Erich Schubert <erich@debian.org>
Cc: Russell Coker <russell@coker.com.au>, James Morris <jmorris@namei.org>,
   SELinux@tycho.nsa.gov
In-Reply-To: <1131106145.28236.7.camel@wintermute.xmldesign.de>
References: <1131106145.28236.7.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 08:46:09 -0500
Message-Id: <1131111969.23420.208.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-04 at 13:09 +0100, Erich Schubert wrote:
> Hi,
> I'm running the same policy on a couple of similar systems.
> All of them run postfix, and logcheck (so they frequently do send
> emails)
> 
> On the systems running 2.6.13 or 2.6.14 I get errors similar to the
> following:
> avc:  denied  { read } for  pid=3247 comm="pickup" name="[197650]"
> dev=sockfs ino=197650 scontext=system_u:system_r:postfix_pickup_t
> tcontext=system_u:system_r:postfix_pickup_t tclass=sock_file
> avc:  denied  { write } for  pid=3247 comm="pickup" name="[197650]"
> dev=sockfs ino=197650 scontext=system_u:system_r:postfix_pickup_t
> tcontext=system_u:system_r:postfix_pickup_t tclass=sock_file
> avc:  denied  { getattr } for  pid=14416 comm="qmgr" name="[197661]"
> dev=sockfs ino=197661 scontext=system_u:system_r:postfix_qmgr_t
> tcontext=system_u:system_r:postfix_qmgr_t tclass=sock_file
> for just about every socket postfix uses.
> 
> The socket "files" all have system_u:object_r:postfix_private_t, though.
> 
> I don't see the same errors on machines with an older selinux kernel.
> Any idea whats wrong?

This suggests that SELinux is mis-classifying socket inodes (which
should have *_socket classes) as socket file inodes (which have the
sock_file class).  In inode_doinit (upon d_instantiate), SELinux
classifies file inodes based on the inode mode, but both socket inodes
and socket file inodes have the same inode mode (S_IFSOCK).  However,
SELinux should be classifying socket inodes from its socket-specific
hooks (selinux_socket_post_create and selinux_socket_accept), so they
should be classified correctly.  Any subsequent invocation of
d_instantiate upon the socket inode shouldn't disturb the class already
set by the socket hooks, as it is no longer the initial default of file.

There was a change between 2.6.11 and 2.6.12 (removal of i_sock field
from struct inode, which allowed us to distinguish sockets from socket
files in inode_doinit itself) in the mainline kernel that required a
change to the way in which SELinux was classifying the inodes, but not
between 2.6.12 and 2.6.13 AFAIK.   Do you see the behavior with a 2.6.12
kernel as well?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
