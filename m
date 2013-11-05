Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA5FM7Mn003443
	for <selinux@tycho.nsa.gov>; Tue, 5 Nov 2013 10:22:07 -0500
Received: by mail-lb0-f174.google.com with SMTP id q8so6588702lbi.5
        for <selinux@tycho.nsa.gov>; Tue, 05 Nov 2013 07:21:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52790935.2040006@redhat.com>
References: <20131104220022.GA6511@siphos.be>
	<52790935.2040006@redhat.com>
Date: Tue, 5 Nov 2013 10:21:55 -0500
Message-ID: <CACLa4pvsqX94k+RTrGV6o3ezpyOrbXf1g-9Qe9-D+by0oPa5JQ@mail.gmail.com>
Subject: Re: No module named policycoreutils.default_encoding_utf8 ?
From: Eric Paris <eparis@parisplace.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Sven Vermeulen <sven.vermeulen@siphos.be>,
        SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

That's one of the patches that I always refused to push upstream.  The
code itself was scary, some C code that built into some sort of python
module that forced something...   Seemed dirty.  I was never able to
get anyone to tell me what the problem was or what that fixed.
Everyone just said 'internationalization is wrong.'  I suggest it not
be included/be reverted upstream...

On Tue, Nov 5, 2013 at 10:05 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 11/04/2013 05:00 PM, Sven Vermeulen wrote:
>> Hi all,
>>
>> In policycoreutils-2.2.1/semanage/semanage, the first import is:
>>
>> """ import policycoreutils.default_encoding_utf8 """
>>
> Yes this is for internationlization but we should just remove it.  As I port
> to python3 it will no longer be necessary.
>
> This patch switches python2 to always use unicode, which is the default for
> python3.
>
>> On my system (Python 2.7) this fails with:
>>
>> Traceback (most recent call last): File "/usr/sbin/semanage-python2.7",
>> line 26, in <module> import policycoreutils.default_encoding_utf8
>> ImportError: No module named policycoreutils.default_encoding_utf8
>>
>> Is this specific for a particular Python version?
>>
>> I commented it out and most other things work just fine (I only have a
>> small issue with audit2allow not wanting to generate refpolicy-style
>> modules even though the interface_info file is - I think - up2date and is
>> being read by audit2allow).
>>
>> Wkr, Sven Vermeulen
>>
>> -- This message was distributed to subscribers of the selinux mailing
>> list. If you no longer wish to subscribe, send mail to
>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
>> as the message.
>>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.15 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlJ5CTUACgkQrlYvE4MpobPP5ACfUEiGrG1iXAB9410oDNv6d4v4
> /zoAnRb8BcSM841DDCz5/epKGrxteq5C
> =H0mM
> -----END PGP SIGNATURE-----
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
