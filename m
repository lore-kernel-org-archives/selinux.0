Subject: Re: Why do we block context="foobar" from User Namespace
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
References: <90ddcce6-a5eb-b05e-a347-ec8ef5c47db1@redhat.com>
Cc: Seth Forshee <seth.forshee@canonical.com>,
 "Eric W. Biederman" <ebiederm@redhat.com>, Paul Moore <paul@paul-moore.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <111a91e7-907d-6502-5715-ba8d8f3a850c@tycho.nsa.gov>
Date: Tue, 6 Dec 2016 15:31:40 -0500
MIME-Version: 1.0
In-Reply-To: <90ddcce6-a5eb-b05e-a347-ec8ef5c47db1@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/06/2016 03:04 PM, Daniel J Walsh wrote:
> Currently in SELinux and UserNamespace can not be enabled with Docker/runc at the same time.
> 
> Runc mounts tmpfs directories with --context="system_u:object_r:container_file_t:s0:c1,c2" type labels
> but the following patch blocks the use of context mounts when using user namespace.
> 
> http://kernel.suse.com/cgit/kernel/commit/?id=aad82892af261b9903cc11c55be3ecf5f0b0b4f8
> 
> User Namespace has to be established before tmpfs are mounted so we are unable to mount a
> tmpfs with a context=flag and UserNamespace enabled.
> 
> Controlling the ability to change the label of a mounted file systemd should be a MAC decision not a DAC, 
> or UserNamespace. Setting the SELinux labels on an object like a file system mount point
> should be controlled by SELinux.  SELinux should check if the label of the process doing the
> mount is able to relabel from the label of the mount point, and labelto the specified label.
> 
> SELinux does this for privileged processes (running with SYS_ADMIN) so use namespace should not be
> any different.  Also the process doing the mount would be allowed by DAC to set the label of the tmpfs after
> it is mounted (As long as SELinux allowed).
> 
> There is no security difference between:
> 
> mount -o tmpfs context="foobar" none /dev
> 
> 
> And
> 
> mount -o tmpfs none /dev
> 
> chcon foobar -R /dev
> 
> 
> The second would not be blocked by usernamespace.  
> 
> Bottom line this patch should be reverted so container runtimes like docker can use both User Namespace
> and SELinux at the same time.

I doubt we want to revert it entirely.  Looks like Smack has an explicit
exemption for tmpfs/ramfs (and sysfs, but it wouldn't really make sense
to do it there).  We could do something similar.
