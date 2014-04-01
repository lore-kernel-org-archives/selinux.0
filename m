From: "Kim Lawson-Jenkins" <kim.lawson-jenkins@nrl.navy.mil>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <026a01cf4db2$9524fb60$bf6ef220$@nrl.navy.mil>
 <533AD77B.3070107@tycho.nsa.gov>
 <02a201cf4dcc$692b5b70$3b821250$@nrl.navy.mil>
 <533AF23E.5070809@tycho.nsa.gov>
 <02a801cf4dd1$b31e3a40$195aaec0$@nrl.navy.mil>
 <533AFD15.9090002@tycho.nsa.gov>
In-Reply-To: <533AFD15.9090002@tycho.nsa.gov>
Subject: RE: Labelling problems with a user directly running an application in
 a confined domain
Date: Tue, 1 Apr 2014 14:08:02 -0400
Message-ID: <02a901cf4dd5$52c9bf80$f85d3e80$@nrl.navy.mil>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Reply-To: kim.lawson-jenkins@nrl.navy.mil
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Stephen,

OK.  I understand.  Thanks for all of the responses.

Kim

-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Tuesday, April 01, 2014 1:53 PM
To: kim.lawson-jenkins@nrl.navy.mil; selinux@tycho.nsa.gov
Subject: Re: Labelling problems with a user directly running an application
in a confined domain

On 04/01/2014 01:42 PM, Kim Lawson-Jenkins wrote:
>> I read on a SELinux-related blog that unconfined_r should be mapped 
>> to staff_u when removing the unconfined domain, so I didn't remove 
>> unconfined _r for all of the SELinux users.  Should I remove 
>> unconfined_r
> for staff_u?
> 
> That doesn't make sense.  Can you cite this blog?
> 
> http://selinux-mac.blogspot.com/2009/06/selinux-lockdown-part-eight-un
> confin
> ed.html

It looks like his example was for the case where you remove only the
unconfined module, not unconfineduser.

I think you at least need to update
/etc/selinux/targeted/contexts/failsafe_context to use a different context
if fully removing unconfined_r/unconfined_t.  And certainly Red Hat isn't
testing that scenario.

> Kim's response - I'm updating a policy for an application that ran on 
> RHEL5 using the then-supported strict policy.  I read that removing 
> the unconfined domain will make the newer systems operate as the old 
> strict policy, so I went with this method for updating the policy.  I 
> hadn't heard about using mls as an alternative to removing the unconfined
module.

The mls policy has always been strict policy + MLS (instead of MCS).
Whether or not the specific -mls package that your distribution includes has
everything you need I don't know.
