Date: Fri, 06 Oct 2006 18:25:48 -0400
Subject: Re: [PATCH 4/4] Validate kernel object classes and permissions
From: Chad Sellers <csellers@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: <selinux@tycho.nsa.gov>
Message-ID: <C14C502C.18471%csellers@tresys.com>
In-Reply-To: <1160170630.20202.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/6/06 5:37 PM, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

> On Fri, 2006-10-06 at 16:09 -0400, Chad Sellers wrote:
>> plain text document attachment (verify_kernel.diff)
>> This patch replaces the object class and permission validation code to
>> validate against the defined kernel headers, and allow extra classes
>> and permissions that do not conflict with the kernel definitions. Note
>> that validation is now done for all policy loads, not just subsequent
>> loads after the first policy load.
> 
> I haven't looked closely, but it doesn't quite look right to me.  The
> old logic would walk the "good" definitions from the old policy,
> checking each one against the definitions in the new policy.  This logic
> appears to walk the new policy, checking each of its definitions against
> the kernel tables.  But what if the new policy simply omits a definition
> required by the kernel, e.g. delete the last class or the last five
> classes altogether from policy?  Interestingly, the old logic includes
> messages like "permission %s disappeared" or "class %s disappeared" but
> this logic does not (only messages about incorrect values).  I think you
> want it the other way around, i.e. walk the kernel tables and look up
> each definition there in the policy being loaded, then see if it is
> correct.  That also avoids having to skip around things that are defined
> in policy but not in the kernel tables.
> 
I don't think that's the logic we want, though. Part of the eventual idea
here is to help out the "Andrew Morton syndrome," where a kernel developer
has a new kernel class/permission, but no policy for it. If we require all
kernel defined classes/perms to be present in the policy, then we can't
support this situation. The logic in my patch requires that all the kernel
classes defined in the policy are consistent with the kernel, but allows for
the possibility of the kernel having new classes/permissions that aren't in
policy yet. The logic you propose would not allow a kernel developer to load
a policy until that policy supported their new object class/permission.

Chad


