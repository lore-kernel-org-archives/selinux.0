Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q77HaBjo029371
	for <selinux@tycho.nsa.gov>; Tue, 7 Aug 2012 13:36:11 -0400
Message-ID: <50215206.6060504@redhat.com>
Date: Tue, 07 Aug 2012 13:36:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: Ole Kliemann <ole@plastictree.net>, selinux@tycho.nsa.gov
Subject: Re: SELinux performance depending on type count
References: <20120807130244.GE2085@telvanni> <CAFftDdq9JhRXMTDP4ZSsDOhpUAb5vDAAKPmNJ3Zf_KaeBRzxYw@mail.gmail.com>
In-Reply-To: <CAFftDdq9JhRXMTDP4ZSsDOhpUAb5vDAAKPmNJ3Zf_KaeBRzxYw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/07/2012 01:07 PM, William Roberts wrote:
> Well as far as caching goes, their are cache misses, so as the amount of
> data increase and your cache size stays fixed, they may be an issue...
> 
> On Tue, Aug 7, 2012 at 6:02 AM, Ole Kliemann <ole@plastictree.net> wrote:
>> I read on some locations (Fedora FAQ...) that there is an overall 
>> performance impact of about 7% when running with SELinux.
>> 
>> Does anyone know if this impact is dependent upon the number of types the
>> policy has? I would assume no: A lot of types only take up memory and
>> caching should prevent any impact on the runtime performance.
>> 
>> But if there was a performance problem with a lot of types, at what
>> number n would it start to hit hard? And how does it increase (linear,
>> quadratic...)?
>> 
>> And would it be better performance-wise to run a MCS-policy with say
>> categories c0.cn than to have types c0_t, ... cn_t?
>> 
>> Ole
> 
> 
> 
Also 7% is ridiculously high.  I would do your own measuring of SELinux and I
think for most work loads it is lot closer to unmeasurable difference.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAhUgYACgkQrlYvE4MpobMzcACdEccYKiyfZVeTQYF/06aKwc7i
tU4An1JeSEo6qcfNsIBzeZBn01fLN8KM
=Z4gW
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
