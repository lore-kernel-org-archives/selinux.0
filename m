To: Sachin Grover <grover_sachin@outlook.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <CO1PR14MB10615AE03A49927CC39A041986390@CO1PR14MB1061.namprd14.prod.outlook.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <531392a3-1a17-9732-3a89-4231339f800d@tycho.nsa.gov>
Date: Mon, 13 Aug 2018 08:23:04 -0400
MIME-Version: 1.0
In-Reply-To: <CO1PR14MB10615AE03A49927CC39A041986390@CO1PR14MB1061.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: Possible OOB Read in Kernel Heap Memory in call to
 ext4_xattr_set_entry()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/13/2018 01:19 AM, Sachin Grover wrote:
> Hi Stephen/Paul,
> 
> This issue was discovered using 
> https://android.googlesource.com/kernel/common -b android-4.9-o, but 
> I've verified the code path exists in msm-4.4. It likely exists in other 
> kernel versions as well.
> 
> As a privileged user, one can override the current SELinux context via a 
> call to setfscreatecon() or by writing directly to 
> /proc/self/attr/fscreate. The context is then used to label the next 
> newly created file object, e.g. mknod(). Upon handling the creation of 
> the new object on the EXT4 FS we end up calling 
> selinux_inode_init_security() to create a new xattr object for the 
> inode. This will end up calling context_struct_to_string() to convert 
> the SID back to the string version of the SELinux security context that 
> was stored.
> 
> static int context_struct_to_string(struct context *context, char 
> **scontext, u32 *scontext_len)
>   {
>      char *scontextp;
> 
>       if (scontext)
>           *scontext = NULL;
>       *scontext_len = 0;
> 
>       if (context->len) {
>          *scontext_len = context->len;
>            if (scontext) {
>                *scontext = kstrdup(context->str, GFP_ATOMIC);
>                 if (!(*scontext))
>                       return -ENOMEM;
>           }
>           return 0;
>       }
> 
> scontext is populated with the context length, directly from the context 
> structure, and using kstrdup() to copy the string. Much later down the 
> call stack ext4_xattr_set_entry() is called with the SELinux xattr object.
> 
> 
>               if (i->value == EXT4_ZERO_XATTR_VALUE) {
>                   memset(val, 0, size);
>               } else {
>                   /* Clear the pad bytes first. */
>                   memset(val + size - EXT4_XATTR_PAD, 0,
>                          EXT4_XATTR_PAD);
>                   memcpy(val, i->value, i->value_len);
>               }
> 
> SELinux allows for the creation of contexts that include NULL bytes. 
> Unfortunately in this case if a NULL byte occurs not as the string 
> terminator, then kstrdup() will allocate a memory region smaller than 
> what context->len represents. Later in ext4_xattr_set_entry() the 
> original context->len will be used in memcpy() and will exceed the heap 
> memory allocated by kstrdup() leading to an OOB issue. There may also be 
> the potential for memory corruption depending on the total length of the 
> SELinux context, but this would require further analysis.
> 
> Can you please let me know if my analysis is correct.
> As per me, it looks like there is problem in the code.

Your earlier commit efe3de79e0b52ca281ef6691480c8c68c82a4657 ensures 
that context->len is only ever set to strlen(str)+1.  So is it still 
possible for this condition to occur?

 >
> 
> Regards,
> Sachin Grover
