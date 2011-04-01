Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p31GZlqw019176
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 12:35:47 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p31GZkmB024763
	for <selinux@tycho.nsa.gov>; Fri, 1 Apr 2011 16:35:47 GMT
Received: by ewy8 with SMTP id 8so1147163ewy.12
        for <selinux@tycho.nsa.gov>; Fri, 01 Apr 2011 09:35:46 -0700 (PDT)
Message-ID: <4D95FEDF.9010907@gmail.com>
Date: Fri, 01 Apr 2011 18:35:43 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Bill Chimiak <wch1m1@gmail.com>
CC: selinux-mailing-list <selinux@tycho.nsa.gov>
Subject: Re: fwknop, fwknopd,  fwknop_serv
References: <201104011210.36367.w.chimiak@ieee.org>
In-Reply-To: <201104011210.36367.w.chimiak@ieee.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/01/2011 06:10 PM, Bill Chimiak wrote:
> fwknop is a single passphrase authorization system.
> Fairly cool.  selinux did not like fwknop out of the box.
> It wanted a new module:
> 
> module iptab2log 1.0;
> 
> require {
>         type var_log_t;
>         type iptables_t;
>         class file write;
> }
> 
> #============= iptables_t ==============
> allow iptables_t var_log_t:file write;

Did you notice any loss of functionality?

This may be a leaked file descriptor or something may be passing the
open file to iptables.

You may be able to dontaudited this:

dontaudit iptables_t var_log_t:file write;

Which file exactly is it trying to write to?

By the way this is not the optimal list to be posting this to.

> It works now.  Was there another way to do this?
> William J. Chimiak
> Laboratory for Telecommunication Sciences 
> 8080 Greenmead Drive,  College Park, MD 20740
> 301-422-5217
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2V/t8ACgkQMlxVo39jgT9fUwCdFJjDtXHn1mEneKmP2H9RAk64
+BgAn3SkOt3TuYAAcHr7M1PpGJRZyQYo
=UI5R
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
