Subject: Re: [PATCH] libsepol: compile archive with -fpic
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Jeremy A. Mowery" <jmowery@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <1159293291.2723.14.camel@Bishop.columbia.tresys.com>
References: <1159293291.2723.14.camel@Bishop.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 07:43:44 -0400
Message-Id: <1159357424.32075.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-26 at 13:54 -0400, Jeremy A. Mowery wrote:
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

There is a cost associated with doing that.  Possibly we could provide a
libsepol_pic.a.  See:
http://www.mail-archive.com/debian-devel@lists.debian.org/msg239046.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
