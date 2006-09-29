Message-ID: <BAY114-F38B57DECF2A6270738CF26AF180@phx.gbl>
In-Reply-To: <1159550452.8496.152.camel@moss-spartans.epoch.ncsc.mil>
From: "Salvo Giuffrida" <giuffsalvo@hotmail.it>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov
Subject: Re: Where is the AVC?
Date: Fri, 29 Sep 2006 19:34:06 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov




>From: Stephen Smalley <sds@tycho.nsa.gov>
>To: Salvo Giuffrida <giuffsalvo@hotmail.it>
>CC: selinux@tycho.nsa.gov
>Subject: Re: Where is the AVC?
>Date: Fri, 29 Sep 2006 13:20:52 -0400
>
>An object manager gets access decisions from its AVC, which consults the
>security server when the decision isn't already cached.  Meanwhile, if a
>policy change occurs, the security server needs to notify the AVCs of
>all object managers of the change so that their state can be updated (in
>simplest form, by flushing the caches).  There can be any number of
>object managers.  In Linux, the entire kernel is really a single object
>manager, but in earlier microkernel-based systems, there were separate
>object managers for process management, filesystems, and networking.
>Further, even in Linux, there are userspace object managers that need to
>enforce policy over their own objects and operations, like D-BUS, X,
>Postgres, etc.  The architecture itself is general and widely
>applicable.  I doubt there is any real contradiction between the book
>and the paper, but the paper is obviously the more authoritative
>description of the architecture.  When in doubt, I'm always right ;)

If you look at figure 3-2 (if you want, I can send to you), the AVC is 
designed in kernel-space, whereas the object manager is in userspace. So, if 
the AVC is managed by the object manager, shouldn't it be in userspace?
I even still have some doubt on the real function of Object Managers: after 
they contact the AVC/S.S., they serve just for implementing "in concrete, 
low level actions" the decisions of the AVC/S.S.? Like, writing the security 
context in the xattr of a file/dir, or blocking IPC between processes? If 
so, looks like it is standard Linux kernel component (nothing new, something 
that already existed with a new name. The only different thing is the use of 
the policy interface with the AVC). Am I wrong?

>String form.  To clarify:
>2) SIDs are non-persistent, local handles (integers) that refer to
>security contexts and are mapped by the security server.  They still
>exist, but the kernel SIDs are now private to the kernel and not
>exported to userspace, unlike the original SELinux.  Userspace programs
>can create their own userspace SID mappings via the libselinux AVC,
>which is used by e.g. D-BUS and XSELinux.
SIDs are now used only for non-persistent objects?
Thanks

_________________________________________________________________
Ricerche online più semplici e veloci con MSN Toolbar! 
http://toolbar.msn.it/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
