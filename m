Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3JFrd5L015927
	for <selinux@tycho.nsa.gov>; Mon, 19 Apr 2010 11:53:39 -0400
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3JFr7Av029870
	for <selinux@tycho.nsa.gov>; Mon, 19 Apr 2010 15:53:07 GMT
Received: by gwj21 with SMTP id 21so751216gwj.12
        for <selinux@tycho.nsa.gov>; Mon, 19 Apr 2010 08:53:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BCC69C0.5040502@redhat.com>
References: <4BCC69C0.5040502@redhat.com>
Date: Mon, 19 Apr 2010 11:53:38 -0400
Message-ID: <t2s10143821004190853r1a114b33q7c9416e43b8b5433@mail.gmail.com>
Subject: Re: refpolicy is missing on lots of hits with audit2allow -R.
From: Karl MacMillan <karlwmacmillan@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Karl MacMillan <kmacmillan@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Apr 19, 2010 at 10:33 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> The reason for this is threshold, setting.  I think the interfaces are
> getting more complicated and one AVC that is looking for read ends up
> being two far different from the threshold, so audit2allow does not
> report it.
>

Is it really that the interfaces have more access in them or is it
that our measure of difference is off? See below.

[snip]

>
> If you look at the interface userdom_read_home_certs.
>
> [InterfaceVector userdom_read_home_certs $1:source ]
> $1,home_cert_t,file,read,lock,getattr,open,ioctl
> $1,home_cert_t,dir,ioctl,search,read,lock,open,getattr
> $1,home_cert_t,lnk_file,read,getattr
> $1,home_root_t,dir,getattr,open,search
> $1,home_root_t,lnk_file,read,getattr
> $1,user_home_dir_t,dir,getattr,open,search
> $1,user_home_dir_t,lnk_file,read,getattr
>
> A domain that is allowed to search the homedir is always going to
> generate an AVC that is a long way off.
>

Seems to me that the problem is that the read / getattr on
user_home_dir_t directories and files is adding too much distance.

> I thing we should either remove the bastards and just add all as childs,
> or recode it like the attachment.
>

I'm against removing the threshold altogether - if we do that then
we'll get a match for almost everything including completely wrong
interfaces. Can we start with tweaking either the perm weights or the
distance calculation? For example, what happens when you drop the
weight for dir read down to 5 or 1 and similar for lnk_file (they are
both 10 right now)? After that we might need to tweak the threshold.

Also - I've been hacking on a patch to add in attribute access to the
interface vectors. Any idea how much help we would get from that?

Karl

> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.14 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkvMacAACgkQrlYvE4MpobNeAgCfcoVssEQJ8mfZT/aBvAt0z7+3
> CoMAnR1bOcXk7x/jIZ+0i2Kc/faUJAVk
> =Uuf7
> -----END PGP SIGNATURE-----
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