>> Signed-off-by: Chad Sellers <csellers@tresys.com>
>> 
>> ---
>>  security/selinux/ss/services.c |  161
>> ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 160 insertions(+), 1 deletion(-)
>> 
>> Index: linux-2.6-discovery/security/selinux/ss/services.c
>> ===================================================================
>> --- linux-2.6-discovery.orig/security/selinux/ss/services.c
>> +++ linux-2.6-discovery/security/selinux/ss/services.c
>> @@ -1018,6 +1027,138 @@ int security_change_sid(u32 ssid,
>> return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, out_sid);
>>  }
>>  
>> +/*
>> + * Verify that each kernel permission that is defined in a
>> + * policy class is correct
>> + */
>> +static int validate_class_perm(void *key, void *datum, void *p)
>> +{
>> + struct perm_datum *perdatum;
>> + u32 *class, val;
>> + char *name;
>> + int rc = 0, i;
>> +
>> + class = p;
>> + perdatum = datum;
>> + name = key;
>> + val = 1 << (perdatum->value - 1);
>> +
>> + for (i = 0; i < defined_classes_perms.av_perm_to_string_len; i++) {
>> +  if ((defined_classes_perms.av_perm_to_string[i].tclass == *class)
>> +      && (defined_classes_perms.av_perm_to_string[i].value == val)) {
>> +   if (strcmp(name, defined_classes_perms.av_perm_to_string[i].name)) {
>> +    printk(KERN_ERR
>> +           "security:  the value of permission %s is incorrect",
>> +           (char *)key);
>> +    rc = -EINVAL;
>> +   }
>> +   break;
>> +  }
>> + }
>> + return rc;
>> +}
>> +
>> +/*
>> + * Verify that each kernel permission that is defined in a
>> + * policy common is correct
>> + */
>> +static int validate_common_perm(void *key, void *datum, void *p)
>> +{
>> + struct perm_datum *perdatum;
>> + u32 *class, tmp, common_pts_len = 0;
>> + char *name;
>> + int rc = 0, i;
>> +
>> + class = p;
>> + perdatum = datum;
>> + name = key;
>> +
>> + for (i = 0; i < defined_classes_perms.av_inherit_len; i++) {
>> +  if (defined_classes_perms.av_inherit[i].tclass == *class) {
>> +   tmp = defined_classes_perms.av_inherit[i].common_base;
>> +   while (!(tmp & 0x01)) {
>> +    common_pts_len++;
>> +    tmp >>= 1;
>> +   }
>> +   if (perdatum->value > common_pts_len)
>> +    break;
>> +   if (strcmp(name, defined_classes_perms.av_inherit[i].
>> +        common_pts[perdatum->value - 1])) {
>> +    printk(KERN_ERR
>> +           "security:  the value of permission %s is incorrect",
>> +           (char *)key);
>> +    rc = -EINVAL;
>> +   }
>> +   break;
>> +  }
>> + }
>> + return rc;
>> +}
>> +
>> +/*
>> + * Verify that each kernel class that is defined in the
>> + * policy is correct
>> + */
>> +static int validate_class(void *key, void *datum, void *p)
>> +{
>> + struct class_datum *cladatum;
>> + int rc, i;
>> + char *name;
>> + u8 has_common = 0;
>> +
>> + cladatum = datum;
>> + name = key;
>> +
>> + if (cladatum->value >= defined_classes_perms.class_to_string_len) {
>> +  rc = 0;
>> +  goto out;
>> + }
>> + if (strcmp(name, defined_classes_perms.class_to_string[cladatum->value])) {
>> +  printk(KERN_ERR "security:  the value of class %s is incorrect\n",
>> +         (char *)key);
>> +  rc = -EINVAL;
>> +  goto out;
>> + }
>> + for (i = 0; i < defined_classes_perms.av_inherit_len; i++) {
>> +  if (defined_classes_perms.av_inherit[i].tclass == cladatum->value) {
>> +   has_common = 1;
>> +   break;
>> +  }
>> + }
>> + if (!((cladatum->comdatum && has_common) ||
>> +       (!cladatum->comdatum && !has_common))) {
>> +  if (has_common) {
>> +   printk(KERN_ERR
>> +          "security:  the access vector definition for class"
>> +          "%s should have an inherits clause but does not\n",
>> +          (char *)key);
>> +  } else {
>> +   printk(KERN_ERR
>> +          "security:  the access vector definition for class"
>> +          "%s should not have an inherits clause but does\n",
>> +          (char *)key);
>> +  }
>> +  rc = -EINVAL;
>> +  goto out;
>> + }
>> + if (cladatum->comdatum) {
>> +  rc = hashtab_map(cladatum->comdatum->permissions.table,
>> +     validate_common_perm, &cladatum->value);
>> +  if (rc) {
>> +   printk(" in the access vector definition for class "
>> +          "%s\n", (char *)key);
>> +   goto out;
>> +  }
>> + }
>> + rc = hashtab_map(cladatum->permissions.table, validate_class_perm,
>> +    &cladatum->value);
>> + if (rc)
>> +  printk(" in access vector definition for class %s\n",
>> +         (char *)key);
>> +out:
>> + return rc;
>> +}
>> +
>>  /* Clone the SID into the new SID table. */
>>  static int clone_sid(u32 sid,
>>     struct context *context,
>> @@ -1160,6 +1301,16 @@ int security_load_policy(void *data, siz
>> avtab_cache_destroy();
>> return -EINVAL;
>> }
>> +  /* Verify that the kernel defined classes are correct. */
>> +  if (hashtab_map(policydb.p_classes.table, validate_class, NULL)) {
>> +   printk(KERN_ERR
>> +          "security:  the definition of a class is incorrect\n");
>> +   LOAD_UNLOCK;
>> +   sidtab_destroy(&sidtab);
>> +   policydb_destroy(&policydb);
>> +   avtab_cache_destroy();
>> +   return -EINVAL;
>> +  }
>> policydb_loaded_version = policydb.policyvers;
>> ss_initialized = 1;
>> seqno = ++latest_granting;
>> @@ -1182,6 +1333,14 @@ int security_load_policy(void *data, siz
>>  
>> sidtab_init(&newsidtab);
>>  
>> + /* Verify that the kernel defined classes are correct. */
>> + if (hashtab_map(newpolicydb.p_classes.table, validate_class, NULL)) {
>> +  printk(KERN_ERR
>> +         "security:  the definition of a class is incorrect\n");
>> +  rc = -EINVAL;
>> +  goto err;
>> + }
>> +
>> /* Clone the SID table. */
>> sidtab_shutdown(&sidtab);
>> if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {
>> 
>> --
>> 
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
