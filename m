From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sachin Grover <grover_sachin@outlook.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
References: <CO1PR14MB10615AE03A49927CC39A041986390@CO1PR14MB1061.namprd14.prod.outlook.com>
 <531392a3-1a17-9732-3a89-4231339f800d@tycho.nsa.gov>
 <19b33f36-0dbd-12e3-e224-5aa4b8c796f2@tycho.nsa.gov>
 <CO1PR14MB10618CA82AFA6551A776376986390@CO1PR14MB1061.namprd14.prod.outlook.com>
 <45661f73-3bfa-ad2d-d4c6-5ea03a093ac5@tycho.nsa.gov>
 <CO1PR14MB106114A87AD82A0D6895EC6986320@CO1PR14MB1061.namprd14.prod.outlook.com>
 <6341012b-a3ca-d00c-0d71-ed27f8a810ae@tycho.nsa.gov>
Message-ID: <4dcf084b-25ca-2f2f-4bba-11282a0e59ee@tycho.nsa.gov>
Date: Mon, 20 Aug 2018 14:05:25 -0400
MIME-Version: 1.0
In-Reply-To: <6341012b-a3ca-d00c-0d71-ed27f8a810ae@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: Possible OOB Read in Kernel Heap Memory in call to
 ext4_xattr_set_entry()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/20/2018 10:02 AM, Stephen Smalley wrote:
