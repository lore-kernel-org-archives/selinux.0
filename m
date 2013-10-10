Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9AHLmuW023996
	for <selinux@tycho.nsa.gov>; Thu, 10 Oct 2013 13:21:48 -0400
Message-ID: <5256E226.8000701@redhat.com>
Date: Thu, 10 Oct 2013 13:21:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Langland, Blake" <blangland@integrity-apps.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: MLS over loopback interface
References: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com>
In-Reply-To: <DA8D339A60101247B36E202899B1C93AA91986@CHUNEX01.integrity-apps.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/10/2013 01:12 PM, Langland, Blake wrote:
> All,
> 
> 
> 
> I have two web servers running on an SELinux machine, one running at s2 and
> one at s3. Both webservers have two webapps each that are attempting to
> communicate over the loopback interface. The communication is strictly s2
> <-> s2 and s3 <-> s3. The problem I am having is setting the MLS level of
> the loopback interface. If I have it set below s3, the s3 webapps cannot
> send over the interface; If I have it set higher than s2, the s2 webapps
> cannot receive over the interface. Any suggestions?
> 
> 
> 
> Thanks,
> 
> Blake
> 
> 
> 
Can you use different IPs?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJW4iYACgkQrlYvE4MpobMc1QCaAijG8RkFSSZwQWA8wRRFCDQp
yA0AoI2G1wnsqXvFfpQWZHs9rN+HQmnC
=QCOC
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
