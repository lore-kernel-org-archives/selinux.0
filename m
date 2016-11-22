Subject: Re: segmentation fault in additive_scopes_to_cil()
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
References: <CAJfZ7=mvF8a32+-R1PK_kGP-uSFJFta427nnkzJbctUFGtu-DA@mail.gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <3334645b-cf98-b2c6-000a-3b74a480c04b@tycho.nsa.gov>
Date: Tue, 22 Nov 2016 10:06:13 -0500
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=mvF8a32+-R1PK_kGP-uSFJFta427nnkzJbctUFGtu-DA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/22/2016 08:55 AM, Nicolas Iooss wrote:
> Hello,
>
> I have been fuzzing semodule_package and /usr/libexec/selinux/hll/pp for a few
> days. After all the crashing policy modules it found because of missing bound
> checks and missing NULL pointer checks in libsepol (I will send some patches
> once I cleaned them [1]), the fuzzer found an other kind of crash: a NULL
> pointer execution in additive_scopes_to_cil_map(). Here is what gdb says when
> running pp on the file attached to this email:
>
> Starting program: /usr/libexec/selinux/hll/pp
> afl-out/pp/crashes/id:000001,sig:11,src:003451,op:flip2,pos:401
> libsepol.sepol_module_package_read: unknown magic number at section 1, offset:
> 2d1, number: 0
> (roleattributeset cil_gen_require object_r)
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000000000000000 in ?? ()
> => 0x0000000000000000:Cannot access memory at address 0x0
> (gdb) bt
> #0  0x0000000000000000 in ?? ()
> #1  0x00007ffff79ecd80 in additive_scopes_to_cil_map (key=<optimized out>,
> data=<optimized out>, arg=<optimized out>) at module_to_cil.c:3522
> #2  0x00007ffff79b096d in hashtab_map (h=0x60bd80,
> apply=apply@entry=0x7ffff79ecd10 <additive_scopes_to_cil_map>,
> args=args@entry=0x7fffffffd950) at hashtab.c:235
> #3  0x00007ffff7a09bb6 in additive_scopes_to_cil (decl_stack=0x6080b0,
> block=0x60b780, pdb=<optimized out>, indent=0) at module_to_cil.c:3544
> #4  block_to_cil (pdb=pdb@entry=0x6082e0, block=block@entry=0x60b780,
> stack=stack@entry=0x6080b0, indent=indent@entry=0) at module_to_cil.c:3631
> #5  0x00007ffff7a11af8 in global_block_to_cil (pdb=pdb@entry=0x6082e0,
> block=block@entry=0x60b780, stack=0x6080b0) at module_to_cil.c:3742
> #6  0x00007ffff7a13dc3 in blocks_to_cil (pdb=0x6082e0) at module_to_cil.c:3768
> #7  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff79165e0 <_IO_2_1_stdout_>,
> pdb=0x6082e0, linked=linked@entry=0) at module_to_cil.c:4055
> #8  0x00007ffff7a15a55 in sepol_module_package_to_cil
> (fp=fp@entry=0x7ffff79165e0 <_IO_2_1_stdout_>, mod_pkg=0x608280) at
> module_to_cil.c:4084
> #9  0x00000000004021c0 in main (argc=<optimized out>, argv=<optimized out>) at
> pp.c:150
>
>
> As far as I understand, this is because additive_scopes_to_cil() calls
> additive_scopes_to_cil_map() with args->sym_index = 0 [2], and func_to_cil[0] is
> NULL [3]. A simple fix would consist in starting the for loop
> in additive_scopes_to_cil() from args.sym_index = 1, but this may hide another
> bug. An other way to fix this bug would be to detect such an invalid policy
> earlier, if a valid policy is expected to always have empty decl->symtab[0]
> tables. What would you recommend to fix this?
>

I think that the safe way to fix it is to add a check before the call to 
hashtab_map.

Something like:
if (decl->symtab[args.sym_index] == NULL)
	continue;

Jim

> Cheers,
> Nicolas
>
> [1] Right now, my work-in-progress patches are
> in https://github.com/fishilico/selinux/commits/master
> [2] The relevant code
> is https://github.com/SELinuxProject/selinux/blob/libsepol-2.6/libsepol/src/module_to_cil.c#L3506-L3542
> [3] https://github.com/SELinuxProject/selinux/blob/libsepol-2.6/libsepol/src/module_to_cil.c#L3339
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
