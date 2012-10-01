Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q919NLL2024992
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 05:23:22 -0400
Message-ID: <506960E5.5040609@redhat.com>
Date: Mon, 01 Oct 2012 05:22:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Sutton, Harry (GSE)" <harry.sutton@hp.com>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: semanage: should -a imply -m?
References: <1348859914.2845.4.camel@localhost> <5066EBED.3060609@hp.com>
In-Reply-To: <5066EBED.3060609@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/29/2012 08:39 AM, Sutton, Harry (GSE) wrote:
> On 09/28/2012 03:18 PM, Eric Paris wrote:
>> What do others think about this?  Should we cause -a to act like -m or 
>> should it abort?  Should we force the -a ->  -m logic up to the caller? I
>> guess I'm fine with either.  Is semanage -a enough like semodule -i and
>> -m like -u that this would actually be expected behavior?
>> 
> I'm inclined to think it should be the other way around, that is, -m should
> act like -a.
> 
> If you create a new rule using semanage -a that differs in multiple but 
> potentially subtle ways from an existing entry you are unaware of, the
> result may not be at all what you wanted; in that case, the user should be
> warned that the record already exists. Maybe a compromise, to improve
> usability, would be to test for single vs multiple changes before throwing
> an error.
> 
> /Harry
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
The reason this was added to Fedora was the case of someone adding a port
definition on file context definition in a post install.  They did not want to
have to figure out if the definition was there or not.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBpYOUACgkQrlYvE4MpobNi9QCgpuleyly9bWJx4PmhWpd5OmJr
tXQAnRd8BdGz5ttYP3jKVQ3TeLwp0K5Q
=DXZM
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
