Message-ID: <526AABFC.7070709@tycho.nsa.gov>
Date: Fri, 25 Oct 2013 13:35:56 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Allow audit2allow to return constraint information from policy
References: <5269207C.4090809@redhat.com>
In-Reply-To: <5269207C.4090809@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/24/2013 09:28 AM, Daniel J Walsh wrote:
> Sadly we thought these discussions had happened on the list, but I guess we
> had taken it private.  Here is the userspace patch to reveal this information.
> 
> The kernel team will be posting the kernel patch hopefully soon.  We believe
> that even though the kernel does not need the additional information about the
> constraint, the limited space required to carry this information makes sense.

I gave comments on the kernel patch, so hopefully that can be revised
and resubmitted.

For this one, can we get the patch submitted by Richard after making
changes as per these comments?

And I think it should be split up into separate patches for libsepol,
libselinux, policycoreutils, and sepolgen.

Check your coding style as per CodingStyle, use scripts/checkpatch.pl
from the kernel as a rough guide, and use scripts/Lindent as a last
resort if you've messed up.

Why did we need a new modular format version in addition to a new kernel
format version?  You don't appear to use it anywhere.

On the sepol_class_name_to_id() and sepol_perm_name_to_av() helpers,
libselinux has security_class_to_string() / string_to_security_class()
and security_av_perm_to_string() / string_to_av_perm() /
security_av_string() helpers and libsepol has sepol_av_to_string().
Just wondering if we should try and use consistent names aside from
sepol_ prefix and different implementations (policy-based vs
selinuxfs-based).

Output looks like:
# audit2why -p /etc/selinux/targeted/policy/policy.29 < avc
type=AVC msg=audit(1382706778.165:3267): avc:  denied  { signal } for
pid=4076 comm="bash"
scontext=unconfined_u:unconfined_r:sandbox_t:s0:c353,c935
tcontext=unconfined_u:unconfined_r:sandbox_t:s0:c96,c826 tclass=process

	Was caused by:

#Constraint rule:
	mlsconstrain process { signal } ((h1 dom h2 -Fail-)  or (t1=sandbox_t
neq TYPE_ENTRY -Fail-) { POLICY_SOURCE: mcs_constrained_type } );
Constraint DENIED
mlsconstrain process { sigkill sigstop } ((h1 dom h2 -Fail-)  or
(t1=sandbox_t  neq TYPE_ENTRY -Fail-) { POLICY_SOURCE:
mcs_constrained_type } ); Constraint DENIED

#	Possible cause is the source level (s0:c353,c935) and target level
(s0:c96,c826) are different.

Is there a reason it wasn't displayed in the same way as the original
constraint (e.g. why doesn't it say ( t1 != mcs_constrained_type), why
is it partially postfix notation (neq) and what is the purpose of
putting TYPE_ENTRY into the output?  And why didn't it suggest assigning
the attribute to the source type as an alternative fix?

Buffer/string management looks...complicated.  Can we reduce all of the
copying/allocation that goes on there?  And have you run this through
valgrind (likely need a C test program that directly uses the libsepol
interface; could even add it as a menu option under the debug (-d)
facility of checkpolicy).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
