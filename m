Subject: Re: X11 abstract unix domain socket context question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <07D6FCA8-84E7-40B4-A1FB-38DBA6C18DBC@nall.com>
References: <07D6FCA8-84E7-40B4-A1FB-38DBA6C18DBC@nall.com>
Content-Type: text/plain
Date: Mon, 08 Sep 2008 15:49:22 -0400
Message-Id: <1220903362.19241.186.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-09-08 at 14:41 -0500, Joe Nall wrote:
> How is the file context/socket context of the X11 unix domain socket  
> computed now that it is an abstract socket?

The socket context is computed the same way regardless - that is
generic, i.e. the sid of the creating task or the one specified using
setsockcreatecon().  There is no file context when you are dealing a
socket in the abstract namespace, nor any file permission checks on it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
