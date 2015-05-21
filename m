Message-ID: <555DD091.8060307@tycho.nsa.gov>
Date: Thu, 21 May 2015 08:33:21 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Paul Moore <paul@paul-moore.com>, Jeff Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH 2/2 v4] SELinux: per-command whitelisting of ioctls
References: <1430337372-7758-1-git-send-email-jeffv@google.com>
 <3147722.RboehMiu35@sifl>
In-Reply-To: <3147722.RboehMiu35@sifl>
Content-Type: text/plain; charset=windows-1252
Cc: linux-security-module@vger.kernel.org, james.l.morris@oracle.com,
 selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/20/2015 05:22 PM, Paul Moore wrote:
>> @@ -64,6 +66,16 @@ struct avc_cache {
>>  	u32			latest_notif;	/* latest revocation notification */
>>  };
>>
>> +struct avc_operation_decision_node {
>> +	struct operation_decision od;
>> +	struct list_head od_list;
>> +};
> 
> Making this more generic may mean adding an extra field here to specify the 
> type of extension, e.g. ioctl commands.
> 
>> +struct avc_operation_node {
>> +	struct operation ops;
>> +	struct list_head od_head; /* list of operation_decision_node */
>> +};
> 
> As mentioned earlier, I think "operation" needs a name change; I tend to like 
> "extop" better, e.g. "avc_extop_decision_node" and "avc_extop_node".  Feel 
> free to suggest others.
> 
> The "operation" struct is named poorly as well; even if we stick with 
> "operation" elsewhere we really need to name this one better, it's way too 
> generic.

Don't want to bikeshed here, but I think "operation" is more readable
then "extop" (not evident what that means or even whether it is supposed
to be read as "ex-top" or "ext-op" or what).  "operation" at least is
meaningful and is a suitable generalization of "ioctl command".

>> @@ -429,11 +456,15 @@ int avtab_read_item(struct avtab *a, void *fp, struct
>> policydb *pol, printk(KERN_ERR "SELinux: avtab: entry has both access
>> vectors and types\n"); return -EINVAL;
>>  		}
>> +		if (val & AVTAB_OP) {
>> +			printk(KERN_ERR "SELinux: avtab: entry has operations\n");
>> +			return -EINVAL;
>> +		}
> 
> Another "operations" vs. "extop" or similar.  If we generalize, it would also 
> be nice to know what kind of extended operations, e.g. ioctl commands.
> 
> Further, beyond the extension type (ioctl), I think it would be nice to 
> include a size value in the binary policy.  With the current ioctl code it 
> would be 8/256, but we might want to make this variable in the future and it 
> would be nice not to have to bump the policy format again.

Not sure we can avoid changing the format version again regardless.
Note that we didn't even strictly need to increment the version this
time, as the new structure is only included in the binary policy if one
of the newly defined AVTAB_OP flag bits is set for the entry, but it was
still useful to define a new version so that userspace can tell whether
the kernel supports the extension and decide how to handle it if the
policy defined these operations but the kernel doesn't support enforcing
them. The same would be true of any future extension that used this
facility.
