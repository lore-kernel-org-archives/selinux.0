Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB5CHmlA029249
 for <selinux@tycho.nsa.gov>; Sat, 5 Dec 2015 07:17:48 -0500
Received: by wmww144 with SMTP id w144so96335714wmw.0
 for <selinux@tycho.nsa.gov>; Sat, 05 Dec 2015 04:17:43 -0800 (PST)
Received: from x250 ([84.245.63.179])
 by smtp.gmail.com with ESMTPSA id r74sm7682799wmb.2.2015.12.05.04.17.42
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Sat, 05 Dec 2015 04:17:42 -0800 (PST)
Date: Sat, 5 Dec 2015 13:17:41 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: How i see SELinux succeed in GNU/Linux
Message-ID: <20151205121740.GA21061@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

How i see SELinux succeed on GNU/Linux

I am going to respect my customers, and i am going to shove as little
SELinux policy down their throat as possible.
They will not feel as if theyre treated like children and they will
actually already have some very little benefit (mmap zero will be
blocked and a few other stuff that 9 out of 10 is not used and that
actually makes sense to block) without almost ever noticing

By default i am just going to install and enable a tiny policy that
implements basic "top level" partitioning and a single process type that is almost
unrestricted.
The rules that make it unrestricted are in a separate module that can
easily be excluded. As soon as someone decides to make use of my
implementation that module gets excluded and the base will be almost fully
locked down.
Except for an extra process type to associate with the unlabeled
isid. one user (system user), two roles (system role and object role)
two process types (system type and invalid type), a bunch of object
types to provide a solid top level partitioning

I installed this tiny base policy with the purpose of making selinux
accessible (i am bringing it closer to my audience, making as little
decisions for them as possible). I know selinux is
compelling and that security
is a necessity and that depending on your requirements it can be complex
matter or very simple.

To give indication the base is about 50K

My solution embraces selinux for what it is. I am not going to implement
any abstraction only to make selinux look like something else (in the
long run that will only add to the complexity of the matter).
The only abstraction that is there to make selinux more wieldable. My
solution will build on CIL.

CIL is fine (i am dropping the I from CIL), but i am going have to find a way to deal with the
parenthesis. Maybe provide a emacs mode or some other solution.

By default my SELinux implementation does not provide much protection
(that is my intent!) but it does provide a solid base to build on with
relative ease. It makes SELinux accessible, all one needs to do is
further configure it, and that will be relatively easy to do. The idea is that i don't have to
shove selinux policy down peoples throat and that selinux will sell it
self if i treat my customers with respect.

If people decide to use my base to tackle security challenges, then i
know that it was their decision (it was opt-in) and i can know that they will
be more open to it. Next I am going to help them in a efficient and
effective manner that shows respect by providing a nice no-nonsense
infrastructure
based on CIL (there will not be any semanage type stuff (not python-wise
anyway) Every
configuration detail will be in plain text files using the CIL language

Technically enforcement is opt-out but practically it is opt-in

There might be some example shell wrapper scripts to automate common
things but they are optional (because we embrace GNU, and were not going
to depend on Python in any way)

I understand that abstraction in the long run, only adds extra
stuff to learn (noise). So i keep the abstraction to a strict minimum.
I know that the people that choose to use my SELinux implementation did
so to address challenges so they will want to know what theyre doing,
and they want
to see what dinner is served before they eat it. (This is GNU/linux
after all)

I am going to embrace GNU/Linux for its versatility and flexibility so i
know SELinux policy is going to be incompatible except to its
environment if the policy was tailored to its environment. I cannot
predict all possible use cases ever. Since i use CIL in a no -nonsense
way, and since i dont force anything on anyone I dont have
to achieve an impossible absolute compatibility. People can and should
either modify or insert their own policy. I recognise that compatibility
is not necessarily a good thing since in this case it may be synonymous
to inefficient/ineffective

I will provide add-on policy modules that are optional so that if people are
willing to compromise they can choose to use my modules. These modules
are obviously not as efficient and effective as they could be because
they are based on use case assumptions, but since i do
not shove them down anyones throat i can expect some leaniancy from my
users. They know the drawbacks of generic policy. These modules
can be mixed- and matched because CIL compiler actually provides a
usuable way to deal with dependencies, and these modules
are just text files that can be installed.

People have a choice: they can create "incompatible" policy that is
perfectly tailored to their needs providing optimal integrity,
or they can go with a collection of generic modules that are less
efficient and effective but "easier" to implement.

Whatever they do, they are better off, because they are going to be
doing profiling to some extend or another. They are going
to implement what they need. They wont be installing policy for stuff
they will never use. This makes things faster, smaller and
easier to maintain overall.

Optionally there is going to be an *opt-in* example/demo "mode" It will be
abundantly clear that this is just to get one familiar with the matter
and with some of its benefits. All it does it is a compilation of
generic modules profiled in rough scenarios like: server , desktop,
cloud etc)

