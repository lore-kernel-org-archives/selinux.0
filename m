Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6JDwwIm018934
	for <selinux@tycho.nsa.gov>; Mon, 19 Jul 2010 09:58:58 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6JE0wXW025708
	for <selinux@tycho.nsa.gov>; Mon, 19 Jul 2010 14:00:59 GMT
Message-ID: <4C445A13.6030500@redhat.com>
Date: Mon, 19 Jul 2010 09:58:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Kyle Moffett <kyle@moffetthome.net>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: transactions in semanage
References: <201007182205.10960.russell@coker.com.au> <AANLkTimgmHVcXK_6MRnr-uGi4R5XSymdANqThNeZvgJd@mail.gmail.com>
In-Reply-To: <AANLkTimgmHVcXK_6MRnr-uGi4R5XSymdANqThNeZvgJd@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/18/2010 01:54 PM, Kyle Moffett wrote:
> Hi Russell!
> 
> On Sun, Jul 18, 2010 at 08:05, Russell Coker <russell@coker.com.au> wrote:
>> Has anyone considered a batch/transaction interface for semanage?
>>
>> The idea would be that you could redirect input from a script containing a
>> list of commands, and either all of them would succeed and be committed to
>> disk or none of the changes would apply and an error message would inform the
>> user of the cause of the problem.
>>
>> The first benefit of this would be an improvement in run-time.  Currently
>> semanage can be quite time consuming on a low-end system and if you have a
>> large number of commands to run (EG a for loop that has each iteration adding
>> a number of fcontext rules or user identities) then it could be a real drag.
> 
> This sounds like a good direction to move in, but if you're interested
> in run-time there's much lower hanging fruit.  Matt Robertson (a
> coworker of mine) just posted a relatively short patch that cuts 80%
> off the runtime of the "semodule" by allowing dynamically-sized hash
> tables.  Specifically, in his original profile results a simple
> "semodule -i" was spending a whopping 50% of its time in strcmp().
> 
> It looks like a substantial additional reduction can be obtained by
> adding support for lzma or gzip compression (or maybe even disable it
> entirely) instead of the CPU-intensive bzip2.  On top of that, there
> seem to be at least a few O(X^2) algorithms that may be rewritten for
> efficiency.
> 
> So while I personally think that a transactional interface would be
> good (perhaps similar to "iptables-load" and "iptables-restore"?),
> there's much more important things to fix with regards to runtime.
> Asking that the admin wait 2 minutes to add a new SELinux user is just
> a bit much :-D.
> 
> Cheers,
> Kyle Moffett
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

Not well documented bug
semanage -S targeted -i - << _EOF
login -a -s xguest_u xguest
boolean -m --on allow_polyinstantiation
boolean -m --on xguest_connect_network
boolean -m --on xguest_mount_media
boolean -m --on xguest_use_bluetooth
_EOF


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxEWhMACgkQrlYvE4MpobPKcQCfR6vyXy7wYLrLCuaqSp0xXw3n
7qAAoIETCfI2HKDLvEKMK9Gn/EDJvpMX
=72ry
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
