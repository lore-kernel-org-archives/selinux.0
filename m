Message-ID: <552FA3D0.7080606@tycho.nsa.gov>
Date: Thu, 16 Apr 2015 07:58:08 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Nick Kralevich <nnk@google.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] Add empty top level Android.mk / CleanSpec.mk files
References: <1429135642-25619-1-git-send-email-nnk@google.com>
In-Reply-To: <1429135642-25619-1-git-send-email-nnk@google.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/15/2015 06:07 PM, Nick Kralevich wrote:
> Needed to allow Android to keep building with a copy of the SELinux
> source code checked into external/selinux
> 
> Bug: 19963152
> Change-Id: I4e192bb6ca5d185e11540aca7253e729d92a00c1

Thanks, applied.  I assume at some point you'll switch over to using the
external/selinux/{libsepol,checkpolicy,secilc} and drop
external/{libsepol,checkpolicy}, but retain external/libselinux since it
is a fork and differs substantially as described in its README.android
file.  I suppose someone could try to upstream all the changes, some
under conditional guards for ANDROID, but it wouldn't be trivial; I took
a hacksaw to libselinux originally for Android.

> ---
>  Android.mk   | 2 ++
>  CleanSpec.mk | 2 ++
>  2 files changed, 4 insertions(+)
>  create mode 100644 Android.mk
>  create mode 100644 CleanSpec.mk
> 
> diff --git a/Android.mk b/Android.mk
> new file mode 100644
> index 0000000..02f35a9
> --- /dev/null
> +++ b/Android.mk
> @@ -0,0 +1,2 @@
> +# This empty Android.mk file will prevent the build system
> +# from building anything below this point.
> diff --git a/CleanSpec.mk b/CleanSpec.mk
> new file mode 100644
> index 0000000..1ac5a62
> --- /dev/null
> +++ b/CleanSpec.mk
> @@ -0,0 +1,2 @@
> +# This empty CleanSpec.mk file will prevent the build system
> +# from descending into subdirs.
> 
