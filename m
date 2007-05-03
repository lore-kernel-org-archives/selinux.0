Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l43DC3Xm019663
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 09:12:03 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l43DC2Qe028591
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 13:12:02 GMT
Message-ID: <4639DF9E.70405@redhat.com>
Date: Thu, 03 May 2007 09:11:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Steve G <linux_4ever@yahoo.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Patch to cleanup audit handling in policy.
References: <20070430145914.7790.qmail@web51502.mail.re2.yahoo.com>	 <1177951993.3570.115.camel@sgc>	 <1177980591.13269.10.camel@localhost.localdomain>	 <1178026296.3570.144.camel@sgc>	 <1178032864.3757.3.camel@localhost.localdomain>	 <1178125691.445.2.camel@sgc.columbia.tresys.com>	 <1178126283.7700.3.camel@localhost.localdomain> <1178194665.445.42.camel@sgc.columbia.tresys.com>
In-Reply-To: <1178194665.445.42.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I agree with Karl here.  I think while these are different types of 
interfaces, they are definitely related to doing auditing.  As a policy 
writer I would look into the logging.if for these interfaces and not 
seeing them would write them by hand, probably badly.  (As we have seen 
by the number of times it was done wrong.)  I would not think to look in 
a random directory labeled support with misc_patterns.te or 
file_patterns.te. 

I think the use of constraints should be increased as a way to "assert" 
the policy writer is doing the right thing.    So removing the 
assertions, because we have other places where we don't use constraints 
is an invalid argument.  Lets define assertions there and stop policy 
writers from doing

allow mydomain_t etc_t:file rw_file_perms

and other clearly security problematic code.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
