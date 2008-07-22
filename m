Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MCXWW8030885
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 08:33:32 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MCXUHb027195
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 12:33:31 GMT
Received: by py-out-1112.google.com with SMTP id a78so5136997pyh.32
        for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 05:33:30 -0700 (PDT)
Subject: Re: questions about persistent storage of security contexts
From: Stephen Smalley <stephen.smalley@gmail.com>
To: Andy Warner <warner@rubix.com>
Cc: Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
In-Reply-To: <4885CB56.9010700@rubix.com>
References: <48851770.5020002@rubix.com>
	 <7e0fb38c0807211735w40e6fe4bjb31171b9d13cea45@mail.gmail.com>
	 <1216692067.17786.21.camel@sulphur>  <4885CB56.9010700@rubix.com>
Content-Type: text/plain
Date: Tue, 22 Jul 2008 08:32:29 -0400
Message-Id: <1216729949.3500.5.camel@sulphur>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-07-22 at 13:58 +0200, Andy Warner wrote:
> 
> Thanks for the info, all is now clear!
> 
> One more question (from an SELinux newbie!) that has been nagging away
> at me in regards to the MLS portion of the security context. In the
> MLS label we have the sensitivity (s0, s1, etc) and the category (c0,
> c2, etc). Now, as for the categories, its seems clear that in order
> for label1 to (potentially) dominate label2, then label1 must contain
> all the categories contained in label2 (i.e., *:c1,c3 can potentially
> dominate *:c3 where as *:c1 can never dominate *:c3). c0, c1, etc are
> just names of categories and the only relationship between them is
> equality or non-equality.
> 
> But with the sensitivity we have an ordering relationship, e.g., s3 is
> greater than (or higher, or strictly dominates) s1. The numbering
> applied to the sensitivity seems to imply (or define?) what that
> ordering is (s3 is greater than s1 because 3 is greater than 1). Is
> this numerical ordering a fixed part of the SELinux MLS policy or are
> the sensitivities simply "names" and how the policy is written defines
> the ordering. That is, is it possible for a configuration of SELinux
> MLS to have s0 strictly dominate s3?

Yes - they are just names and the dominance relationship is defined by
the policy configuration.

Computing dominance has been handled in a couple of different ways in
the past:
1) Model it as a permission check, with a MLS constraint defined on the
permission and allowing the type relationship.
2) Introduce an interface to the kernel security server to provide
dominance computations.

See the mailing list archives for more discussion.

> 
> My reason for asking is, if the "numerical ordering" of the
> sensitivities is always true then I can easily write my own functions
> to perform dominance checks of the MLS labels and those functions do
> not need to consult the SELinux API. If the sensitivities are just
> "names" and the policy instance can define any ordering relationship,
> then any functions written to perform dominance checks must call the
> SELinux API and seem non-trivial because no dominance check (only) API
> is provided and the TE behavior will somehow need to be "filtered"
> from the security check result.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
