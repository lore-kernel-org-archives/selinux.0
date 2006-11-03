Date: Fri, 03 Nov 2006 16:47:53 -0500
Subject: Re: [PATCH 4/4] SELinux: validate kernel object classes and
 permissions
From: Chad Sellers <csellers@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>
Message-ID: <C1712339.19304%csellers@tresys.com>
In-Reply-To: <1162589963.5519.215.camel@moss-spartans.epoch.ncsc.mil>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/3/06 4:39 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On Fri, 2006-11-03 at 15:33 -0500, Chad Sellers wrote:
>> plain text document attachment (verify_kernel.diff)
>> This is a new object class and permission validation scheme that validates
>> against the defined kernel headers. This scheme allows extra classes and
>> permissions that do not conflict with the kernel definitions to be added to
>> the policy. This validation is now done for all policy loads, not just
>> subsequent loads after the first policy load.
>> 
>> The implementation walks the three structrures containing the defined object
>> class and permission values and ensures their values are the same in the
>> policy being loaded. This includes verifying the object classes themselves,
>> the permissions they contain, and the permissions they inherit from commons.
>> Classes or permissions that are present in the kernel but missing from the
>> policy cause a warning (printed to KERN_INFO) to be printed, but do not stop
>> the policy from loading, emulating current behavior. Any other
>> inconsistencies cause the load to fail.
>> 
>> Signed-off-by: Chad Sellers <csellers@tresys.com>
>> 
>> ---
>>  security/selinux/ss/services.c |  159
>> ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 158 insertions(+), 1 deletion(-)
>> 
>> Index: linux-2.6-discovery/security/selinux/ss/services.c
>> ===================================================================
>> --- linux-2.6-discovery.orig/security/selinux/ss/services.c
>> +++ linux-2.6-discovery/security/selinux/ss/services.c
>> @@ -1018,6 +1027,136 @@ int security_change_sid(u32 ssid,
>> return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, out_sid);
>>  }
>>  
>> +/*
>> + * Verify that each kernel class that is defined in the
>> + * policy is correct
>> + */
>> +static int validate_classes(struct policydb *p)
>> +{
>> + int i, j;
>> + struct class_datum *cladatum;
>> + struct perm_datum *perdatum;
>> + u32 val, tmp, common_pts_len;
> 
> Use temporary variables to make this code readable, e.g.
> const struct selinux_class_perm *kdefs = &selinux_class_perm;
> 
>> +
>> + for (i = 1; i < defined_classes_perms.class_to_string_len; i++) {
> Likewise:
>  for (i = 1; i < kdefs->nclasses; i++) {
>  const char *kname, *pname;
>  kname = kdefs->class_to_string[i];
> 
>> +  if (i > p->p_classes.nprim) {
>> +   printk(KERN_INFO
>> +          "security:  class %s not defined in policy\n",
>> +          defined_classes_perms.class_to_string[i]);
> kname);
>> +   continue;
>> +  }
>  pname = p->p_class_val_to_name[i-1];
>> +  if (strcmp(p->p_class_val_to_name[i-1],
>> +             defined_classes_perms.class_to_string[i])) {
>  if (strcmp(pname, kname)) {
>> +   printk(KERN_ERR
>> +          "security:  class number %d is incorrect, found %s but should be
>> %s\n",
>> +          i, p->p_class_val_to_name[i-1],
> i, pname,
>> +          defined_classes_perms.class_to_string[i]);
> kname);
>> +   return -EINVAL;
>> +  }
> 
>> +  cladatum = hashtab_search(p->p_classes.table,
>> +                            defined_classes_perms.class_to_string[i]);
>> +  if (cladatum == NULL) {
>> +   printk(KERN_ERR "security:  class %s not found in policy\n",
>> +          defined_classes_perms.class_to_string[i]);
>> +   return -EINVAL;
>> +  }
> 
> This seems redundant, as you checked class_val_to_name and it was
> generated from the classes symtab.
> 
Yes, this would only be triggered by a broken policy. Would you rather I not
worry about a broken policy at all, as I obviously don't provide complete
coverage for a broken policy?

>> +  if (i != cladatum->value) {
>> +   printk(KERN_ERR
>> +          "security:  class %s has incorrect value, found %d but should be
>> %d\n",
>> +          defined_classes_perms.class_to_string[i],
>> +          cladatum->value, i);
>> +   return -EINVAL;
>> +  }
> 
> Ditto.
> 
>> + }
>> + for (i = 0; i < defined_classes_perms.av_perm_to_string_len; i++) {
>> +  if (defined_classes_perms.av_perm_to_string[i].tclass >
>> p->p_classes.nprim)
> 
> More opportunities for short temporary variables.
> 
>> +   continue;
>> +  cladatum = hashtab_search(p->p_classes.table,
>> +               
>> p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1]);
>> +  if (cladatum == NULL) {
>> +   printk(KERN_ERR
>> +          "security:  class %s for permission %s not found in policy\n",
>> +           
>> p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1],
>> +           defined_classes_perms.av_perm_to_string[i].name);
>> +   return -EINVAL;
>> +  }
> 
> When would this occur?  Seems like a BUG_ON case.
> 
Yes, this would only occur if the headers were not consistent, so it should
be a BUG_ON.

>> +  val = 1 << (cladatum->permissions.nprim - 1);
>> +  if (defined_classes_perms.av_perm_to_string[i].value > val) {
>> +   printk(KERN_INFO
>> +          "security:  permission %s in class %s not defined in policy\n",
>> +          defined_classes_perms.av_perm_to_string[i].name,
>> +          
>> p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1]);
> 
> I can't believe you typed that, and more than once too.
> 
:-)

>> +   continue;
>> +  }
>> +  perdatum = hashtab_search(cladatum->permissions.table,
>> +               
>> defined_classes_perms.av_perm_to_string[i].name);
>> +  if (perdatum == NULL) {
>> +   printk(KERN_ERR
>> +          "security:  permission %s in class %s not found in policy\n",
>> +          defined_classes_perms.av_perm_to_string[i].name,
>> +          
>> p->p_class_val_to_name[defined_classes_perms.av_perm_to_string[i].tclass-1]);
>> +   return -EINVAL;
>> +  }

I'll make some temporary variables, as you wish. I tend to avoid adding
additional unnecessary layers of indirection, which is why this code is the
way it is (I've followed too many pointers through libsemanage), but it will
help a lot more than it will hurt in this case.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
