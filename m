Message-ID: <52CAEF39.6020404@redhat.com>
Date: Mon, 06 Jan 2014 13:00:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: Bug in libselinux/src/setrans_client.c
References: <CAJfZ7=myQGgMdJ3NWZHUPvSTpOA-mfJUFLGQLvVdCz7a3N5evQ@mail.gmail.com>
 <CAPJdAQBu3=ZyEqUqn_eq4HagfGZZP3-9u_Taimozkkt4EjGfZg@mail.gmail.com>
 <CAJfZ7=m0BoejRQsbTU+5+YLyid8tb1r9tTzeQSR7ZJS1ZmkFsQ@mail.gmail.com>
 <52B84CDF.7020508@redhat.com>
 <CAJfZ7=mZCdh7_Mh9kng-pOHx3RAJ6Qn2W5VvmoVVJy7tUMRtag@mail.gmail.com>
 <CAB9W1A0+me3z9_c7qBxWRBxecX1yKCjqjO7vtNtcb0kHG+-xLQ@mail.gmail.com>
 <52C235CA.2010607@mthode.org> <52C27333.3060801@networkcrypt.com>
 <52C31282.6080809@mthode.org> <52CAD237.3060701@redhat.com>
 <52CAECB7.6050500@tycho.nsa.gov>
In-Reply-To: <52CAECB7.6050500@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/06/2014 12:49 PM, Stephen Smalley wrote:
> On 01/06/2014 10:56 AM, Daniel J Walsh wrote:
>> How about this patch?
> 
> I'm not in favor.  We shouldn't hide bugs in the callers.
> 
> 
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
> 
> 
How is returning a ERRNO/ERROR for bad values hiding bugs from callers?  We
are actually telling the callers what is bad.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLK7zkACgkQrlYvE4MpobNRvACfShksLPm7FOSeZqvHipEcqLFT
TfwAoNblhfZOU+wtA0i5B/AkE62CNQkB
=rRfh
-----END PGP SIGNATURE-----
