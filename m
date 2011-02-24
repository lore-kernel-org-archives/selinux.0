Subject: Re: Separate type for AF_UNIX socket created by syslogd_t
From: Stephen Smalley <sds@tycho.nsa.gov>
To: HarryCiao <harrytaurus2002@hotmail.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, paul.moore@hp.com,
        selinux-mailing-list <selinux@tycho.nsa.gov>,
        refpolicy-mailing-list
 <refpolicy@oss1.tresys.com>
In-Reply-To: <SNT139-w42F5BDB103916DC8160624ABDA0@phx.gbl>
References: <SNT139-w42F5BDB103916DC8160624ABDA0@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 24 Feb 2011 13:18:26 -0500
Message-ID: <1298571506.31953.55.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-02-24 at 10:44 +0000, HarryCiao wrote:
> BTW, do we have a way to actually display the label for the
> unix_dgram_socket that bond to /dev/log?

I think the answer is no at present.
netstat -Z claims to report the socket context but is actually just
reading /proc/pid/attr/current of the owning process.

The owning application can get the context of the socket (inode) via
fgetxattr(), but I don't think a third party can presently obtain the
context information.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
