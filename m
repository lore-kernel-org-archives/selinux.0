Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7KLxQcc021904
	for <selinux@tycho.nsa.gov>; Wed, 20 Aug 2008 17:59:26 -0400
Subject: Re: Make Dummy Policy
From: "David P. Quigley" <dpquigl@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov, "Serge E. Hallyn" <serue@us.ibm.com>
In-Reply-To: <48AC9124.1000109@schaufler-ca.com>
References: <1219262296.2609.148.camel@moss-terrapins.epoch.ncsc.mil>
	 <48AC9124.1000109@schaufler-ca.com>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 17:41:48 -0400
Message-Id: <1219268509.13542.2.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-08-20 at 14:48 -0700, Casey Schaufler wrote:
> David P. Quigley wrote:
> > Back in August of 2006 Serge posted a patch to this list which generates
> > a bare minimum policy based on the flask definition headers in the Linux
> > kernel tree. While I was at OLS someone had mentioned that they wanted
> > an easy way to generate a bare minimum policy that they could then carve
> > up as they wanted. I have taken Serge's patch and have updated it to
> > work with the latest Linux Kernel. 
> >
> > For those interested in the changes there were only two significant
> > changes. The first is that the iteration through the list of classes
> > used NULL as a sentinel value. The problem with this is that the
> > class_to_string array actually has NULL entries in its table as place
> > holders for the user space object classes.
> >
> > The second change was that it would seem at some point the initial sids
> > table was NULL terminated. This is no longer the case so that iteration
> > has to be done on array length instead of looking for NULL.
> >
> > Some statistics on the policy that it generates:
> >
> > The policy consists of 523 lines which contain no blank lines. Of those
> > 523 lines 453 of them are class, permission, and initial sid
> > definitions. These lines are usually little to no concern to the policy
> > developer since they will not be adding object classes or permissions.
> > Of the remaining 70 lines there is one type, one role, and one user
> > statement. The remaining lines are broken into three portions. The first
> > group are TE allow rules which make up 29 of the remaining lines, the
> > second is assignment of labels to the initial sids which consist of 27
> > lines, and file system labeling statements which are the remaining 11.
> >
> > In addition to the policy.conf generated there is a single file_contexts
> > file containing two lines which labels the entire system with base_t.
> >
> > This policy generates a policy.23 binary that is 7920 bytes.
> >
> > Dave
> >   
> 
> Thank you. I noticed that class "capability2" is defined but
> never used. Is this intentional?

Whoops. There are some other object classes  missing as well. I must
have missed one of the conversions on class list. I'll fix that and send
out a new copy.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
