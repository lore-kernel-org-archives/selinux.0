Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, dhowells@redhat.com
In-Reply-To: <1148575812.3304.45.camel@moss-tarheels.epoch.ncsc.mil>
References: <1148575812.3304.45.camel@moss-tarheels.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 26 May 2006 09:00:30 -0400
Message-Id: <1148648430.20976.216.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 12:50 -0400, Michael LeMay wrote:
> diff -uprN -X linux-2.6.17-rc4-mm3/Documentation/dontdiff linux-2.6.17-rc4-mm3.orig/security/selinux/include/av_permissions.h linux-2.6.17-rc4-mm3/security/selinux/include/av_permissions.h
> --- linux-2.6.17-rc4-mm3.orig/security/selinux/include/av_permissions.h	2006-05-24 09:01:58.000000000 -0400
> +++ linux-2.6.17-rc4-mm3/security/selinux/include/av_permissions.h	2006-05-24 11:00:08.000000000 -0400
> @@ -959,3 +959,12 @@
>  #define PACKET__SEND                              0x00000001UL
>  #define PACKET__RECV                              0x00000002UL
>  #define PACKET__RELABELTO                         0x00000004UL
> +
> +#define KEY__VIEW                                 0x00000001UL
> +#define KEY__READ                                 0x00000002UL
> +#define KEY__WRITE                                0x00000004UL
> +#define KEY__SEARCH                               0x00000008UL
> +#define KEY__LINK                                 0x00000010UL
> +#define KEY__SETATTR                              0x00000020UL
> +#define KEY__LOOKUP                               0x00000040UL
> +

I know that these symbols are auto-generated and just following our
existing convention (class__perm), but in this case, we are rather close
to a collision with the key subsystem's own definitions of its
permissions (only differing in the extra underscore).  Of course, they
are supposed to match in value with the key subsystem's own definitions
anyway so that we don't have to do any translation at permission check
time, but it seems a little worrisome.  Possibly we need to fix the
namespace issues here (via separate patch) by adding a SE_ prefix or
similar to all of these symbols.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
