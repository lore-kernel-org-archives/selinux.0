Subject: Re: Issue on getting security context of socket and message
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20041109105836.79902.qmail@web51503.mail.yahoo.com>
References: <20041109105836.79902.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1100014761.408.112.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 09 Nov 2004 10:39:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-11-09 at 05:58, Park Lee wrote:
>     In flask, as we know, sockets effectively serve as communication
> proxies for processes in the Flask control model. Consequently,
> sockets are labeled with the label of the creating process by default.
> Messages are associated with both the label of their sending socket
> and a separate message label. By default, this message label is the
> same as the sending socket label.
>     Then how can we get the security context of socket and message
> respectively in linux kernel space and user space respectively (i.e.
> what functions and commands could we use to achieve our goal)? 
>     And is messages here refer to packages in network?

In the kernel, you can obtain the security context of a socket via the
security field of its associated inode.  Look at socket_has_perm() and
selinux_socket_sock_rcv_skb() in security/selinux/hooks.c for examples. 
Unix domain sockets can also use the sk_security field in the struct
sock for security state (e.g. peer SID), but INET sockets cannot safely
do so at present.  Remember that most of the LSM networking security
fields and hooks were rejected by the mainline kernel, so only limited
support exists in the current SELinux and there is no message labeling
at all.

Since sys_security was rejected by the mainline kernel, the extended
socket API of SELinux is not presently supported; we will ultimately
have to revisit it in the future when we have better motivating examples
of real applications that use it.  While fgetfilecon()->fgetxattr()
could conceivably export the security context of a local socket, that
would require implementing a fake xattr handler for the socket code;
alternative would be to implement it via getsockopt().  There is a
getpeercon(3) function in libselinux that allows you to get the context
of a peer for a Unix domain stream socket; this is internally
implemented via getsockopt().

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
