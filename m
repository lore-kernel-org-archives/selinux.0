Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rADIbfBd003067
	for <selinux@tycho.nsa.gov>; Wed, 13 Nov 2013 13:37:41 -0500
From: "Radzykewycz, T (Radzy)" <radzy@windriver.com>
To: Daniel J Walsh <dwalsh@redhat.com>,
        Dominick Grift
	<dominick.grift@gmail.com>,
        Bruno Wolff III <bruno@wolff.to>
CC: Tony Scully <tonyjscully@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: RE: SELinux Coloring book?
Date: Wed, 13 Nov 2013 18:37:29 +0000
Message-ID: <33006C99F5A5194A9B7A7715DFA3E383B53C2323@ALA-MBB.corp.ad.wrs.com>
References: <52839664.1080600@redhat.com>
	 <1bddae0010527398cc85d89bb8f1aad9.squirrel@host290.hostmonster.com>
	 <CAMk6u_TUztYjqUTFCd5ukcHWOYt=cJaJv2ARvw-RafcVAAVUQw@mail.gmail.com>
	 <20131113171326.GA13491@wolff.to>
 <1384364110.30406.53.camel@d30>,<5283C07D.1010802@redhat.com>
In-Reply-To: <5283C07D.1010802@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

General question:

Does the "coloring book" really need to cover all aspects of security, and cover them in depth?  If this is a kindergarten grade level introduction, then explaining all the nuances of priority may be too much to ask.  If it is for more experienced audiences, then why does it need to be a coloring book?

See Spot.  See Spot run.  See Spot manage the pack's dominance hierarchy through vociferous displays of aggressive behavior.  Run, Spot, run!


________________________________________
From: owner-selinux@tycho.nsa.gov [owner-selinux@tycho.nsa.gov] on behalf of Daniel J Walsh [dwalsh@redhat.com]
Sent: Wednesday, November 13, 2013 9:10 AM
To: Dominick Grift; Bruno Wolff III
Cc: Tony Scully; Community support for Fedora users; Fedora SELinux Users; SELinux
Subject: Re: SELinux Coloring book?

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/13/2013 12:35 PM, Dominick Grift wrote:
> On Wed, 2013-11-13 at 11:13 -0600, Bruno Wolff III wrote:
>> On Wed, Nov 13, 2013 at 17:10:43 +0000, Tony Scully
>> <tonyjscully@gmail.com> wrote:
>>> That's excellent!
>>
>> The mls case might have been overly simplified. It didn't cover writing,
>>  where the dominance goes in the other direction. People might be
>> incorrectly left with the impression the top secret can do everything
>> that secret can do. --
>
> I agree with you on the danger of oversimplification in generel with regard
> to explaining SELinux
>
> This is also why i find it sub-optimal to leave the two other default
> security models out of the equation (RBAC/IBAC)
>
> It is mentioned in the article that SELinux complements Linux security, by
> briefly touching on IBAC one would clarify at least to some degree how
> SELinux associates with Linux security
>
> RBAC by itself is worth mentioning in my view, if only to have touched on
> each security attribute in a security context tuple.
>
> The idea of the illustrated article is nice, but the article is not
> comprehensive.
>
> Granted, there are constraints. You cannot simply publish a three page
> article on a medium like this i suspect
>
>
>
Maybe a followup that describes RBAC.  Not sure how the analogy would work
though.

Suggestions welcome.

Dog Role, See Eye Dog Role, Rescue Dog Role.

RBAC is always hard to describe especially when you start defining SELinux Users.

Login User -> SELinux User -> roles -> Types.

The Russian dolls model is the best I have come up with.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKDwH0ACgkQrlYvE4MpobOmDACgnwBUbk7Vg1DwpkGTO8SenHLD
dFwAoOmzqZ+sfFVRkHH4r+hbxS8x1sgK
=ge9w
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
