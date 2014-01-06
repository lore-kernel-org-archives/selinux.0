Message-ID: <52CB1928.5020002@redhat.com>
Date: Mon, 06 Jan 2014 15:59:20 -0500
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
 <52CAECB7.6050500@tycho.nsa.gov> <52CAEF39.6020404@redhat.com>
 <52CAF1DC.9080300@tycho.nsa.gov>
In-Reply-To: <52CAF1DC.9080300@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/06/2014 01:11 PM, Stephen Smalley wrote:
> On 01/06/2014 01:00 PM, Daniel J Walsh wrote:
>> How is returning a ERRNO/ERROR for bad values hiding bugs from callers?
>> We are actually telling the callers what is bad.
> 
> Not really.  Stack trace is more informative than EINVAL, as the one will
> show you exactly where you failed and what the arguments were, whereas
> EINVAL could be a result of any of the arguments or a side effect elsewhere
> in the function.  And the original functions that prompted this discussion
> have never allowed you to pass NULL as contexts.  Would you add a NULL
> check inside of every string.h function in libc?
> 
> 
> 
> _______________________________________________ Selinux mailing list 
> Selinux@tycho.nsa.gov To unsubscribe, send email to
> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
> to Selinux-request@tycho.nsa.gov.
> 
> 
- From a programmer point of view yes, but from an enterprise point of view no.
 I would prefer the apps to have a chance to reasonably fail.  Our functions
define return codes, while functions like strlen, strcmp and strcp do not have
failure modes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLLGSgACgkQrlYvE4MpobOb/ACg5bJKo8bGUHXpWVZyA6NpUo/v
jBIAn0OUcGiVnVLiSibgssvOLOqjem6o
=uKuI
-----END PGP SIGNATURE-----
