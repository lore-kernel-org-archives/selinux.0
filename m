Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0MNblFX020704
	for <selinux@tycho.nsa.gov>; Sat, 22 Jan 2005 18:37:48 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0MNZhaB019358
	for <selinux@tycho.nsa.gov>; Sat, 22 Jan 2005 23:35:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: jwcart2@epoch.ncsc.mil
Subject: Re: [Fwd: New policy patch]
Date: Sun, 23 Jan 2005 10:37:37 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <41E57081.4090500@redhat.com> <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200501231037.37988.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 22 January 2005 07:36, James Carter <jwcart2@epoch.ncsc.mil> 
> > +# samba_domain(domain_prefix)
> > +#
> > +# Define a derived domain for the samba program when executed
> > +# by a user domain.
> > +#
> > +# The type declaration for the executable type for this program is
> > +# provided separately in domains/program/samba.te.
> > +#
> > +undefine(`samba_domain')
> > +ifdef(`samba.te', `
> > +define(`samba_domain',`
> > +if ( samba_enable_home_dirs ) {
> > +file_type_auto_trans(smbd_t, $1_home_dir_t, $1_home_t)
> > +}
> > +')
> > +', `
> > +define(`samba_domain',`')
> > +
> > +')dnl end if samba.te
>
> The file_type_auto_trans rule conflicts with the following rule in the
> user_domain macro in user_macros.te:
> file_type_auto_trans(privhome, $1_home_dir_t, $1_home_t)
> There is a conflict because smbd_t has the privhome attribute.
> For now I removed the privhome attribute from smbd_t.  Does it really
> need it?  NFS doesn't have that attribute.

The privhome attribute just does the same thing as that file_type_auto_trans, 
so either will do.

If we are going to support exporting home directories for read/write by NFS 
then it will need privhome too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
