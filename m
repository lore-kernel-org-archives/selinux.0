Message-ID: <49E7D1BF.2010405@tycho.nsa.gov>
Date: Thu, 16 Apr 2009 20:47:59 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, Colin Walters <walters@verbum.org>,
        selinux@tycho.nsa.gov
Subject: Re: libselinux behavior in permissive mode wrt invalid domains
References: <faa16b610904141142v1d1e92ddxd78d5e1a0fbb0be7@mail.gmail.com>	 <49E5CFD8.6060903@redhat.com> <1239800627.27560.34.camel@localhost.localdomain>
In-Reply-To: <1239800627.27560.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2009-04-15 at 08:15 -0400, Daniel J Walsh wrote:
>   
>> On 04/14/2009 02:42 PM, Colin Walters wrote:
>>     
>>> Hi,
>>>
>>> I'd like broader input on:
>>> http://bugs.freedesktop.org/show_bug.cgi?id=21072
>>>
>>> Is this something we can do inside libselinux itself?  Or are we
>>> planning similar patches around avc_has_perm calls for the X server,
>>> libvirt and other userspace programs?
>>>
>>> --
>>> This message was distributed to subscribers of the selinux mailing list.
>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>> the words "unsubscribe selinux" without quotes as the message.
>>>       
>> So the question is whether the API should return allowed when in 
>> permissive mode rather then denied and make every App server code up 
>> permissive mode check.
>>
>>
>> We have had several bugs where tools have not checked whether the 
>> machine is in permissive mode when doing an access check.  One 
>> possibility would be to generate the AVC in the check code when in 
>> permissive mode or always generat the AVC, there an return allowed.
>>
>> If you look at the calling apps point of view it is asking if the user 
>> should be allowed the access and in permissive mode he should be allowed 
>> the access.
>>     
>
> avc_has_perm() already checks for permissive mode internally, unlike
> security_compute_av().  However, in this case, the problem is not that
> permission was denied but rather that one of the security contexts is no
> longer valid.
>
>   

To elaborate, a return value of -1 from avc_has_perm() does not mean
"denied."  It is errno being EACCES that means denied.  EINVAL means bad
context or other argument.  And there are other possibilities, like
ENOMEM.  So at the very least, the D-Bus code should log a different
message ("SELinux denying due to invalid context") when errno is EINVAL.

I'd like to see this problem solved in the kernel.  The compute_av call
should map invalid contexts to the unlabeled sid instead of erroring out
with EINVAL in permissive mode.

I reviewed ss/services.c briefly and came up with the following
pseudo-patch which modifies the behavior of string_to_context_struct(). 
Some potential issues are that:
 -- string_to_context_struct() is called from convert_context() as well
as security_context_to_sid_core().
 -- Mutating the context struct into the unlabeled context might
interact badly with the "force == 1" logic in
security_context_to_sid_core().



diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index deeec6c..bf49ecc 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -900,6 +900,28 @@ int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len)
 	return security_sid_to_context_core(sid, scontext, scontext_len, 1);
 }
 
+static inline int string_to_context_struct_handle_invalid_context(struct context *context)
+{
+	int rc = 0;
+
+	if (selinux_enforcing) {
+		rc = -EINVAL;
+	} else {
+		char *s;
+		u32 len;
+
+		if (!context_struct_to_string(context, &s, &len)) {
+			printk(KERN_WARNING
+		       "SELinux:  Context %s would be invalid if enforcing\n",
+			       s);
+			kfree(s);
+		}
+
+		magically_turn_context_into_the_unlabeled_sid(ctx);
+	}
+	return rc;
+}
+
 /*
  * Caveat:  Mutates scontext.
  */
@@ -978,8 +1000,9 @@ static int string_to_context_struct(struct policydb *pol,
 
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(pol, ctx)) {
-		rc = -EINVAL;
-		goto out;
+		rc = string_to_context_struct_handle_invalid_context(ctx);
+		if (rc)
+			goto out;
 	}
 	rc = 0;
 out:



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
