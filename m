Subject: Re: [PATCH 2/2] - use common av_to_string implementation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <43DFBDCD.8010506@tresys.com>
References: <43DFBDCD.8010506@tresys.com>
Content-Type: text/plain
Date: Wed, 01 Feb 2006 09:22:59 -0500
Message-Id: <1138803779.18268.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-31 at 14:43 -0500, Joshua Brindle wrote:
> While debugging the last problem I found that dispol/dismod av rendering
> was not working correctly. Since we moved av_to_string into libsepol
> (statically) a while back for assertions we should use it for apps like
> dispol/dismod that link statically against libsepol. This changes it to
> sepol_av_to_string, moves it to util.c and removes the redundant code
> from dismod and dispol.

Thanks, merged as of libsepol 1.11.11 and checkpolicy 1.29.1 with one
minor modification - removed useless static keyword on struct definition
(wasn't in the original code being moved, and generated a compiler
warning).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
