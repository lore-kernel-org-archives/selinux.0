Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0CI7Jn4025667
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 13:07:19 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0CI898g019050
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 18:08:10 GMT
In-Reply-To: <587927.74563.qm@web36613.mail.mud.yahoo.com>
References: <587927.74563.qm@web36613.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <19B0C9A6-C287-4F86-B3B1-BCD3D5025E13@nall.com>
Cc: Michael C Thompson <thompsmc@us.ibm.com>, SE Linux <selinux@tycho.nsa.gov>
From: Joe Nall <joe@nall.com>
Subject: Re: [RFC] clarifications for -l to newrole.1
Date: Fri, 12 Jan 2007 12:07:50 -0600
To: casey@schaufler-ca.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Jan 12, 2007, at 11:22 AM, Casey Schaufler wrote:

>
> --- Michael C Thompson <thompsmc@us.ibm.com> wrote:
>
>> Currently, in the MLS policy, the default behaviour
>> is to have users
>> login at SystemLow. If this is not what you would
>> expect, then we should
>> probably change the default levels assumed for users
>> on login.
>
> Allowing users to log in at SystemLow would not
> be consistant with current best practice. I know
> that neither Trusted Solaris nor Trusted Irix
> allows that, and I don't think that HP/UX does
> either. Even allowing for the additional
> protections provided by TE letting users run with
> the same MLS value as system files (unless you
> have something lower than low!) is going to
> set off warning bells in certain circles. Why
> have MLS if you aren't going to use it to
> protect your system data, after all? And yes,
> I understand that there's lots more to SELinux
> policy enforcement than MLS, and that the other
> protections are more than sufficient to protect
> the system files from users. Even with that,
> users should be segregated from the system using
> MLS since MLS is available. Belts, bracers,
> garters, elastic and velcro make for a happy
> and swift evaluation and an end user that
> understands how the system is protected.

On HP-UX 10.26, normal users can login at syslo, which in our systems  
corresponds to unclassified. There is no special effort made to use  
MLS to protect the TCB (some files are syshi because of their  
contents). Does Trusted Irix use a distinct level or an implicit bit  
in the non SystemLow labels?

joe 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
