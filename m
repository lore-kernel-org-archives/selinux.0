Message-ID: <44333C9E.4050508@procyonlabs.com>
Date: Tue, 04 Apr 2006 23:42:22 -0400
From: "Randal T. Rioux" <randy@procyonlabs.com>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: Erich Schubert <erich@debian.org>, James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: End User Mailing List / Group / Policy Made Easy
References: <442B182D.9060104@redhat.com> <442B7848.8060406@hotmail.com>	 <4430AABF.5000301@procyonlabs.com>	 <1144067579.22768.3.camel@wintermute.xmldesign.de> <1144072348.9028.47.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1144072348.9028.47.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

Stephen Smalley wrote:
> On Mon, 2006-04-03 at 14:32 +0200, Erich Schubert wrote:
<snip>
>>In my personal opinion, SELinux isn't end-user ready yet (or not
>>anymore, it was when we were still using the old policy). Too many
>>pitfalls (module linking not yet working entirely right, so you need to
>>put everything in base you want) and way too little documentation.
<snip>
> On the end user mailing list question, I'm not sure it would have much
> life isolated from the distribution-focused lists and from the upstream
> developers list.  Most end users will deal with SELinux through their
> particular distributions, as integrating SELinux does take work and is
> difficult to maintain long term outside of the main packages of a
> distribution.   

In reference to user interfacing, I was considering developing an
ncurses based editor. I generally don't install X libraries on servers
(wish Solaris made that an easy process), so I wanted something terminal
friendly. I have noticed a couple really good projects (such as SELinux
Policy Editor), but they are based on X. I will kick that idea around
further, but please let me know if something already exists or if you
have any design suggestions.

> But I'm not sure if there is a such demand presently.

We must create it! :-)

Thanks,
Randy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEMzydRrGMQdCNGUERAyX1AJ4rt16P9Er3tSPrtTCjbuo0PhegVACfXtA2
+YPZ/FXupUCLR1FCOCBDtXE=
=wAAx
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
