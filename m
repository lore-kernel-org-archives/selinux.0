Subject: Re: Sendmail & SELinux policies, again
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tanel Kokk <tanel.kokk@seb.ee>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, SELinux@tycho.nsa.gov
In-Reply-To: <443D0462.3010009@seb.ee>
References: <443CB45E.5080400@seb.ee>
	 <1144845820.20422.84.camel@moss-spartans.epoch.ncsc.mil>
	 <1144847773.29499.2.camel@sgc.columbia.tresys.com>
	 <1144848223.20422.99.camel@moss-spartans.epoch.ncsc.mil>
	 <443D0462.3010009@seb.ee>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 10:10:29 -0400
Message-Id: <1144851029.20422.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-04-12 at 16:45 +0300, Tanel Kokk wrote:
>  From where can I get the current/latest/working sendmail SELinux 
> policy? Redhat, Fedora, nsa.gov/selinux?

Given your situation, it may be best to just use what you have (i.e.
your own custom sendmail policy) and adjust it as needed.  The reason I
say that is that:
a) targeted policy doesn't confine sendmail presently.  Even if you grab
the latest sendmail.te, it has ifdefs to turn sendmail_t into an
unconfined domain if building targeted policy.  You would have to remove
that block and adapt the sendmail policy to work with targeted policy
properly.
b) you are using CentOS, so you have an older policy base and an older
policy toolchain.  Trying to use the current/latest sendmail.te and
mta.te with that older base and toolchain might yield a policy that
doesn't even compile, much less work.

You can certainly look at the example policy and reference policy
definitions for sendmail and mta for reference in writing your own, but
I'm not sure you can really use them directly in a useful manner
(without switching to -strict, which should have a sendmail policy
already).

For reference, the NSA example policy is available at
http://www.nsa.gov/selinux/archives/old/policy.tgz
and its cvs tree is at:
http://cvs.sourceforge.net/viewcvs.py/selinux/nsa/selinux-usr/policy/

And the reference policy is available from the sourceforge site,
http://serefpolicy.sf.net.

But I don't think you want to try to just plug-and-play those files into
your current base policy.   They likely rely on other changes made to
the base policies, like newer macro definitions, as well as newer policy
language features, that aren't supported by the CentOS base policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
