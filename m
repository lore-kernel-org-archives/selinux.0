Subject: Re: MAC_POLICY_LOAD on unloading module
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Michael C Thompson <thompsmc@us.ibm.com>
Cc: lspp-list <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <45096D60.5010902@us.ibm.com>
References: <45096D60.5010902@us.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 11:08:44 -0400
Message-Id: <1158246524.25629.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-14 at 09:55 -0500, Michael C Thompson wrote:
> Hey Steve,
> 
> on semodule -r module, the audit message you get (MAC_POLICY_LOAD) has 
> the exact same message as the audit message you get on semodule -i 
> module. That is, "policy loaded". Shouldn't there be a different between 
> module load and module unload?

>From the kernel's POV, they are both a policy load.  The modular
insertion/removal is done in userspace and a new kernel policy is
generated and then loaded.  So if you want that granularity of audit,
you need it to be done in semodule or better in libsemanage (and
ultimately in the policy management server when that is deployed).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