This is obviously an relatively inefficient and ineffective trade off, and everyone
will know that, but it will atleast have some level of profiling based
on assumptions.

Ofcourse I am going to provide comprehensive
documentation. Documentation that is not policy specific. It just
applies, always.

I am following up by campaigning. I know that SELinux sells it self but
it could use a little extra push in the back. I will not have any
unrealistic expectations.

I am going to have to deal with negative reputation that previous policy
implementations may have given SELinux. I will do so by admitting the mistakes
made, explain the lessons learned, and then explaining how those lessons
were implemented in a way to will inspire the nay-sayers to give it a
second chance.

The aim is not to just get people to "enable" SELinux (it will be enabled). The aim is to get
people to actually "use" SELinux in a meaningful way, not because i like
selinux but because i appreciate that this is the only sustainable
way. We dont accept black boxes and meaningfull security cannot a "point and
click/or a checkbox" in GNU/Linux. It is just unrealistic in my opinion.

Do you not want to deal with the inevitable hassle of security? I do not like it
and i did everything in my power to persuade you otherwise without
shoving my policy down your troat, but i will
respect your decision because it is your assets and your
responsibility. (just don't expect any sympatity from me if your
compromised assets
were used to attack others and you have to answer for it)

This roughly entails my vision of the near-perfect
implementation. It is based on, i would like to believe, mutual respect
and realism. It embraces GNU/Linux and SELinux

My new mantra:

SELinux Now! Not Tomorrow!


P.S: Yes I am just a crazy amateur hobbyist but at least I am thinking about improvements.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWYtXfAAoJENAR6kfG5xmcqyQL/iyMpIBCeBOLJ2oqVODiJRM7
/PL8Lw3uUHOj94PEcQ9oUZv7R9Wbi/vGzc52CRV59ueCUexUUrCy/8oTP24Md10E
wCQTnjIyF5MBV9tAoJq3TLceqXZkyB7XZ1FrqhcD66I0s29BAdyDFGptFrrfBrYu
bhKURA374o/VvhuhsC8BLP74F5nePNFf+uO9T4qpa2d/Owr1K5ONTLxiT1ZAq+WO
lp0ch/DTI73JJfWNwGVlKlPQacW/Y4BCZzrl+popotJlZ0loWyqU+gvP7Cpb2ZAV
6oQRgCZo8pVZpkwFZoYiUj5R0zBWSaYVpADuKWVZTlAx/eCgxDbtCuLE2EI2XMdW
dkdsh7yedosbxldUYDN0CJdEewEwRAWYv1W1Di2KsPBHZn773dXb5cuDo8brHAzc
alZpeoQb88PzPM5Ylr8xekL9nnAaA9y149/d3Y02iMpEgRBeaqgn0cfC9VVuP6ql
B+oE/AyzbWeOE73cTA49TjqCnj447WIOM6l+qWEAOA==
=kEm3
-----END PGP SIGNATURE-----
