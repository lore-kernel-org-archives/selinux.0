Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5AL4AoI003878
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 17:04:10 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o5AL3Nul023068
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 21:03:23 GMT
Date: Thu, 10 Jun 2010 17:04:09 -0400
Subject: Re: [PATCH] Add chcon method to libselinux python bindings
From: Chad Sellers <csellers@tresys.com>
To: Steve Lawrence <slawrence@tresys.com>, <selinux@tycho.nsa.gov>
Message-ID: <C836CB89.B8DCE%csellers@tresys.com>
In-Reply-To: <1275946805-9194-1-git-send-email-slawrence@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 6/7/10 5:40 PM, "Steve Lawrence" <slawrence@tresys.com> wrote:

> Adds a chcon method to the libselinux python bindings to change the
> context of a file/directory tree.
> ---
>  libselinux/src/selinuxswig_python.i |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/libselinux/src/selinuxswig_python.i
> b/libselinux/src/selinuxswig_python.i
> index 8b34c99..dea0e80 100644
> --- a/libselinux/src/selinuxswig_python.i
> +++ b/libselinux/src/selinuxswig_python.i
> @@ -21,6 +21,14 @@ def restorecon(path, recursive=False):
>                               map(restorecon, [os.path.join(dirname, fname)
>                                                for fname in fnames]), None)
>  
> +def chcon(path, context, recursive=False):
> +    """ Set the SELinux context on a given path """
> +    lsetfilecon(path, context)
> +    if recursive:
> +        for root, dirs, files in os.walk(path):
> +            for name in files + dirs:
> +               lsetfilecon(os.path.join(root,name), context)
> +
>  def copytree(src, dest):
>      """ An SELinux-friendly shutil.copytree method """
>      shutil.copytree(src, dest)

Acked-by: Chad Sellers <csellers@tresys.com>

Merged as of libselinux 2.0.95


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
