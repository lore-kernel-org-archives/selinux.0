Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2RN3b9u006210
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 19:03:37 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2RN3Qwi017758
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 23:03:27 GMT
Message-ID: <47EBFA12.40406@redhat.com>
Date: Thu, 27 Mar 2008 20:48:34 +0100
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] user_transition support for libsepol/checkpolicy
References: <47E7E7A5.6090603@manicmethod.com> <1206446939.3302.139.camel@moss-spartans.epoch.ncsc.mil> <47EA0D4F.4040102@redhat.com> <200803271543.16340.russell@coker.com.au>
In-Reply-To: <200803271543.16340.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Russell Coker wrote:
> On Wednesday 26 March 2008 19:46, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> I am not sure where this is going, but I believe that separation based
>> on role in the home directory is a mistake.  It assumes that the home
>> directory will always be used by the same user with the same role.   And
>> will not work when you have a network file system that supports labels.
>>
>> In Red Hat I can login to people.redhat.com people.fedoraproject.com
>> which I should use the guest_r.  While logging into my laptop I would be
>> unconfined_t and on test machines I might get staff_r or user_r.  All of
>> them would use the same homedirectory.  So how would this work in this
>> environment?
> 
> If you have the same home directory contents (including .login, .bashrc, and 
> equivalent files) and you can execute programs from the home directory, then 
> how can you usefully have roles which are really different on different 
> machines?
> 
If I login to people.redhat.com I will log in as guest_t this type is
not allowed to use the network, execute files in the home directory or
run any setuid apps.  If I as the guest_t user want to muck around with
the .login file so that when I login to a different machine as
unconfined_t, I don't see a problem.  This is about defining roles and
policy based on the machine you login to.
> You could for example have guest_r on machine A mapping to sysadm_r on machine 
> B (which I believe bears some similarity to the reclassification of documents 
> when going between certain military organisations).
> 
This is not an MLS issue, and this does happen on MLS environments where
they say the same user on one machine can get to Secret while on another
machine he can get to TopSecret,  I would surmise that bother users
would have the same home dir, of course on the machine that is Secret he
would not be able to access the top secret files.
> The idea of a network filesystem having the same labels on all machines where 
> it is mounted even when there are differences in policy and/or user rights on 
> those machines makes no sense to me.
> 

Well I would assume that the policy is the same on each machine except
the default context that the user logs in as.  And I have given you a
descrete example of how things work at Red Hat.  This is also how our
customers expect this to work.  CA/EATrust has made major money on this
concept...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfr+hIACgkQrlYvE4MpobNidgCgnljhMx4GjdKbAdRzpUZUPGmN
qqoAn27gqpThN26Si285ne2uLxEr22on
=/dFC
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
