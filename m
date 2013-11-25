Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rAPLIFo0022419
	for <selinux@tycho.nsa.gov>; Mon, 25 Nov 2013 16:18:15 -0500
Message-ID: <5293BE8F.9020609@redhat.com>
Date: Mon, 25 Nov 2013 16:18:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>, selinux@tycho.nsa.gov
Subject: Re: MLS required even when MLS is disabled?
References: <20131125201239.GA24780@siphos.be>
In-Reply-To: <20131125201239.GA24780@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/25/2013 03:12 PM, Sven Vermeulen wrote:
> Hi all
> 
> I have a report that mentions that the new userspace release does not like 
> non-MLS policies:
> 
> # semanage fcontext -a -t swapfile_t "/swapfile" 
> libsepol.context_from_record: MLS is disabled, but MLS context "s0" found
> (No such file or directory). libsepol.context_from_record: could not create
> context structure (Invalid argument). libsemanage.validate_handler: invalid
> context system_u:object_r:swapfile_t:s0 specified for /swapfile [all files]
> (Invalid argument). libsemanage.dbase_llist_iterate: could not iterate over
> records (Invalid argument). OSError: Invalid argument
> 
> # semanage login -a -s staff_u amade libsemanage.validate_handler: MLS is
> disabled, but MLS range s0 was found for Unix user amade (No such file or
> directory). libsemanage.validate_handler: seuser mapping [amade ->
> (staff_u, s0)] is invalid (No such file or directory). 
> libsemanage.dbase_llist_iterate: could not iterate over records (No such
> file or directory). OSError: No such file or directory
> 
Could be a bug in seobject.py
> Any idea what could be the cause of this?
> 
> Wkr, Sven Vermeulen
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKTvo8ACgkQrlYvE4MpobOVVQCfeXvUI7+sK593FWbKN+XKXT0t
xDcAoKdwwXC/Dy+HRGlzQh7NiYajGzvt
=/GoP
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
