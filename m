To: Sachin Grover <sachin.grover91@gmail.com>, selinux@tycho.nsa.gov
References: <CA+rE-2iGWee1L3rEH-nmqZ7Uda_F3V5JwFKS=H7DgTguXHdSPQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <20104711-3241-b24c-cc69-63d9efdd0b38@tycho.nsa.gov>
Date: Thu, 24 May 2018 08:25:49 -0400
MIME-Version: 1.0
In-Reply-To: <CA+rE-2iGWee1L3rEH-nmqZ7Uda_F3V5JwFKS=H7DgTguXHdSPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [Bug][KASAN] crash in xattr_getsecurity()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/24/2018 02:12 AM, Sachin Grover wrote:
> Hi,
> 
> Kernel panic is coming on calling lgetxattr() sys api with random user space value.
> 
> [   25.833951] Call trace:
> [   25.833954] [<ffffff86adc8af40>] dump_backtrace+0x0/0x2a8
> [   25.833957] [<ffffff86adc8b484>] show_stack+0x20/0x28
> [   25.833959] [<ffffff86ae02b744>] dump_stack+0xa8/0xe0
> [   25.833962] [<ffffff86ade79ed0>] xattr_getsecurity+0xac/0xd4
> [   25.833964] [<ffffff86ade79f90>] vfs_getxattr+0x98/0xcc
> [   25.833966] [<ffffff86ade7a548>] getxattr+0x9c/0x1d4
> [   25.833969] [<ffffff86ade7a6f4>] path_getxattr+0x74/0xc4
> [   25.833971] [<ffffff86ade7afd8>] SyS_lgetxattr+0x3c/0x48
> [   25.833973] [<ffffff86adc83770>] el0_svc_naked+0x24/0x28
> 
> setxattr() is getting size and value from the userspace, if I am giving size as 64840, my code is entering this part and crashing on doing memcpy under  xattr_getsecurity().
> 
> rc <http://opengrok.qualcomm.com/source/s?defs=rc&project=kernel_msm-4.9> = string_to_context_struct(&policydb, &sidtab, scontext2,
> 				      scontext_len <http://opengrok.qualcomm.com/source/s?defs=scontext_len&project=kernel_msm-4.9>, &context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>, def_sid <http://opengrok.qualcomm.com/source/s?defs=def_sid&project=kernel_msm-4.9>);
> 	*if* (rc <http://opengrok.qualcomm.com/source/s?defs=rc&project=kernel_msm-4.9> == -EINVAL <http://opengrok.qualcomm.com/source/s?defs=EINVAL&project=kernel_msm-4.9> && force <http://opengrok.qualcomm.com/source/s?defs=force&project=kernel_msm-4.9>) {
> 	context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>.str = str;
> 	context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>.len <http://opengrok.qualcomm.com/source/s?defs=len&project=kernel_msm-4.9> = scontext_len <http://opengrok.qualcomm.com/source/s?defs=scontext_len&project=kernel_msm-4.9>;
> 		str = NULL <http://opengrok.qualcomm.com/source/s?defs=NULL&project=kernel_msm-4.9>;
> 
> 
> 
> //rc value is coming as EINVAL(-22). In pass case rc value is always 0.
> 
> 
> Please let me know if this fix is good enough.
> 
> 
> rc <http://opengrok.qualcomm.com/source/s?defs=rc&project=kernel_msm-4.9> = string_to_context_struct(&policydb, &sidtab, scontext2,
> 				      scontext_len <http://opengrok.qualcomm.com/source/s?defs=scontext_len&project=kernel_msm-4.9>, &context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>, def_sid <http://opengrok.qualcomm.com/source/s?defs=def_sid&project=kernel_msm-4.9>);
> 	*if* (rc <http://opengrok.qualcomm.com/source/s?defs=rc&project=kernel_msm-4.9> == -EINVAL <http://opengrok.qualcomm.com/source/s?defs=EINVAL&project=kernel_msm-4.9> && force <http://opengrok.qualcomm.com/source/s?defs=force&project=kernel_msm-4.9>) {
> 	context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>.str = str;
> -      context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>.len <http://opengrok.qualcomm.com/source/s?defs=len&project=kernel_msm-4.9> = scontext_len <http://opengrok.qualcomm.com/source/s?defs=scontext_len&project=kernel_msm-4.9>;
> 
> +      context.len = strlen(str);
> 
> 		str = NULL <http://opengrok.qualcomm.com/source/s?defs=NULL&project=kernel_msm-4.9>;

IIUC, this is only possible if a process with CAP_MAC_ADMIN and that is allowed mac_admin permission in SELinux policy (or if SELinux is permissive) sets a security.selinux xattr with an embedded NUL on a file and then it or any other process performs a getxattr() on that file with a length greater than the length of the string up to the embedded NUL.  Is that accurate?  If so, then this is never possible on Android (no process is allowed mac_admin permission and SELinux is always enforcing) and is only possible in Fedora/RHEL for a few specific root/CAP_MAC_ADMIN processes in specific SELinux domains (sesearch -A -p mac_admin) if SELinux is enforcing or any root/CAP_MAC_ADMIN process if SELinux is permissive.  Regardless, not exploitable without CAP_MAC_ADMIN.  Also possible with a crafted filesystem image that already contains such an xattr.

Generally we include the terminating NUL in the length, so context.len would be strlen(str)+1.  Otherwise, I think your fix is reasonable.  I think this bug goes back to 9a59daa03df72526d234b91dd3e32ded5aebd3ef ("SELinux: fix sleeping allocation in security_context_to_sid").
