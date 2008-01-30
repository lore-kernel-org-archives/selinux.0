Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0UEgXVe013451
	for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2008 09:42:33 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0UEgUIi003109
	for <selinux@tycho.nsa.gov>; Wed, 30 Jan 2008 14:42:30 GMT
Message-ID: <47A089EC.6020607@redhat.com>
Date: Wed, 30 Jan 2008 09:30:04 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Todd Miller <Tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: genhomedircon is broken in libsemanage
References: <479F4051.7030101@redhat.com> <6FE441CD9F0C0C479F2D88F959B01588016EF6CA@exchange.columbia.tresys.com> <479FA131.3050700@manicmethod.com>
In-Reply-To: <479FA131.3050700@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Todd Miller wrote:
>> Daniel J Walsh wrote:
>>  
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Adding
>>>
>>> mythtv:x:1004:1004::/var/lib/mythtv:/bin/bash
>>>
>>> To /etc/passwd causes the labeling to get all screwed up.  This would
>>> report an error when we used the python version of genhomedircon and
>>> not foul up the labeling by checking if there was a label for /var/lib
>>> already in the file_context file. (Boy do I love python.  :^))
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=430195
>>>
>>> Dan
>>>     
>>
>> That shouldn't be hard to add to genhomedircon.c.  I'll take a look.
>>   
> 
> So, Todd is about to send a patch to fix this but I want to point out
> that I'm adverse to this sort of thing. There is a minuid and a null
> shell for a reason, using something above minuid with a valid shell for
> a non-interactive user is a broken configuration and the fact that we
> have to work around it is pretty unfortunate.
> 
> That said the alternative of breaking the system labeling is pretty bad,
> its probably better to hack around the problem than leave clueless users
> with broken configurations stranded but I really wish we didn't have to
> do things like this.
> 
> *sigh*
> 
I think you need to scream in the semanage that this is bad behavior,
and you can't fix the labels.  The /var/lib situation is bad, but I more
commonly see admins putting real users in /usr/local or under /var.  We
need to have a message that explains this is bad and SELinux can not
handle it.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkegiewACgkQrlYvE4MpobNWTwCfX2pMShRqXwpKfjRNwQ2pLRFr
EF8AoMOUQhevXLkLEmKH3qX48RZRv0L4
=Mi3W
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