> On 08/20/2018 02:29 AM, Sachin Grover wrote:
>> Hi,
>>
>> My POC uses fscreate() to modify the current SELinux context of the 
>> running process, it then creates a new node via mknod(), (), which is 
>> then going to assign the current SLEinux context over to that object.
>>
>> In the call path I am seeing security_sid_to_context_core().
>>
>> I see a code path where it in fact seem to correctly take the strlen() 
>> of the incoming context, based on the sid, and use kmemdup(), but that 
>> only occurs when SELinux is not initialized.
>>
>>      if (!ss_initialized) {
>>             if (sid <= SECINITSID_NUM) {
>>                     char *scontextp;
>>
>>                     *scontext_len = strlen(initial_sid_to_string[sid]) 
>> + 1;
>>                     if (!scontext)
>>                             goto out;
>>                     scontextp = kmemdup(initial_sid_to_string[sid],
>>                                        *scontext_len, GFP_ATOMIC);
>>                     if (!scontextp) {
>>                             rc = -ENOMEM;
>>                             goto out;
>>                     }
>>                     *scontext = scontextp;
>>                     goto out;
>>             }
>>             printk(KERN_ERR "SELinux: %s:  called before initial "
>>                    "load_policy on unknown SID %d\n", __func__, sid);
>>             rc = -EINVAL;
>>             goto out;
>>      }
>>
>> Once SELinux is initialized that block will be skipped and further 
>> down you’ll see the call to context_struct_to_string() which copies 
>> the context using kstrdup() and uses the incoming length rather than 
>> the strlen() length.
> 
> context_struct_to_string() sets *scontext_len to context->len, which was 
> previously set by security_context_to_sid_core() to strlen(str) + 1 
> after your prior commit. Correct?
> 
>   In addition to this I’m not sure how safe using
>> strlen() is in general as there seems to be an assumption that context 
>> strings can contain NULL characters based on this comment.
>>
>>                            /* We strip a nul only if it is at the end, 
>> otherwise the
>>                             * context contains a nul and we should 
>> audit that */
>>                            if (str[size - 1] == '\0')
>>                                   audit_size = size - 1;
>>                            else
>>                                   audit_size = size;
> 
> This audit-related code has to deal with the possibility that there is 
> an embedded NUL (and might also lack a terminating NUL) because it is 
> dealing with the original user-supplied value, not a string that has 
> been stored in a context structure. After this audit-related code, we 
> proceed to call security_context_to_sid_force() which calls 
> security_context_to_sid_core() with force=1.  This first creates a 
> NUL-terminated copy of the value (scontext) as scontext2 using 
> kmemdup_nul(), which could potentially contain embedded NULs if the 
> original did.  In the force=1 case, it then creates a copy of scontext2 
> as str using kstrdup(), yielding a NUL-terminated string with no 
> embedded NULs. It is this NUL-terminated string (str) that is stored in 
> the context structure as context.str and context.len is set to 
> strlen(str)+1 after your earlier commit.
> 
> How would we end up with a context->len other than 
> strlen(context->str)+1 in security_sid_to_context_core()?
> 
> The point is that we ought to sanitize context->len when it is set, not 
> when it is read, and in theory that is exactly what we are doing in 
> security_context_to_sid_core(), such that security_sid_to_context_core() 
> can read that value without recomputing it.  If it is being set 
> incorrectly somewhere else, we ought to fix it there.  If it is being 
> corrupted through memory corruption, then we ought to fix the source of 
> the memory corruption.
> 
>>
>> Call StacK:
>>
>> [<ffffffff80430b25>] kasan_report+0x32c/0x485 mm/kasan/report.c:309
>> [<ffffffff8042fafb>] check_memory_region_inline mm/kasan/kasan.c:301 
>> [inline]
>> [<ffffffff8042fafb>] check_memory_region+0x2b/0x130 mm/kasan/kasan.c:315
>> [<ffffffff8042fc38>] __asan_loadN+0xf/0x11 mm/kasan/kasan.c:745
>> [<ffffffff805775be>] ext4_xattr_set_entry+0x6a1/0x6d3 fs/ext4/xattr.c:747
>> [<ffffffff805790ab>] ext4_xattr_ibody_set.isra.9+0x4f/0x118 
>> fs/ext4/xattr.c:1118
>> [<ffffffff8057a1cb>] ext4_xattr_set_handle+0x39a/0x7b4 
>> fs/ext4/xattr.c:1224
>> [<ffffffff80582683>] ext4_initxattrs+0x6b/0x96 
>> fs/ext4/xattr_security.c:42
>> [<ffffffff805ecd43>] security_inode_init_security+0x170/0x1c9 
>> security/security.c:403
>> [<ffffffff8058275d>] ext4_init_security+0x35/0x3d 
>> fs/ext4/xattr_security.c:56
>> [<ffffffff8050295a>] __ext4_new_inode+0x1f24/0x2266 fs/ext4/ialloc.c:1059
>> [<ffffffff8051f771>] ext4_mknod+0x11a/0x263 fs/ext4/namei.c:2510
>> [<ffffffff8044d8e6>] vfs_mknod2+0x1ee/0x29f fs/namei.c:3722
>> [<ffffffff804554fb>] SYSC_mknodat fs/namei.c:3780 [inline]
>> [<ffffffff804554fb>] SyS_mknodat+0x19a/0x22a fs/namei.c:3752
>> [<ffffffff802028f9>] do_syscall_64+0xf8/0x191 arch/x86/entry/common.c:282
>> [<ffffffff80fa963e>] entry_SYSCALL_64_after_swapgs+0x58/0xc6
>>
>> Syzkaller reproducer:
>> # {Threaded:false Collide:false Repeat:false Procs:1 Sandbox:none 
>> Fault:false FaultCall:-1 FaultNth:0 EnableTun:false UseTmpDir:false 
>> EnableCgroups:false EnableNetdev:false ResetNet:false HandleSegv:false 
>> WaitRepeat:false Debug:false Repro:false}
>> r0 = syz_open_procfs(0xffffffffffffffff, 
>> &(0x7f00000002c0)='attr/fscreate\x00')
>> write$cgroup_pid(r0, &(0x7f0000000180)=ANY=[
>> ANYBLOB <https://people.qualcomm.com/People?id=ANYBLOB>
>> ="37393430ad3c35020000000000000023959c533574eab7032c45f6d7384f73ab"], 
>> 0x20)
>> syz_fuseblk_mount(&(0x7f0000000000)='./file0\x00', 
>> &(0x7f0000000080)='./file0\x00', 0xe003, 0x0, 0x0, 0x100000000, 0x4, 0x0)
>>
>> Please let me know if something is wrong with the way I am seeing this.

> I'm not clear on how to read the above reproducer information.  Are you 
> writing the string 
> "37393430ad3c35020000000000000023959c533574eab7032c45f6d7384f73ab" with 
> a length of 0x20 to /proc/self/attr/create?

If so, then I have not been able to reproduce the problem on a kernel 
with your earlier commit applied.  I can however do so on a kernel with 
your earlier commit reverted, which is what I would expect.
