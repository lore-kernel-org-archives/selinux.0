Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r1MChDXR028718
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2013 07:43:13 -0500
Message-ID: <512767DA.2080805@redhat.com>
Date: Fri, 22 Feb 2013 13:43:06 +0100
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Koontz, Joshua" <joshua.koontz@lmco.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: EXTERNAL: Re: Developinng SELinux MLS aware software
References: <D9B8C03B93AAF148B0A532BBBBB47D8321905C95@HVXDSP43.us.lmco.com>,<51269A66.6030203@redhat.com> <D9B8C03B93AAF148B0A532BBBBB47D8321905D2D@HVXDSP43.us.lmco.com>
In-Reply-To: <D9B8C03B93AAF148B0A532BBBBB47D8321905D2D@HVXDSP43.us.lmco.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/21/2013 11:30 PM, Koontz, Joshua wrote:
> He's trying to code using some of the functions listed here:
> 
> http://selinuxproject.org/page/LibselinuxAPISummary
> 
> Good to know that it's been stable for awhile.  Didn't know if there was a
> user's mailing list or not.  I wouldn't be surprised if there wasn't.
> 
> Thanks Josh

Questions about MLS should probably go to this list.
<selinux@tycho.nsa.gov>


> ________________________________________ From: Daniel J Walsh
> [dwalsh@redhat.com] Sent: Thursday, February 21, 2013 5:06 PM To: Koontz,
> Joshua Subject: EXTERNAL: Re: Developinng SELinux MLS aware software
> 
> On 02/21/2013 03:11 PM, Koontz, Joshua wrote:
>> Hi Dan,
> 
>> I was wondering if you knew of any mailing lists that focused on using
>> the SELinux API to develop code.  I linger on the Fedoraproject, NSA,
>> and Tresys refpolicy lists, but they don't seem to deal with function
>> calls and hooks into SELinux.
> 
>> I'm not the one actually developing the code (thankfully), but assisting
>> on the policy development side of the operation.  Any information you
>> could provide would be much appreciated.
> 
>> Thanks Josh
> 
> Not sure what you mean by API to develop code.  While SELinux does have an 
> API, it really is not evolving all that fast.  Most of the effort is on 
> writing policy and improving the tool chain.  The MLS API has been pretty 
> stable for a few years now.
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlEnZ9oACgkQrlYvE4MpobMeyQCeN/2IqmbSkXZhUZoT5w5COmQ3
BIMAnj/f9DUY02q7XX97Vb/2sjB/XcA6
=7bwv
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
