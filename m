Subject: Re: PATCH: libselinux-1.34.0 bit type usage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd.Miller@sparta.com
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200702071710.l17HA1WA014028@tex.courtesan.com>
References: <200702071710.l17HA1WA014028@tex.courtesan.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:28:22 -0500
Message-Id: <1171985302.14363.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-07 at 12:10 -0500, Todd.Miller@sparta.com wrote:
> libselinux uses a mix of bit type styles: BSD-style (u_XXint_t), Linux
> kernel style (uXX), and C99 (uintXX_t).  The following patch makes
> things consistent by replacing use of BSD and Linux kernel styles with
> the standard C99 bit types from stdint.h.  Most files included stdint.h
> already.

Merged to -stable and to -trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
