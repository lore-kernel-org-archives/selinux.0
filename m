Message-ID: <550B2390.7060702@tresys.com>
Date: Thu, 19 Mar 2015 15:29:20 -0400
From: Thomas Hurd <thurd@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libsepol: bool_copy_callback set state on creation
References: <1426784629-24048-1-git-send-email-thurd@tresys.com>
 <550B192A.7030008@tycho.nsa.gov>
In-Reply-To: <550B192A.7030008@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 03/19/2015 02:44 PM, Stephen Smalley wrote:
> On 03/19/2015 01:03 PM, Thomas Hurd wrote:
>> Boolean states are only written on a declaration.
>> If a module is turned off which includes a tunable declaration that
>> is required in another module, the state is never set. This patch
>> sets the state when the booldatum is created so that an uninitialized
>> memory read does not occur in cond_write_bool and write garbage to
>> the link binary.  This can cause a failure in cond_read_bool when
>> running semodule_expand.
>>
>> Signed-off-by: Thomas Hurd <thurd@tresys.com>
>> ---
>>   libsepol/src/link.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
>> index f98a8d2..f211164 100644
>> --- a/libsepol/src/link.c
>> +++ b/libsepol/src/link.c
>> @@ -630,6 +630,7 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>>   		state->base->p_bools.nprim++;
>>   		base_bool = new_bool;
>>   		base_bool->flags = booldatum->flags;
>> +		base_bool->state = booldatum->state;
>>   	} else if ((booldatum->flags & COND_BOOL_FLAGS_TUNABLE) !=
>>   		   (base_bool->flags & COND_BOOL_FLAGS_TUNABLE)) {
>>   			/* A mismatch between boolean/tunable declaration
>>
> Hmm...commit 3df79fc5ebf08a35aaa095b2ee3fd24b3ece6ae5 (libsepol: fix
> boolean state smashing) removed the setting of the state here, replacing
> it with conditional setting iff it is a decl further down.
>

I think the change to set the base_bool->state when the scope == SCOPE_DECL
solves the problem of a boolean getting the required state and not the
declared state.
If a bool is encountered in a require block before it's declared, the state
should be overwritten with the declared state. If a bool is required but not
declared, the state is never set.

Alternatively, we could change the malloc of new_bool to a calloc, and 
it should
solve the uninitialized memory issue.

To reproduce the problem I ran into, I updated modules.conf to turn off 
vmware, xen,
qemu, and virt modules.  semodule_expand failed in bool_isvalid on the 
state of virt_use_nfs.

     ==31226== Syscall param write(buf) points to uninitialised byte(s)
     ==31226==    at 0x53EB940: __write_nocancel (in 
/usr/lib64/libc-2.20.so)
     ==31226==    by 0x5373D2C: _IO_file_write@@GLIBC_2.2.5 (in 
/usr/lib64/libc-2.20.so)
     ==31226==    by 0x53751D8: _IO_do_write@@GLIBC_2.2.5 (in 
/usr/lib64/libc-2.20.so)
     ==31226==    by 0x53743EC: _IO_file_xsputn@@GLIBC_2.2.5 (in 
/usr/lib64/libc-2.20.so)
     ==31226==    by 0x5369E68: fwrite (in /usr/lib64/libc-2.20.so)
     ==31226==    by 0x4E65B06: put_entry (services.c:1665)
     ==31226==    by 0x4E3F57A: cond_write_bool (write.c:622)
     ==31226==    by 0x4E48488: hashtab_map (hashtab.c:235)
     ==31226==    by 0x4E4340F: policydb_write (write.c:2032)
     ==31226==    by 0x4E4BB75: sepol_module_package_write (module.c:959)
     ==31226==    by 0x401334: main (semodule_link.c:162)
     ==31226==  Address 0x4023706 is not stack'd, malloc'd or (recently) 
free'd
     ==31226==  Uninitialised value was created by a heap allocation
     ==31226==    at 0x4C29BCF: malloc (in 
/usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
     ==31226==    by 0x4E74420: bool_copy_callback (link.c:618)
     ==31226==    by 0x4E48488: hashtab_map (hashtab.c:235)
     ==31226==    by 0x4E776F8: copy_identifiers (link.c:1622)
     ==31226==    by 0x4E7A6AD: link_modules (link.c:2605)
     ==31226==    by 0x4E48F96: sepol_link_packages (module.c:322)
     ==31226==    by 0x401269: main (semodule_link.c:145)
