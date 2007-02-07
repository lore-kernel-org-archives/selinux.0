Subject: Re: MLS concepts, relational question
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20070207211438.8683.qmail@web36605.mail.mud.yahoo.com>
References: <20070207211438.8683.qmail@web36605.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 16:29:06 -0500
Message-Id: <1170883746.11912.155.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-07 at 13:14 -0800, Casey Schaufler wrote:
> The definition I always used for incomp was
> A incomp B if not (A dom B) and not (B dom A)

Yes, that is how SELinux defines it too:

mls_types.h:
#define mls_level_incomp(l1, l2) \
(!mls_level_dom((l1), (l2)) && !mls_level_dom((l2), (l1)))

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
