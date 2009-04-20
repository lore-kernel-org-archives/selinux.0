Date: Mon, 20 Apr 2009 13:35:38 -0400
Subject: Re: access(2) vs. SELinux
From: Chad Sellers <csellers@tresys.com>
To: Eric Paris <eparis@redhat.com>, Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <C6122AAA.A6957%csellers@tresys.com>
In-Reply-To: <1240248082.2562.75.camel@localhost.localdomain>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 4/20/09 1:21 PM, "Eric Paris" <eparis@redhat.com> wrote:
<snip>
> 
> I'm going to spend a couple minutes and try to prototype an all in
> kernel solution such that on access() we will check the permission:
> 
> allow process_t file_t:file read
> 
> if there is a dontaudit rule for EITHER "read" or "access_read" we will
> NOT print an avc denial.
> 
> on the actual usage we will ONLY check for the "read" dontaudit.
> 
That sounds like a better solution than anything we've talked about so far.
It would mean the policy author would only have to worry about the access_*
perms if they cared about the issue they're designed to solve. Hopefully you
can find an acceptable way to pull it off in the kernel. I'm rooting for
you!

Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
