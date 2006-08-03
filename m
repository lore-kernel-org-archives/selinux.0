Subject: Re: [PATCH 7/6] netfilter integration take 2: style fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1154538846.31522.177.camel@sgc.columbia.tresys.com>
References: <1154538846.31522.177.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:34:36 -0400
Message-Id: <1154615676.32479.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-02 at 13:14 -0400, Christopher J. PeBenito wrote:
> This applies on top of the previous patches, to fix style.  Also removed
> a NULL check since semanage_path() can't return NULL.
> 
>  direct_api.c |   15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

All 7 patches applied, thanks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
