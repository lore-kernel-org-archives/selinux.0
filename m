Subject: Re: libselinux behavior in permissive mode wrt invalid domains
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>
References: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 15 Apr 2009 08:16:52 -0400
Message-Id: <1239797812.27560.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-04-14 at 14:42 -0400, Colin Walters wrote:
> Hi,
> 
> I'd like broader input on:
> http://bugs.freedesktop.org/show_bug.cgi?id=21072
> 
> Is this something we can do inside libselinux itself?  Or are we
> planning similar patches around avc_has_perm calls for the X server,
> libvirt and other userspace programs?

I agree with you - this should be handled within libselinux if it gets
handled at all, not in the callers of avc_has_perm().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
