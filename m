Subject: Re: policy language extensions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: david caplan <dac@tresys.com>, "NSA's SELinux" <SELinux@tycho.nsa.gov>
In-Reply-To: <20030926130232.GF10225@vnl.com>
References: <3F7361F8.1080603@tresys.com>  <20030926130232.GF10225@vnl.com>
Content-Type: text/plain
Message-Id: <1064583595.5099.245.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 26 Sep 2003 09:39:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-09-26 at 09:02, Dale Amon wrote:
> Some things could be difficult though: policy statements
> do not appear to me to have a 1:1 relation to the binary 
> representation.

Correct.  A policy statement may specify sets of types and classes as
well as using type attributes to represent sets of types; these
statements are expanded into individual (source type, target type,
target class, access vectors or new types) tuples in the binary
representation.  Also, you may have overlapping or even redundant policy
statements in the policy.conf that are unioned by the policy compiler
(particularly due to macro expansions), so removing a statement doesn't
necessarily mean that the permissions should go away.  If you take a
close look at the policy patch tools posted to the list back in June by
Frank Mayer, you'll see that they had to consider these issues for that
work.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
