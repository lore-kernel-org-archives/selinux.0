Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r3HHxXA9006247
	for <selinux@tycho.nsa.gov>; Wed, 17 Apr 2013 13:59:37 -0400
Message-ID: <516EE305.3090103@redhat.com>
Date: Wed, 17 Apr 2013 13:59:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: Rodney Simioni <rodney.simioni@verio.net>, selinux@tycho.nsa.gov
Subject: Re: Not sending AVC denials to audit.log
References: <0971982CF6B9AB418FFD5FEF7F50CB9F05E09E0C@IAD-WPRD-XCHB03.corp.verio.net> <1366217693.2803.53.camel@x220.localdomain>
In-Reply-To: <1366217693.2803.53.camel@x220.localdomain>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/17/2013 12:54 PM, Dominick Grift wrote:
> On Wed, 2013-04-17 at 10:16 -0400, Rodney Simioni wrote:
>> Hi,
>> 
>> 
>> 
>> I have a few development tests that are failing when I put the server in
>> ‘enforcing` mode; however, it’s not sending AVC denials to the 
>> audit.log.
> 
> Is auditd running?
> 
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
If auditd is not running avc messages go to /var/log/messages

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFu4wQACgkQrlYvE4MpobP8egCgiWm+Abv9mmbHlqM/V2DEIFQF
SCUAnRKAevSILVzWjLBjv6N/p8ynH/F8
=l1H4
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
