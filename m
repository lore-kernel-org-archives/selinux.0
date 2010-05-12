Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4CCePIw029504
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 08:40:26 -0400
Received: from n21.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o4CCdkfD011283
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 12:39:47 GMT
Message-ID: <763526.67394.qm@web87009.mail.ird.yahoo.com>
Date: Wed, 12 May 2010 12:40:23 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: RE: New to SELinux: 2nd Edition of The SELinux Notebook released
To: selinux@tycho.nsa.gov, David-P63356Thomson <David.Thomson@gdc4s.com>,
        Vacheh Sardarian <vsardarian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just finished the 2nd edition of the SELinux Notebook that is available at:

http://www.freetechbooks.com/the-selinux-notebook-the-foundations-t785.html

It is aimed at those new to SELinux and as a reference for the policy language and configuration files.

If anyone has comments on how to improve, what other areas to cover, corrections etc. please let me know.

I'll now update the selinuxproject.org site with the new content as part of the SELinux documentation project.

 
The main updates are:
  Split the Notebook into two volumes:
   Volume 1 - The Foundations - covers SELinux and its supporting services.
   Volume 2 - Sample Policy Source - contains sample application and 
   policy source code to build a simple message filter and experiment with
   X-Windows.

 Updated all relevant sections to reflect Fedora 12 release and correct
 errors.
 Added secolors.conf and VM configuration files, typebounds Policy 
 language statement.

Added sections on:
XSELinux for X-Windows support and sample polyinstantiation code and policy.
Virtual machine support with examples.
SE-PostgreSQL support with an example database.
Apache / SELinux-Plus support.

Richard


--- On Tue, 11/5/10, Thomson, David-P63356 <David.Thomson@gdc4s.com> wrote:

> From: Thomson, David-P63356 <David.Thomson@gdc4s.com>
> Subject: RE: New to SELinux: how to get familiar
> To: "Daniel J Walsh" <dwalsh@redhat.com>, "Chad Sellers" <csellers@tresys.com>
> Cc: "Vacheh Sardarian" <vsardarian@gmail.com>, selinux@tycho.nsa.gov
> Date: Tuesday, 11 May, 2010, 18:27
> I actually filed an exception request
> for that last one with my company
> since they block livejournal traffic.  They assume
> you're not doing work
> if you go there.  Surprisingly, the google-cached
> version is still
> working and is the only way I can get to your stuff. 
> Good stuff though!
> 
> DT
> 
> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com]
> 
> Sent: Tuesday, May 11, 2010 6:30 AM
> To: Chad Sellers
> Cc: Vacheh Sardarian; selinux@tycho.nsa.gov;
> Thomson, David-P63356
> Subject: Re: New to SELinux: how to get familiar
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> http://docs.fedoraproject.org/selinux-user-guide/f12/en-US/
> http://docs.fedoraproject.org/selinux-user-guide/f12/en-US/
> 
> And my favorite...
> 
> http://danwalsh.livejournal.com
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.14 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAkvpW8AACgkQrlYvE4MpobPbxgCgzYMsZn6J7xojpL05PjV0ubSF
> rP8AoKJm1UvqSVDwPP06NE3p2M78rZlX
> =oATs
> -----END PGP SIGNATURE-----
> 
> 
> --
> This message was distributed to subscribers of the selinux
> mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the
> message.
>




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
