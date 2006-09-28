Message-ID: <451C14D6.2060303@tresys.com>
Date: Thu, 28 Sep 2006 14:30:46 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: "Jeremy A. Mowery" <jmowery@tresys.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, selinux-dev@tresys.com
Subject: Re: [PATCH] libsepol: compile archive with -fpic
References: <1159293291.2723.14.camel@Bishop.columbia.tresys.com>
In-Reply-To: <1159293291.2723.14.camel@Bishop.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jeremy A. Mowery wrote:
> The libsepol archive is compiled normally without the -fpic flag.  This
> causes problems with other things that use libsepol.a with dynamic
> relocation on 64-bit machines.  The setools project uses libsepol.a in a
> shared object library; checkpolicy is prevented from being built as a
> position independent executable.  The following patch modifies
> libsepol's Makefile to build the archive using position independent
> code.
>
> --- libsepol/src/Makefile-orig  2006-09-19 10:03:54.000000000 -0400
> +++ libsepol/src/Makefile       2006-09-19 10:06:21.000000000 -0400
> @@ -24,7 +24,7 @@ $(LIBSO): $(LOBJS)
>         ln -sf $@ $(TARGET)
>
>  %.o:  %.c
> -       $(CC) $(CFLAGS) -c -o $@ $<
> +       $(CC) $(CFLAGS) -fpic -c -o $@ $<
>
>  %.lo:  %.c
>         $(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
>
>   
Thanks, merged as of libsepol 1.12.28

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
