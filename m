Subject: Re: [redhat-lspp] pam_namespace is broken from an SELinux
	perspective.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <45783EA8.5080701@redhat.com>
References: <4576E34D.1030105@hp.com> <45772B33.2090405@hp.com>
	 <45773404.50601@hp.com>  <45783EA8.5080701@redhat.com>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 12:36:42 -0500
Message-Id: <1165513002.12263.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-12-07 at 11:17 -0500, Daniel J Walsh wrote:
> I am trying to fix the problems with polyinstatiation and SELinux Policy 
> in MLS.
> 
> I have found that the way pam_namespace works is broken from an SELinux 
> point of view.
> 
> If I setup the /tmp directory to polyinstatiate and I log in as a 
> staff_t, I end up with /tmp mounted as staff_tmp_t instead of tmp_t.  
> This is wrong, since confined apps that I run as a user expect tmp_t.
> 
> Similarly /home/dwalsh gets mounted as staff_home_t instead of 
> staff_home_dir_t.  This causes all of the transitions to fail. 
> 
> The problem is the pam_namespace is asking the system if staff_t creates 
> a directory in tmp_t how should it be created.  The system responds 
> staff_tmp_t.  What pam_namespace should be doing is taking the directory 
> tmp_t and replacing it's MLS level with the level of the user.  That is all.

security_compute_member() and the type_member rules in the policy
configuration are supposed to provide the policy decision for
polyinstantiation rather than a hardcoded policy in pam_namespace.
Depending on your goal, you might want per-role instantiation of a
directory as well and take away the ability to directly write to e.g.
tmp_t from all user domains, only letting them write to their own
xxx_tmp_t type.

Part of the problem is that type_member rules currently only trigger
level instantiation if the new type differs from the old, so you can't
just say type_member staff_t tmp_t:dir tmp_t;  That could be changed,
but requires a (trivial) kernel patch.

You could work around it by labeling the top-level directories like /tmp
and /home/dwalsh with other types (e.g. poly_tmp_t, poly_home_t)
distinct for polyinstantiated directories, and then define type_member
rules on those, e.g. type_member staff_t poly_tmp_t:dir tmp_t;
type_member staff_t poly_home_t:dir staff_home_dir_t;

> So staff_t loging in as s0:c1
> will end up with /tmp being
> system_u:object_r:tmp_t:s0:c1
> And /home/dwalsh
> system_u:object_r:staff_home_dir_t:s0:c1
> 
> 
> I am trying out a patched version of pam_namespace to see if this fixes 
> the problem.
> 
> Am I makeing the correct assumption.

If I read it correctly, the patch completely removes the use of
security_compute_member, and hardcodes per-level instantiation.
So that limits its usefulness to MLS.

Other comments:
- Need to check return codes from context_new, context_range_set,
context_str, strdup and handle appropriately,
- I don't think you want the full range from scontext - just the low
level (aka current/sensitivity level).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
