Message-ID: <526E5D5C.8010505@tycho.nsa.gov>
Date: Mon, 28 Oct 2013 08:49:32 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: SELinux List <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        Eric Paris <eparis@redhat.com>
Subject: Re: avc_has_perm() returns -1 even when SELinux is in permissive
 mode
References: <20131027144337.5b89c5a8@fornost.bigon.be>
In-Reply-To: <20131027144337.5b89c5a8@fornost.bigon.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/27/2013 09:43 AM, Laurent Bigonville wrote:
> Hello,
> 
> After some debugging on Debian to figure out why D-Bus why denying
> messages between my user session and policykit with SELinux in
> permissive mode, eparis pointed me that Fedora has a patch for this in
> the avc_has_perm() function.
> 
> The patch[0] itself seems pretty trivial and I was wondering if it (or
> something similar) could be merged in the upstream codebase.
> 
> But, if I'm not wrong, this patch makes avc_has_perm() and
> avc_has_perm_noaudit() have different behavior when the machine is
> running in permissive mode, shouldn't this be tested in the
> avc_has_perm_noaudit() function instead?

I'm pretty sure I NAKed that previously.  Permissive mode isn't supposed
to hide other kinds of errors/bugs other than policy denials, so making
it hide arbitrary error conditions (which could include completely bogus
security contexts, security classes, memory allocation failure, etc) is
definitely not a good thing.  Particularly if there is absolutely no
logging of what the issue was so that you have a hope of noting it
before switching to enforcing.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
