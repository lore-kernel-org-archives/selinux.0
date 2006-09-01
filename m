Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k81IgN10019090
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 14:42:23 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k81IfilZ019103
	for <selinux@tycho.nsa.gov>; Fri, 1 Sep 2006 18:41:44 GMT
Subject: Re: Using scripting languages to "macro" policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Aleks Kissinger <aleks0@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <46ffa45f0609010930h403bf000k6cbf561c1334dfef@mail.gmail.com>
References: <46ffa45f0609010930h403bf000k6cbf561c1334dfef@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 14:43:34 -0400
Message-Id: <1157136215.3199.180.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 11:30 -0500, Aleks Kissinger wrote:
> I've been poking around with the idea of using Ruby and some
> meta-programming to specify policy.  The complaint I've heard voiced
> by a couple of people is that while many of the m4-based abstractions
> present in refpolicy are pretty intuitive and useful, the limitation
> of m4 as a language is that you cannot maintain relationships and
> resolve conflicts automatically.  Therefore, in many cases you need to
> result to naming conventions to do that work.

What you're talking about is what I would call policy patterns.  Policy
patterns is one thing I plan on attacking once the role infrastructure
has been completed, but on a smaller scale.  Here are a couple patterns
I made on the side:

define(`manage_files_pattern',`
        allow $1 $2:dir rw_dir_perms;
        allow $1 $3:file manage_file_perms;
')

define(`stream_connect_pattern',`
        allow $1 $2:dir search_dir_perms;
        allow $1 $3:sock_file { getattr write };
        allow $1 $4:unix_stream_socket connectto;
')

define(`send_audit_msgs_pattern',`
        allow $1 self:capability audit_write;
        allow $1 self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
')

> The idea I put forward here is to create a set of base objects in
> Ruby, Python, or something of that ilk that can be extended and used
> to define policy in an organized, error-checking, and namespaced
> manner.  Heres a quick little example:
> 
> class LogDir < FileType
>   pattern '/var/log/.*'
> end
> 
> class SomeProgam < Application
>   executable '/usr/bin/someprog'
>   allow_role SysadminRole
>   allow self, LogDir, File, File.perms(:r, :w)
> end

I'm not sure that this is actually easier, in fact its confusing to me
(what does :r and :w mean? just read and write?).  It seems like an
unnecessary abstraction, for example allow_role.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
