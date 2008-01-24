Date: Fri, 25 Jan 2008 01:59:02 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: I am more worried about open then read and write, SELinux needs
 open access checks.
In-Reply-To: <1201181600.21288.33.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0801250157460.17829@us.intercode.com.au>
References: <4797B92E.7050901@redhat.com>  <1201180112.21288.11.camel@moss-spartans.epoch.ncsc.mil>
 <1201181600.21288.33.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Jan 2008, Stephen Smalley wrote:

> 
> BTW, given that it entails a non-trivial amount of work, it would be
> good to roll in any other desired permission additions at the same time
> if possible.  For example, we've also talked about adding a 'map' check
> on mmap and mprotect so that we can distinguish memory mapped access
> (since it has different implications for revocation).

Added these to http://selinuxproject.org/page/Kernel_Development

Please update that todo list if something like this is discussed & seem a 
candidate for being done at some point (or email someone with an account).


-- 
James Morris <jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
