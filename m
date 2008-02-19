Message-ID: <47BAEC42.60708@redhat.com>
Date: Tue, 19 Feb 2008 09:48:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Jeremiah Jahn <jeremiah@goodinassociates.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: secadm/sysadm discussion
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com>	 <200802150855.47722.paul.moore@hp.com>	 <1203088187.3669.241.camel@bluejay.goodinassociates.com>	 <1203088562.16038.196.camel@moss-spartans.epoch.ncsc.mil>	 <1203089944.13618.40.camel@gorn>	 <1203091760.3669.249.camel@bluejay.goodinassociates.com>	 <1203091792.13618.56.camel@gorn>	 <1203092070.3669.251.camel@bluejay.goodinassociates.com>	 <1203092610.13618.58.camel@gorn>	 <1203093415.3669.258.camel@bluejay.goodinassociates.com>	 <47B60285.9010801@redhat.com> <1203341839.13618.71.camel@gorn>
In-Reply-To: <1203341839.13618.71.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Fri, 2008-02-15 at 16:22 -0500, Daniel J Walsh wrote:
>> <rant>
>>
>>
>> Personally I think sysadm_t is a waste of time.  It is a poor mans
>> unconfined_t and should be eliminated from the face of the earth.  All
>> it does is generate Bugs and avc messages without supplying any real
>> security.  It makes no sense, as a confinement of a root user since it
>> is so easily gotten around.  If you have an administrator of a machine,
>> that you want to confine, start with only allowing him the privs that
>> are required to do his job.  You can't start by saying he can do
>> everything except ABC.
> 
> As long as policy is used in a strict configuration, sysadm will be
> needed.  I would prefer to tighten it up.
> 
This is what I question.  If you can not define what a strict
configuration is then sysadm_t is useless.  And tightening it up a
little does nothing.  If sysadm_t can build an install an RPM all bets
are off.  If he can format disk, add users, change passwords, run su,
modify sudo, change contents of the homedir of the "sysadm_t" homedir.
Then you can not stop him.

So why carry on the charade that this is useful.  I my mind you either
fully trust your admin or you don't.  If you don't you need to define
exactly what you want him to be allowed to do, and then write policy for
that.  If you can't write policy tight enough to stop him from doing
evil things, then you need to fall back to auditing his every move.
Writing a special mishmash of admin called sysadm is a waste of time.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke67EIACgkQrlYvE4MpobPtxACePPwf7FQeH+TME/pcZ1SvwRq8
6hYAnR3S1xw8DVjySDuJAMgw6q9bMl1M
=hqGN
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
