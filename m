Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3A4JtTJ028716
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 00:19:55 -0400
Received: from smtp110.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n3A4Jq4u013167
	for <selinux@tycho.nsa.gov>; Fri, 10 Apr 2009 04:19:55 GMT
Message-ID: <49DEC8D0.2060105@schaufler-ca.com>
Date: Thu, 09 Apr 2009 21:19:28 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: jwcart2@tycho.nsa.gov
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Policy infrastructure problems and improvement
References: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1239290883.22856.53.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:
> I am looking at improving the policy infrastructure.  The ultimate goal
> is to make SELinux policy writing, policy customization, policy
> management, and administration easier and less confusing. My focus will
> be on the userspace parts of SELinux. 
>
> My plan to do this is as follows:
> (1) Determine and enumerate the existing problems of the current
> infrastructure.
> (2) Determine the desired capabilities and architecture of the ideal
> infrastructure.
> (3) Determine the changes needed to the current architecture to fix the
> current problems and to provide the desired capabilities.
> (4) Make the policy infrastructure as close to the ideal as possible
> while providing some kind of backwards compatibility and taking other
> practicalities into consideration.
>
> I have had some informal discussions with others internally and at
> Tresys, and the five emails to follow have my summary of the problems
> that have been identified in those discussions.
>
> My hope is that there will be a good discussion and that others on the
> list will identify other problems and provide more details or examples
> to the problems already identified.
>   

I will throw my traditional comment on the pile as I didn't see that
you had it on your list anywhere. The policy required to describe a
system is too large.

Thank you.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
