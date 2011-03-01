Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p21HsvuE026989
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2011 12:54:57 -0500
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p21HsvhD025469
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2011 17:54:57 GMT
Message-ID: <4D6D32F8.701@tresys.com>
Date: Tue, 01 Mar 2011 12:55:04 -0500
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: selinux man page fixes
References: <4D488B3F.8030203@redhat.com>
In-Reply-To: <4D488B3F.8030203@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/01/2011 05:37 PM, Daniel J Walsh wrote:

> diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
> index 5caa592..1fc5b95 100644
> --- a/libselinux/man/man8/selinux.8
> +++ b/libselinux/man/man8/selinux.8
> @@ -1,7 +1,7 @@
>  .TH  "selinux"  "8"  "29 Apr 2005" "dwalsh@redhat.com" "SELinux Command Line documentation"
>
>  .SH "NAME"
> -selinux \- NSA Security-Enhanced Linux (SELinux)
> +SELinux \- NSA Security-Enhanced Linux (SELinux)
>
>  .SH "DESCRIPTION"
>
> @@ -62,12 +62,12 @@ compile-time tunable options and a set of runtime policy booleans.
>  .B system-config-securitylevel
>  allows customization of these booleans and tunables.
>
> -Many domains that are protected by SELinux also include selinux man pages explainging how to customize their policy.
> +Many domains that are protected by SELinux also include SELinux man pages explaining how to customize their policy.
>
>  .SH FILE LABELING
>
>  All files, directories, devices ... have a security context/label associated with them.  These context are stored in the extended attributes of the file system.
> -Problems with SELinux often arise from the file system being mislabeled. This can be caused by booting the machine with a non selinux kernel.  If you see an error message containing file_t, that is usually a good indicator that you have a serious problem with file system labeling.
> +Problems with SELinux often arise from the file system being mislabeled. This can be caused by booting the machine with a non SELinux kernel.  If you see an error message containing file_t, that is usually a good indicator that you have a serious problem with file system labeling.
>
>  The best way to relabel the file system is to create the flag file /.autorelabel and reboot.  system-config-securitylevel, also has this capability.  The restorcon/fixfiles commands are also available for relabeling files.

Acked-by: Steve Lawrence <slawrence@tresys.com>

Merged as of libselinux to 2.0.99

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
