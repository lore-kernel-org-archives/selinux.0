Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p4OLFr9V024434
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 17:15:53 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p4OLFqX7010741
	for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 21:15:53 GMT
Received: by ewy8 with SMTP id 8so2405810ewy.12
        for <selinux@tycho.nsa.gov>; Tue, 24 May 2011 14:15:51 -0700 (PDT)
Subject: Re: Is it possible to assign different labels to symbolic links and
 actual files?
From: Dominick Grift <domg472@gmail.com>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Tue, 24 May 2011 23:15:41 +0200
In-Reply-To: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>
References: <BANLkTi=UEBFLWeWMov7GjOn_-Q3QuyTyxw@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-uJuxlFx23ucQAIgreyls"
Message-ID: <1306271750.4500.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-uJuxlFx23ucQAIgreyls
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2011-05-24 at 13:46 -0700, Sam Gandhi wrote:

> Is there no way to assign different label to symlink and actual files?
> Is this file-system specific issue? Are there any file-system that
> support assigning seperate labels to symlink and actual file?

You can assign different labels to symbolic links and other type of
files.

When you specify a file context for a particular file you can specify
the nature of the file

This is just like you would normally get attributes "of files"

The bits start with any of these
- (file)
d (dir)
l (link file)
s (socket)
p (pipe)
c (character file)
b (block file)

So when you specify a context for a single file you would:

semanage fcontext -a -t mytype_t /path/myfile

That is the default behaviour.

I suspect this will yield the same result:

semanage fcontext -a -t mytype_t -f -- /path/myfile

If you use a file content file you would:

/path/myfile -- gen_context(system_u:object_r:mytype_t, s0)

Note the --, it means this is a single file

Now lets specify a symlink

semanage fcontext -a -t mylnk_t -f -l /path/link

or with a file context file

/path/link -l gen_context(system_u:object_r:mylnk_t, s0)

other examples

/path/fifo -p gen_context(system_u:object_r:mypipe_t, s0)
/path/mycharacterfile -c gen_context(system_u:object_r:mycharfile_t, s0)
/path/myblockfile -b gen_context(system_u:object_r:myblkfile_t, s0)
/path/mysocket -s gen_context(system_u:object_r:mysockfile_t, s0)

note though that restoring the context of lnk files can be confusing.
chcon also have a special option (-h) for symlinks.


--=-uJuxlFx23ucQAIgreyls
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABEKAAYFAk3cH/0ACgkQMlxVo39jgT/aCACgslrDnYCw+am7OsqSPcjIwfMP
UugAoI7IZ1tIjhmr82igJARgkxNL9fZg
=h6it
-----END PGP SIGNATURE-----

--=-uJuxlFx23ucQAIgreyls--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
