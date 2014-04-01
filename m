Message-ID: <533AFD15.9090002@tycho.nsa.gov>
Date: Tue, 01 Apr 2014 13:53:25 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: kim.lawson-jenkins@nrl.navy.mil, selinux@tycho.nsa.gov
Subject: Re: Labelling problems with a user directly running an application
 in a confined domain
References: <026a01cf4db2$9524fb60$bf6ef220$@nrl.navy.mil>
 <533AD77B.3070107@tycho.nsa.gov>
 <02a201cf4dcc$692b5b70$3b821250$@nrl.navy.mil>
 <533AF23E.5070809@tycho.nsa.gov>
 <02a801cf4dd1$b31e3a40$195aaec0$@nrl.navy.mil>
In-Reply-To: <02a801cf4dd1$b31e3a40$195aaec0$@nrl.navy.mil>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/01/2014 01:42 PM, Kim Lawson-Jenkins wrote:
>> I read on a SELinux-related blog that unconfined_r should be mapped to 
>> staff_u when removing the unconfined domain, so I didn't remove 
>> unconfined _r for all of the SELinux users.  Should I remove unconfined_r
> for staff_u?
> 
> That doesn't make sense.  Can you cite this blog?
> 
> http://selinux-mac.blogspot.com/2009/06/selinux-lockdown-part-eight-unconfin
> ed.html

It looks like his example was for the case where you remove only the
unconfined module, not unconfineduser.

I think you at least need to update
/etc/selinux/targeted/contexts/failsafe_context to use a different
context if fully removing unconfined_r/unconfined_t.  And certainly Red
Hat isn't testing that scenario.

> Kim's response - I'm updating a policy for an application that ran on RHEL5
> using the then-supported strict policy.  I read that removing the unconfined
> domain will make the newer systems operate as the old strict policy, so I
> went with this method for updating the policy.  I hadn't heard about using
> mls as an alternative to removing the unconfined module.

The mls policy has always been strict policy + MLS (instead of MCS).
Whether or not the specific -mls package that your distribution includes
has everything you need I don't know.
