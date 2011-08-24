Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7OL4bck025257
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 17:04:37 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7OL4aug010473
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 21:04:36 GMT
Message-ID: <4E55675F.2070302@redhat.com>
Date: Wed, 24 Aug 2011 17:04:31 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Harry Ciao <qingtao.cao@windriver.com>, cpebenito@tresys.com,
        slawrence@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com> <4E53AE8C.6020707@redhat.com> <4E553ACC.6020903@manicmethod.com> <4E555E0F.7000200@redhat.com> <4E556071.2030009@manicmethod.com>
In-Reply-To: <4E556071.2030009@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/24/2011 04:34 PM, Joshua Brindle wrote:
> Daniel J Walsh wrote:
>>>> 
>>>> 
>>>> If we can not duplicate this functionality then I NAK the
>>>> change from booleans to tunables.
>>> You could actually force a downgrade to a pre-tunable format
>>> and use that policy to do the setroubleshoot lookups. Since the
>>> policy is already linked/expanded and just needs to be written
>>> out twice it wouldn't add much time to policy building (granted
>>> that adding _any_ time to policy building is adding too
>>> much...)
>> I might not have explained it correctly, I really meant the
>> policy would have to toggle each tunable/boolean at a time and
>> see if the AVC was allowed.  Recompiling the policy for each
>> tunable/boolean change would be not be supportable for Time and
>> CPU reasons.
>> 
> 
> What I mean is, if you set the policy writer to not use tunables
> (by whatever method that is) it'll write them out as regular
> booleans and setroubleshoot could load that policy (which should be
> the same as the loaded one, except with extra rules and booleans),
> toggle the booleans like it does now and do access vector lookups
> to see if a boolean would enable one. Same method as now, there
> would just be 2 policies on disk. Call the one with everything the
> "debug" policy :)
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 
That is fine, and then the setsebool -P XYZ=1 rule would either set a
boolean or a tunable.

Meaning from the customers point of view he would not know the
difference.

The other problem would be to know we would like to be able to get a
list of all tunables.  Currently this happens through the kernel
interface, I guess we would need tools like
getsebool -a to read this policy file?


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5VZ18ACgkQrlYvE4MpobO2rQCcDOG5D66GYgxCUrn0W92PeeTD
DlEAmgLdjd33wNNZ9zF59MiCIyIgx+hF
=heQ9
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
