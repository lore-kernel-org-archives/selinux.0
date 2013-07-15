Message-ID: <51E4140B.80702@redhat.com>
Date: Mon, 15 Jul 2013 11:23:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: David Quigley <selinux@davequigley.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: matchportcon?
References: <51E23671.2060205@davequigley.com> <51E3F30A.8010603@tycho.nsa.gov> <3fa9165e8c1cfe4a72ba570e3420de6a@countercultured.net>
In-Reply-To: <3fa9165e8c1cfe4a72ba570e3420de6a@countercultured.net>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/15/2013 09:07 AM, David Quigley wrote:
> On 07/15/2013 09:03, Stephen Smalley wrote:
>> On 07/14/2013 01:26 AM, Dave Quigley wrote:
>>> Do we have an equivalent of matchpathcon for ports? Where we can
>>> specify a protocol and port and see what the policy thinks it labeled?
>> 
>> Closest approximation I can think of would be to use checkpolicy -Mdb
>> /path/to/policy and then choose 9, input the protocol and port number,
>> choose 1, and input the SID that was displayed.
>> 
>> It would be very nice to have a more user-friendly (and scriptable) 
>> interface to the checkpolicy -d (debug) functionality.
> 
> 
> So over on fedora-selinux dominic grift suggested I use sepolicy network
> to check it out. The only issue with its usage is that it doesn't tell you
> what it actually is. Instead it gives you all rules that will match and you
> have to realize the most specific one wins. It is however sufficient for my
> talk so I'll probably use it.
> 
> Dave
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
> 

sepolicy network -p 80
80: tcp http_port_t 80
80: udp reserved_port_t 1-511
80: tcp reserved_port_t 1-511

sepolicy is reading the info from the running kernel.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHkFAoACgkQrlYvE4MpobPyjACZATRsJA2eCVvP+Sxh2JLNFsMh
UDAAoJsKirzrltnsHyzcqOlD0Ff1ompX
=9wDr
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
