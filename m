Subject: Re: Other unused permissions(Re: swapon unsuppoted?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200510201443.j9KEhRHp013290@mms-r00.iijmio.jp>
References: <200510121517.j9CFHl11010821@mms-r01.iijmio.jp>
	 <200510201443.j9KEhRHp013290@mms-r00.iijmio.jp>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 08:52:52 -0400
Message-Id: <1129899172.2375.577.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-10-20 at 10:43 -0400, Yuichi Nakamura wrote:
> I also found following seem to be unused( in linux 2.6.12-1.1398_FC4).
> 
> * netif : enforce_dest 

Correct - that was specific to one of the extended socket calls in the
original SELinux API.  Not sure it will ever be revived.

> * socket common :ioctl, append, lock, relabelfrom, relabelto, recvfrom,setattr

You need to be careful here; some of these permissions are inherited
from file, so the file checks in the code may be applicable to a socket
object as well.  A variety of calls act on file descriptors that might
refer to a socket, such as ioctl, fcntl, flock, fchmod, etc, even though
it may not make sense to use them on a socket in all cases.  Thus,
ioctl, append, lock, and setattr are possible.  relabelfrom and
relabelto should eventually be restored; it should be possible to
implement relabeling support for sockets via fsetxattr (requires a
kernel change, but not an interface change).  recvfrom is presently
unused and its original meaning essentially subsumed by other network
permission checks (*_recv on netif and node).

> * unix_stream_socket: newconn, acceptfrom

Since these are local sockets, the acceptfrom check was always
extraneous here - the connectto check is sufficient.  newconn was
related to the extended socket call API, not sure if it will ever be
revived.

> * tcp_socket: connectto, newconn, acceptfrom

connectto/acceptfrom might be revived once the labeled networking
support (via IPSEC) is mainstreamed.  newconn again was related to the
extended socket API.

> Some permissions seem to be defined for compatibility, 
> will these be active again in the future?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
