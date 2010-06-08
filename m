Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o58BwmNC032621
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2010 07:58:48 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o58Bvx1H016690
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2010 11:57:59 GMT
Message-ID: <4C0E3073.7010803@redhat.com>
Date: Tue, 08 Jun 2010 07:58:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Add chcon method to libselinux python bindings
References: <1275946805-9194-1-git-send-email-slawrence@tresys.com>
In-Reply-To: <1275946805-9194-1-git-send-email-slawrence@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I like it,  I have basically the same code in sandbox. and would move to 
this implementation if it is added to libselinux.

On 06/07/2010 05:40 PM, Steve Lawrence wrote:
> Adds a chcon method to the libselinux python bindings to change the
> context of a file/directory tree.
> ---
>   libselinux/src/selinuxswig_python.i |    8 ++++++++
>   1 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/selinuxswig_python.i
> index 8b34c99..dea0e80 100644
> --- a/libselinux/src/selinuxswig_python.i
> +++ b/libselinux/src/selinuxswig_python.i
> @@ -21,6 +21,14 @@ def restorecon(path, recursive=False):
>                                map(restorecon, [os.path.join(dirname, fname)
>                                                 for fname in fnames]), None)
>
> +def chcon(path, context, recursive=False):
> +    """ Set the SELinux context on a given path """
> +    lsetfilecon(path, context)
> +    if recursive:
> +        for root, dirs, files in os.walk(path):
> +            for name in files + dirs:
> +               lsetfilecon(os.path.join(root,name), context)
> +
>   def copytree(src, dest):
>       """ An SELinux-friendly shutil.copytree method """
>       shutil.copytree(src, dest)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
