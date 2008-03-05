Subject: Re: PATCH: avoid -Werror for parser-generated sources
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com
In-Reply-To: <200803041926.m24JQKmi010144@cadmus.columbia.tresys.com>
References: <200803041926.m24JQKmi010144@cadmus.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 09:22:22 -0500
Message-Id: <1204726942.1397.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-04 at 14:26 -0500, Todd C. Miller wrote:
> As alluded to the other day, I have a large patch to checkpolicy.
> 
> The changes are purely mechanical.  Everything but the yacc rules has
> been moved from policy_parse.c into policy_define.c and policy_define.h.
> This allows us to retain strict error checking (-Werror) on the SELinux
> toolchain without our being tripped up by generated (yacc/bison) code.
> 
> The diff is over the list limit and is not really something that can 
> be broken up further so I've put it up for download at:
>     http://www.gratisoft.us/todd/policy_define.diff
> 
> Signed-off-by: Todd C. Miller <tmiller@tresys.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will on the trunk.

I've already tagged for a release, so this won't affect it.

> 
>  Makefile        |    3
>  policy_define.c | 3831 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  policy_define.h |   58
>  policy_parse.y  | 3839 --------------------------------------------------------
>  4 files changed, 3895 insertions(+), 3836 deletions(-)
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
