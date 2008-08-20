Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7KLmWrL019822
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2008 17:48:32 -0400
Received: from smtp105.prem.mail.sp1.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m7KLmV2t023157
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2008 21:48:31 GMT
Message-ID: <48AC9124.1000109@schaufler-ca.com>
Date: Wed, 20 Aug 2008 14:48:20 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "David P. Quigley" <dpquigl@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: Make Dummy Policy
References: <1219262296.2609.148.camel@moss-terrapins.epoch.ncsc.mil>
In-Reply-To: <1219262296.2609.148.camel@moss-terrapins.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David P. Quigley wrote:
> Back in August of 2006 Serge posted a patch to this list which generates
> a bare minimum policy based on the flask definition headers in the Linux
> kernel tree. While I was at OLS someone had mentioned that they wanted
> an easy way to generate a bare minimum policy that they could then carve
> up as they wanted. I have taken Serge's patch and have updated it to
> work with the latest Linux Kernel. 
>
> For those interested in the changes there were only two significant
> changes. The first is that the iteration through the list of classes
> used NULL as a sentinel value. The problem with this is that the
> class_to_string array actually has NULL entries in its table as place
> holders for the user space object classes.
>
> The second change was that it would seem at some point the initial sids
> table was NULL terminated. This is no longer the case so that iteration
> has to be done on array length instead of looking for NULL.
>
> Some statistics on the policy that it generates:
>
> The policy consists of 523 lines which contain no blank lines. Of those
> 523 lines 453 of them are class, permission, and initial sid
> definitions. These lines are usually little to no concern to the policy
> developer since they will not be adding object classes or permissions.
> Of the remaining 70 lines there is one type, one role, and one user
> statement. The remaining lines are broken into three portions. The first
> group are TE allow rules which make up 29 of the remaining lines, the
> second is assignment of labels to the initial sids which consist of 27
> lines, and file system labeling statements which are the remaining 11.
>
> In addition to the policy.conf generated there is a single file_contexts
> file containing two lines which labels the entire system with base_t.
>
> This policy generates a policy.23 binary that is 7920 bytes.
>
> Dave
>   

Thank you. I noticed that class "capability2" is defined but
never used. Is this intentional?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
