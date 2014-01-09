Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s09MO1Lf025290
 for <selinux@tycho.nsa.gov>; Thu, 9 Jan 2014 17:24:01 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so3891758pad.31
 for <selinux@tycho.nsa.gov>; Thu, 09 Jan 2014 14:23:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52CF1A53.9080501@redhat.com>
References: <52CF1A53.9080501@redhat.com>
Date: Thu, 9 Jan 2014 16:23:59 -0600
Message-ID: <CAFPpqQHaarHhzLEoB3mGO_WWRRt9Xpy-eTdmCzsWKUfHaAg2Ag@mail.gmail.com>
Subject: Re: Changing unlabeled_t on files to invalid_label_t.
From: Ted Toth <txtoth@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

+1

On Thu, Jan 9, 2014 at 3:53 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> We would like to change
>
> sid file_labels         gen_context(system_u:object_r:unlabeled_t,s0)
>
> to something like
>
> sid file_labels         gen_context(system_u:object_r:invalid_label_t,s0)
>
> Since explaining to someone that a file without a label is file_t, but if it
> has a label that the kernel does not understand it is labeled as unlabeled_t.
> A file with a label is unlabeled_t????  While a file without a label is file_t.
>
>
> #
> # unlabeled_t is the type of unlabeled objects.
> # Objects that have no known labeling information or that
> # have labels that are no longer valid are treated as having this type.
> #
>
> #
> # file_t is the default type of a file that has not yet been
> # assigned an extended attribute (EA) value (when using a filesystem
> # that supports EAs).
> #
>
> These two type definitions seem to conflict, with file_t winning at least on
> systems that support XAttrs.
>
> I would guess a better fix would be to change the kernel to handle the case
> where an object is unlabeled_t one way and if it is labeled and the kernel
> does not understand the label differently.
>
> sid invalid_file_labels gen_context(system_u:object_r:invalid_label_t,s0)
>
> Opinions....
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlLPGlMACgkQrlYvE4MpobOrDwCgwSduQpyqjGFni/0dksiv0I2j
> uEAAn181YTHYYRj0XSern/+CPtuUp7Vu
> =3HJ3
> -----END PGP SIGNATURE-----
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
