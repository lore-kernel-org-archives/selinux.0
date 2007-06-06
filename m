Subject: Re: [PATCH 1/2] libselinux: class and permission mapping support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <4666D5E6.508@tycho.nsa.gov>
References: <4666D5E6.508@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 11:59:36 -0400
Message-Id: <1181145576.3699.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-06 at 11:42 -0400, Eamon Walsh wrote:
> This provides support for userspace object managers to register a
> mapping of class and permission values.  After the mapping is
> registered all libselinux functions that take a security class
> or permission value must be provided with mapped values instead
> of the "real," kernel values.
> 
> Changes from the original interface proposal: No selinux_init()
> function, just a straight set_mapping() function.  Also, to
> simplify things the incoming mapping does not include explicit
> values; the classes and permissions are numbered implicitly by
> their ordering.  NULL strings are used to terminate the lists.
> 
> Tested with X server, no problems encountered.
> 
> This patch includes the interface and implementation of the
> mapping set function.

Can you post a snippet of code from the X server showing the usage of
this interface by an object manager?

I was thinking that we weren't going down this route due to
complexity/performance concerns about having to remap the access vectors
on checks, but it doesn't look too bad from your patches, especially
since the mapping happens on compute_av and the AVC can just always use
the mapped values.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
