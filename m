Message-ID: <443D0A10.3080001@seb.ee>
Date: Wed, 12 Apr 2006 17:09:20 +0300
From: Tanel Kokk <tanel.kokk@seb.ee>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, SELinux@tycho.nsa.gov
Subject: Re: Sendmail & SELinux policies, again
References: <443CB45E.5080400@seb.ee>	 <1144845820.20422.84.camel@moss-spartans.epoch.ncsc.mil>	 <1144847773.29499.2.camel@sgc.columbia.tresys.com>	 <1144848223.20422.99.camel@moss-spartans.epoch.ncsc.mil>	 <443D0462.3010009@seb.ee> <1144851029.20422.118.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1144851029.20422.118.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Given your situation, it may be best to just use what you have (i.e.
> your own custom sendmail policy) and adjust it as needed.  The reason I
> say that is that:
> a) targeted policy doesn't confine sendmail presently.  Even if you grab
> the latest sendmail.te, it has ifdefs to turn sendmail_t into an
> unconfined domain if building targeted policy.  You would have to remove
> that block and adapt the sendmail policy to work with targeted policy
> properly.
> b) you are using CentOS, so you have an older policy base and an older
> policy toolchain.  Trying to use the current/latest sendmail.te and
> mta.te with that older base and toolchain might yield a policy that
> doesn't even compile, much less work.

Thanks!


-- 
Tanel Kokk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
