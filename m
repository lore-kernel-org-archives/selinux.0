Message-ID: <43E80F9E.5070909@tresys.com>
Date: Mon, 06 Feb 2006 22:10:22 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] Add seuser and user_extra to package format
References: <43E7D03D.4090909@tresys.com> <43E80E52.6090503@cornell.edu>
In-Reply-To: <43E80E52.6090503@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Please try with the following patch on top:
> 
> - removes system databases, which are unnecessary, write directly to the 
> final file
> - fix 64-bit bugs Joshua's introducing :)
> 
> I will resync my nodecon patch tomorrow - let me know if anything's 
> wrong with it, otherwise will submit as is (ordering pending in a later 
> patch).
<snip>
> diff -Naurp --exclude-from excludes old/libsepol/src/module.c new/libsepol/src/module.c
> --- old/libsepol/src/module.c	2006-02-06 21:55:11.000000000 -0500
> +++ new/libsepol/src/module.c	2006-02-06 21:44:15.000000000 -0500
> @@ -460,7 +460,8 @@ int sepol_module_package_read(sepol_modu
>  			break;
>  		default:
>  			/* unknown section, ignore */	
> -			ERR(file->handle, "unknown magic number at section %u, offset: %zx, number: %zx ",i, offsets[i],le32_to_cpu(buf[0]));
> +			ERR(file->handle, "unknown magic number at section %u, offset: %zx, number: %ux ", 
> +				i, offsets[i],le32_to_cpu(buf[0]));
>  			break;
>  		}

oops, I meant to remove that, it was there for debugging.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
