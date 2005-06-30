Subject: Re: Groups in the alternative user solution
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: casey@schaufler-ca.com, kmacmillan@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1120059525.3553.137.camel@moss-spartans.epoch.ncsc.mil>
References: <1119980076.4806.23.camel@celtics.boston.redhat.com>
	 <1119987846.22225.222.camel@moss-spartans.epoch.ncsc.mil>
	 <1119988230.7417.6.camel@celtics.boston.redhat.com>
	 <1120055713.3553.105.camel@moss-spartans.epoch.ncsc.mil>
	 <1120057525.17121.23.camel@celtics.boston.redhat.com>
	 <1120059525.3553.137.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:27:02 -0400
Message-Id: <1120138022.32561.12.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Seems unlikely to me, given the difference between DAC and MAC.
> But I'm open to other opinions on the subject.

What about Casey's suggestion in this thread:

> 
>     root:*:sysadm
>     fred:wheel:wand
>     *:wheel:staff
>     *:*:normal
> 
> Fred would be in "wand" if only in group wheel,
> in "normal" if in groups wheel and dev. Fun.

Not sure I understand... 
So if Fred is in more groups other than wheel, 
he maps to normal? What's the rationale for that?
Controlling information disclosure? Does that * 
take precedence to fred? What about conflicts? 
This seems complicated..

============

Should this idea be dropped? More opinions?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
