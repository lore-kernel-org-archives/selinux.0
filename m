Subject: Re: R: SELinux and SID
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <447c7567.74c94b41.609e.687a@mx.gmail.com>
References: <447c7567.74c94b41.609e.687a@mx.gmail.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 12:58:19 -0400
Message-Id: <1149008299.524.78.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-30 at 18:40 +0200, Mario Fanelli wrote:
> But are the SID invalidate to any reboot? If two object have the same
> security context, SID are equals?

A SID is an integer that refers to a security context.  SIDs are
dynamically allocated on demand, although there are a few preallocated
ones for initialization.  SIDs are not exported by the kernel to
userspace; they are purely an in-kernel abstraction.  Userspace object
managers that need to enforce policy over their own objects and
operations can also have their own private SID tables (supported by
libselinux, as part of the userspace AVC).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
