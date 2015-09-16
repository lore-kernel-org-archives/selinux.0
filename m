Subject: Re: ftruncate triggering open denial
To: Jeffrey Vander Stoep <jeffv@google.com>, SELinux <Selinux@tycho.nsa.gov>,
 eparis@redhat.com
References: <CABXk95A9ge6asZf0oFemLLxLG3Y5VxfYQkpchgM0Ae1f1tRN+g@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55F9B780.7010105@tycho.nsa.gov>
Date: Wed, 16 Sep 2015 14:40:00 -0400
MIME-Version: 1.0
In-Reply-To: <CABXk95A9ge6asZf0oFemLLxLG3Y5VxfYQkpchgM0Ae1f1tRN+g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/16/2015 01:51 PM, Jeffrey Vander Stoep wrote:
> I’m seeing the following denial after an ftruncate call:
> avc: denied { open } for name="test" dev="dm-2" ino=8909
> scontext=u:r:isolated_app:s0:c512,c768
> tcontext=u:object_r:app_data_file:s0:c512,c768 tclass=file permissive=0
> 
> The isolated_app process has been passed the open file descriptor and it
> has the write permission:
> 
> Truncating an open file should only require the write permission. The
> following commit introduced this functionality:
>     
> commit 95dbf739313f09c8d859bde1373bc264ef979337
> Author: Eric Paris <eparis@redhat.com <mailto:eparis@redhat.com>>
> Date:   Wed Apr 4 13:45:34 2012 -0400
> 
>     SELinux: check OPEN on truncate calls
>     
>     In RH BZ 578841 we realized that the SELinux sandbox program was
> allowed to
>     truncate files outside of the sandbox.  The reason is because sandbox
>     confinement is determined almost entirely by the 'open' permission. 
> The idea
>     was that if the sandbox was unable to open() files it would be
> unable to do
>     harm to those files.  This turns out to be false in light of
> syscalls like
>     truncate() and chmod() which don't require a previous open() call. 
> I looked
>     at the syscalls that did not have an associated 'open' check and
> found that
>     truncate(), did not have a seperate permission and even if it did have a
>     separate permission such a permission owuld be inadequate for use by
>     sandbox (since it owuld have to be granted so liberally as to be
> useless).
>     This patch checks the OPEN permission on truncate.  I think a better
> solution
>     for sandbox is a whole new permission, but at least this fixes what
> we have
>     today.
>     
>     Signed-off-by: Eric Paris <eparis@redhat.com <mailto:eparis@redhat.com>>
> 
> Perhaps this should distinguish between truncate and ftruncate calls?

I don't see a way to do that offhand without a new hook.  Maybe based on
ia_valid flag difference but that seems fragile.

If we don't allow isolated_app app_data_file:dir search;, then we don't
actually need to restrict open; you can't use open (or truncate or link
or chmod) on a file by pathname without search access to its parent.
