Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r46GqLsM031900
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2013 12:52:21 -0400
Message-ID: <5187DFB7.9050700@redhat.com>
Date: Mon, 06 May 2013 12:52:07 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: selinux@tycho.nsa.gov
Subject: Re: What provides _policy?
References: <20130501135544.GA21525@siphos.be> <20130503173926.GA22935@siphos.be>
In-Reply-To: <20130503173926.GA22935@siphos.be>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/03/2013 01:39 PM, Sven Vermeulen wrote:
> On Wed, May 01, 2013 at 03:55:44PM +0200, Sven Vermeulen wrote:
>> Recent policycoreutils' sepolicy imports "_policy", but I am having
>> troubles finding where _policy is provided?
> 
> Okay so I know that _policy comes from policy.c which is build through 
> "setup.py build" and is provided through a _policy.so file (I was looking 
> for _policy.py which isn't created).
> 
> However, I'm having a hard time debugging why I get the following:
> 
> File "/usr/bin/sepolicy-2.7", line 63, in __call__ from sepolicy.network
> import domains File
> "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 44, in
> <module> portrecs, portrecsbynum = _gen_port_dict() File
> "/usr/lib64/python2.7/site-packages/sepolicy/network.py", line 31, in
> _gen_port_dict for i in info(sepolicy.PORT): File
> "/usr/lib64/python2.7/site-packages/sepolicy/__init__.py", line 182, in
> info dict_list = _policy.info(setype, name) RuntimeError: No such file or
> directory
> 
> What could this error be about? I get this when I try "sepolicy communicate
> -s portage_t".
> 
> Wkr, Sven Vermeulen
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
Where are you executing this?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGH37cACgkQrlYvE4MpobPTOgCghoYfGmhPd9px6ptcOmy+ZdXt
OHwAn3dJ1KkPHldmbtgbA1LlPjppvCW2
=/abh
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
