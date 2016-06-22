Subject: Re: abnormal SELinux context labels
To: Bond Masuda <bond.masuda@jlbond.com>, selinux@tycho.nsa.gov
References: <05514320-f873-9b48-455e-e6c7caff4135@jlbond.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a17a0faf-5a36-2f01-423c-d26566b226e0@tycho.nsa.gov>
Date: Wed, 22 Jun 2016 14:54:37 -0400
MIME-Version: 1.0
In-Reply-To: <05514320-f873-9b48-455e-e6c7caff4135@jlbond.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/22/2016 02:05 PM, Bond Masuda wrote:
> I'm installing CentOS 7 in a chroot'd environment to build new images of
> CentOS 7 for a private cloud environment. I've done this successfully
> before with CentOS 6 (with help from this list) and we have an automated
> process of doing that now. I'm now porting our process to do similarly
> for CentOS 7. However, after our process is complete, certain
> directories/symlinks have abnormal SELinux contexts assigned to them.
> This causes the system to fail to boot since we have SELinux enforcing
> by default and one of the problematic symlinks is /lib64.
> 
> Here is what we see in the CentOS 7 build tree root directory, right
> after a fresh install of CentOS 7 from the full updates repo:
> 
> |# ls -alZ /
> dr-xr-xr-x. root root system_u:object_r:root_t:s0      .
> dr-xr-xr-x. root root system_u:object_r:root_t:s0      ..
> drwxr-xr-x. root root system_u:object_r:auditd_log_t:s0 audit
> lrwxrwxrwx. root root system_u:object_r:bin_t:s0       bin -> usr/bin
> dr-xr-xr-x. root root system_u:object_r:boot_t:s0      boot
> drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 dev
> drwxr-xr-x. root root system_u:object_r:etc_t:s0       etc
> drwxr-xr-x. root root system_u:object_r:home_root_t:s0 home
> lrwxrwxrwx. root root /usr/lib                         lib -> usr/lib
> lrwxrwxrwx. root root /usr/lib                         lib64 -> usr/lib64
> drwxr-xr-x. root root system_u:object_r:mnt_t:s0       media
> drwxr-xr-x. root root system_u:object_r:mnt_t:s0       mnt
> drwxr-xr-x. root root system_u:object_r:usr_t:s0       opt
> drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 proc
> dr-xr-x---. root root system_u:object_r:admin_home_t:s0 root
> drwxr-xr-x. root root /var/run                         run
> lrwxrwxrwx. root root system_u:object_r:bin_t:s0       sbin -> usr/sbin
> drwxr-xr-x. root root system_u:object_r:var_t:s0       srv
> drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 sys
> drwxrwxrwt. root root system_u:object_r:tmp_t:s0       tmp
> drwxr-xr-x. root root system_u:object_r:usr_t:s0       usr
> drwxr-xr-x. root root system_u:object_r:var_t:s0       var
> 
> |As you can see, the SELinux context for "lib", is "/usr/lib"!!! and
> similarly, for "lib64", it is "/usr/lib" ... those are not even valid
> context labels!
> 
> How can an invalid string like "/usr/lib" even be assigned as a SELinux
> label in the first place?
> 
> I can workaround this with a manual fix using 'chcon
> system_u:object_r:type_label:s0 path', but I'm just wondering how this
> can happen in the first place? When I try to manually reproduce the
> invalid label, I get this:
> 
> # chcon /usr/lib lib
> chcon: invalid context: /usr/lib
> 
> Any insights would be appreciated...
> Bond

I'm assuming you are running the labeling process in a domain that has
CAP_MAC_ADMIN and mac_admin in SELinux policy, e.g. setfiles_mac_t or
livecd_t.

You would have done that in order to allow it to set labels on files
that may not be defined in the build host policy.

A process with that permission can set any arbitrary string value it
wants as the security.selinux attribute; by design, SELinux on the build
host OS will ignore it and just treat it as if it has the unlabeled context.

So if there is a bug in your labeling program such that it is passing a
pathname rather than a label, then you would get the results you are seeing.

When you try to do it by hand above, you are presumably not running in a
domain with mac_admin permission, and therefore it won't let you set an
unknown value.
