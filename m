Subject: RE: seinfo and binary policy endianness
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: ltcgcw@us.ibm.com, "'SELinux'" <SELinux@tycho.nsa.gov>,
   "'Emily Ratliff'" <ratliff@austin.ibm.com>
In-Reply-To: <200509301406.j8UE65Ys007552@gotham.columbia.tresys.com>
References: <200509301406.j8UE65Ys007552@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 10:23:23 -0400
Message-Id: <1128090203.12459.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 10:06 -0400, Karl MacMillan wrote:
> Thanks - I'll get this integrated. Why should borrowed.h go away? We can't
> rely on libsepol to be stable, and one of the main defining characteristics
> of libapol is that it maintains backwards compatibility. We can read any
> policy format from pre-version 12 to current policies. That would be
> difficult to do relying on libsepol.

Not sure what you mean by "stable".  You would use the static libsepol,
just like recent versions of slat, so you don't need a stable ABI from
the shared lib.

libsepol supports all policy versions 15 and later (i.e. everything ever
supported by a 2.6 kernel), and I'm a little dubious that policy 12 has
much life left to it (and in any event, you could always maintain that
separately for that particular use).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
