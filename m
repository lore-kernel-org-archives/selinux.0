Message-ID: <443D0462.3010009@seb.ee>
Date: Wed, 12 Apr 2006 16:45:06 +0300
From: Tanel Kokk <tanel.kokk@seb.ee>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: Sendmail & SELinux policies, again
References: <443CB45E.5080400@seb.ee>	 <1144845820.20422.84.camel@moss-spartans.epoch.ncsc.mil>	 <1144847773.29499.2.camel@sgc.columbia.tresys.com> <1144848223.20422.99.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1144848223.20422.99.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
>> Both example policy and refpolicy already have this rule.  I don't know
>> why you would be hitting this.

 From where can I get the current/latest/working sendmail SELinux 
policy? Redhat, Fedora, nsa.gov/selinux?

> 
> Because he rolled his own sendmail policy from scratch, since the
> targeted policy in CentOS (derived from RHEL) didn't include a sendmail
> policy.  Although I suspect the necessary .te files were included in
> the .src.rpm, just omitted from the build.
> 


-- 
Tanel Kokk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
