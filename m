Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qACD4dtG017770
	for <selinux@tycho.nsa.gov>; Mon, 12 Nov 2012 08:04:43 -0500
Message-ID: <50A0F3AF.1000007@redhat.com>
Date: Mon, 12 Nov 2012 08:03:43 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org,
        debian-dpkg@lists.debian.org
Subject: Re: Possible issues with dpkg SELinux support
References: <20121108082623.GA5059@gaara.hadrons.org> <CAB9W1A3cVVSj-PbM73c+vePHt7fVGf8117OXmTrDPf0K0vyYGg@mail.gmail.com> <20121110031932.GA6217@gaara.hadrons.org> <20121111091826.GA1808@gaara.hadrons.org>
In-Reply-To: <20121111091826.GA1808@gaara.hadrons.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/11/2012 04:18 AM, Guillem Jover wrote:
> On Sat, 2012-11-10 at 04:19:32 +0100, Guillem Jover wrote:
>> Is the "<<none>>" check needed at all? This has bothered me for a while,
>> and it's not clear if calling lsetfilecon_raw() with that would DTRT, or
>> if selabel_lookup_raw() would never return that to start with.
> 
> Oh, rechecking now selabel_file(5) it seems like selabel_lookup_raw() might
> never return "<<none>>", so I've preventively removed locally that check
> now.
> 
> thanks, guillem
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
I don't agree that matchpatchcon is obsoleted, I see it as more of a helper
function.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCg868ACgkQrlYvE4MpobMw/wCdEFI4dQvsWXk/Lc0sNuPbM4Sd
xyYAnAzG9LYOGg9811tEjpUITij1SF8D
=s8TS
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
