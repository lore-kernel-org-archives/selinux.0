Subject: Re: Object class and permissions documentation
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Selinux Dev'" <selinux-dev@tresys.com>, James Morris <jmorris@redhat.com>
In-Reply-To: <200404221748.i3MHm8Jx026239@gotham.columbia.tresys.com>
References: <200404221748.i3MHm8Jx026239@gotham.columbia.tresys.com>
Content-Type: text/plain
Message-Id: <1082660168.10587.156.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 22 Apr 2004 14:56:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-04-22 at 13:48, Karl MacMillan wrote:
> We are posting this in the hopes that it might be useful, but please note
> that the permission descriptions are only a rough initial version and might
> be incomplete or inaccurate. Please send any updates or suggestions for
> changes to these descriptions, or any other part of this document, to
selinux@tresys.com.

Thanks for working on this document, as an up-to-date document
describing the classes, permissions, and permission checks per operation
would be useful.  Note that the original technical report had such
tables for the original implementation, and the module report had the
permission check tables for the LSM hooks in the earlier LSM-based
SELinux.  Some comments below:

- No point in repeating common permissions for each class; describe once
and note inheritance.

- Class and permission lists should be grouped logically where
appropriate (e.g. all file-related classes together, read/write/execute
together, setattr/getattr together).

- It would help understanding to list the pair of entities involved in
each permission check, e.g. ptrace - Control ability of a process to
ptrace a given target process.  udp_recv - Control ability of a socket
to receive UDP packets from a given network interface.

- Class file has two additional permissions beyond the common set.

- Some permissions are included in common sets merely to be available
in more than one class, but are not actually applicable to all classes
that inherit (a more general inheritance mechanism would be useful). So
you may want to note permissions that are actually not valid for a given
class and should not be granted.

- The redesign/reimplementation of the network access controls in 2.6
caused changes to the semantics of some of the existing socket and
network permissions, not just the addition of new permissions. 
Examples:
-- send_msg/recv_msg were formerly a socket-to-packet check for labeled
networking, and irrelevant in the absence of labeled networking.  The
permission names were reclaimed for use by the new socket-to-port checks
in 2.6.  Correspondingly, the SID equality check is gone. 
- sendto/recvfrom were formerly a socket-to-peer-socket check for
labeled networking, and irrelevant in the absence of labeled
networking.  They are not used at all presently for INET sockets. 
sendto is still used for Unix datagram sockets for the
socket-to-peer-socket check.  recvfrom is presently unused; we could
certainly implement it for Unix datagram, but it becomes redundant with
sendto as the IPC is local.
- netif recv checks were formerly packet-to-netif (can this packet be
received on this netif?) for labeled networking, and irrelevant in the
absence of labeled networking.  The checks were changed to
socket-to-netif (i.e. can this socket receive from this netif?) in 2.6.
netif send checks were formerly packet-to-netif (can this packet be
sent on this netif?) and are now socket-to-netif (can this socket send
on this netif?) but that change is mostly invisible as outbound packets
were inheriting their SID from the sending socket by default anyway.
- connectto/newconn/acceptfrom were formerly socket-to-peer-socket or
socket-to-newconnectionsocket checks.  They are not presently used for
INET sockets.  connectto is still used for Unix stream sockets.
acceptfrom and newconn are unused.
- enforce_dest is presently unused; had to do with the extended socket
call API in the older SELinux.
- node_bind controls the binding to an IPv4 or IPv6 address
(socket-to-node).

- Class passwd permissions have to do with skipping authentication, e.g.
set another user's password or other information without having to know
the user's old password, su'ing to an account without needing the
password, etc.  Not just updating of state.

- Class dir permission reparent - might want to note that the
reparenting of the directory occurs via rename for clarity.

- Class security permissions - they aren't used to set information
(other than load, setenforce, setbool); they are used to get security
decisions.  selinuxfs exports the old policy API; the process writes the
policy query to the node, and then reads back the response, using a
file-local buffer.

- System V IPC classes - unix_read and unix_write are coarse-grained
permissions that parallel the existing Linux checks.  See the module
report's discussion of changes from the original SELinux kernel patch.

- A number of the system permissions you list are not present in the
current policy (and the number is wrong).

- Note that fifo_file is used for both fifos in the filesystem and
pipes.  Pipes are labeled with the context of the creating process,
whereas the fifos in the filesystem have a file context.

- Don't confuse sock_file and sockets.  Different objects (inodes) with
different labels, but associated with one another.  Connecting to a Unix
stream socket requires write permission to the file object and connectto
permission to the socket object.

- noatsecure disables the default AT_SECURE flag on a context change, so
that glibc secure mode is not enabled in that case and the caller can
influence the new context.  Useful for trusted callers that expect to be
able to set up the environment or other characteristics of the callee.

- Class process permission getattr isn't about file attributes.

- setexec controls ability to exec context at all.  Other permissions
(transition, entrypoint, etc) control the particular context that may
be used for a given exec.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
