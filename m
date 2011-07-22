Subject: Re: is "type poisoning" possible?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Zoltan Arnold NAGY <zoltan.arnold.nagy@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAGFYgbPN41ax88SYosv2e4_RBvc6k3R+hV07vsBiyTZiUreKVw@mail.gmail.com>
References: 
	 <CAGFYgbPN41ax88SYosv2e4_RBvc6k3R+hV07vsBiyTZiUreKVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 22 Jul 2011 10:03:18 -0400
Message-ID: <1311343398.20800.29.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-07-18 at 12:45 +0200, Zoltan Arnold NAGY wrote:
> Hi,
> 
> I apologize in advance if my use of nomenclature is a bit sloppy. I'm
> new to this. :)
> 
> Let's say I have a process with type P, but it needs a config file.
> 
> Is there a way to specify that if P accesses any file having a type Q, then
> the process type should transition to T?

If you mean you want the process type (domain) to automatically
transition upon reading a file, SELinux doesn't presently support
transitions on read or write, only on exec or via explicit setcon.

> This would allow to mitigate attacks where specific config changes are allowed
> (but are always coupled with a relabeling to type Q), but we don't
> trust the changer.

Typically we would address that by not allowing read access to
unauthorized types and thus the process wouldn't be able to read
anything other than its authorized config file (or other authorized
inputs).

> A side question would be how to force this relabeling to take place
> automatically?

We generally try to minimize relabeling at runtime, as it poses problems
for analysis of policy and revocation of access.  Originally we only
supported process type transitions on exec, and only later added
setcon(3) as a practical accommodation for certain applications.
Automatic transitions on read/write would be even further down the path
of label non-tranquility.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
