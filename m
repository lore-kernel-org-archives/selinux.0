Subject: RE: [RFC] Checking the loaded policy against a policy on disk
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'James Morris'" <jmorris@namei.org>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, "'Steve G'" <linux_4ever@yahoo.com>,
   SELinux-dev@tresys.com
In-Reply-To: <200508191842.j7JIgsss003461@gotham.columbia.tresys.com>
References: <200508191842.j7JIgsss003461@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 14:55:54 -0400
Message-Id: <1124477754.32663.149.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-19 at 14:42 -0400, Frank Mayer wrote:
> > Can you point me to the LSPP requirement which states that we need to
> > do this? 
> 
> I was wondering that myself. I don't recall any such requirement. As long as
> the policy files are protected against unauthorized access and procedures
> for start up/initialization are documented in appropriate manual, we
> shouldn't be "required" to have a demonstrable association (thought
> something like this might be otherwise useful). I believe the requirements
> are for TCB/TSF protection, not periodic guarantee checks (except for
> FPT_AMT which explicitly only applies to hardware). Frank

Ok, it seems that the request for this ability originated based on the
RBACPP rather than the LSPP, and in particular, the TSF Self Test
requirements, including the ability to verify the integrity of TSF data.
Whether or not that truly requires the ability to check the loaded
policy against a policy on disk is not clear, but in any event, it does
seem like a useful capability to provide.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
