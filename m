Subject: Re: [PATCH] add selpolgen
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <45ACEE9E.7000709@mentalrootkit.com>
References: <45ACEE9E.7000709@mentalrootkit.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 10:45:13 -0500
Message-Id: <1169135113.22731.285.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-16 at 10:26 -0500, Karl MacMillan wrote:
> This is a patch (available for download because of size - see url below) 
> to add a python library named selpolgen and a new version of audit2allow 
> that uses this library. This is a minimally changed version of what I 
> have been calling madison.
> 
> I am submitting this for inclusion as part of the main selinux 
> distribution. I believe that inclusion here will help make good policy 
> generation tools develop sooner and give a common base for creating new 
> tools.
> 
> Questions:
> * I have the library at the top-level of the project - like the C 
> libraries. Is this the best location? What about the name?

The top-level location seems sane, but the naming and structure diverges
from the C libraries (e.g. one might expect a libsepolgen with man,
include, src, and tests subdirectories and ChangeLog, COPYING, Makefile,
and VERSION files).  I don't know what python libraries generally look
like.  selpolgen is also a bit confusing with MITRE's tool, although
that may not be important as it seems OBE.  You could just call it
libmadison unless there is a conflict.

> * Should the old audit2allow be retained in any form? I've tried to make 
> this a drop-in replacement, but there are likely regressions / changes. 
> There are also a few options still missing that I will add soon.

Unless there is a significant regression, I'd advocate just dropping the
old one (and also finally removing audit2allow.perl, the original perl
version that was moved aside when the python rewrite was merged).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
