Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0MGsbbI027607
	for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 11:54:37 -0500
Received: by mail-la0-f71.google.com with SMTP id fr10so1560495lab.10
        for <selinux@tycho.nsa.gov>; Tue, 22 Jan 2013 08:54:21 -0800 (PST)
From: Hung Truong <hung.truong@tridsys.com>
References: <3086262d0228a121663cb87f5d77a07a@mail.gmail.com>
 <756D04455A661C4CA25DC5BA4902A7A70130D8@XCH-PHX-204.sw.nos.boeing.com>
 <d2ec19d66b29b9d3206b49e021bd9aff@mail.gmail.com> <50FEAC01.3080605@redhat.com>
 <91c6e6b735a86f02709d38f526230fb3@mail.gmail.com> <50FEAEE1.9000002@redhat.com>
In-Reply-To: <50FEAEE1.9000002@redhat.com>
MIME-Version: 1.0
Date: Tue, 22 Jan 2013 11:54:18 -0500
Message-ID: <5d39ee58920a6a7a54682d2c584f05cf@mail.gmail.com>
Subject: RE: Turn off "dontaudit" rules in monolithic policy
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: refpolicy@oss1.tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This works!!! BTW, there was a typo.  The command should be:

make enableaudit

I really appreciate your help.

Hung Truong | Trident Systems Incorporated
Sr. Embedded Engineer, Software System Engineering Group
10201 Fairfax Boulevard | Suite 300 | Fairfax, VA 22030
d: 703.267.6746 | f: 703.273.6608
e: hung.truong@tridsys.com | www.tridsys.com



Notice: The information contained in this email message is considered
confidential and proprietary to the sender and is intended solely for review
and use by the named recipient.  Any unauthorized review, use or
distribution is strictly prohibited. If you have received this message in
error, please advise the sender by reply email and delete the message.


-----Original Message-----
From: Daniel J Walsh [mailto:dwalsh@redhat.com]
Sent: Tuesday, January 22, 2013 10:23 AM
To: Hung Truong
Subject: Re: Turn off "dontaudit" rules in monolithic policy

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/22/2013 10:14 AM, Hung Truong wrote:
> Could you tell me how to compile a policy without dontaudit rules?
> Thanks.
>
make enabelaudit

I believe.
>
> Hung Truong | Trident Systems Incorporated Sr. Embedded Engineer,
> Software System Engineering Group 10201 Fairfax Boulevard | Suite 300
> | Fairfax, VA
> 22030 d: 703.267.6746 | f: 703.273.6608 e: hung.truong@tridsys.com |
> www.tridsys.com
>
>
>
> Notice: The information contained in this email message is considered
> confidential and proprietary to the sender and is intended solely for
> review and use by the named recipient.  Any unauthorized review, use
> or distribution is strictly prohibited. If you have received this
> message in error, please advise the sender by reply email and delete the
> message.
>
>
> -----Original Message----- From: Daniel J Walsh
> [mailto:dwalsh@redhat.com]
> Sent: Tuesday, January 22, 2013 10:11 AM To: Hung Truong Cc: Vu,
> Joseph; SELinux Subject: Re: Turn off "dontaudit" rules in monolithic
> policy
>
>
>
> On 01/22/2013 09:31 AM, Hung Truong wrote:
>> I am using version 3.7.19-155el6.6.
>
>
>
>> *From:*Vu, Joseph [mailto:joseph.vu@boeing.com
>> <mailto:joseph.vu@boeing.com>] *Sent:* Tuesday, January 22, 2013 9:19
>> AM
>> *To:* Hung Truong; SELinux *Subject:* RE: Turn off "dontaudit" rules
>> in monolithic policy
>
>
>
>> Hung,
>
>
>
>> I have been trying to rebuild monolithic policy and was not able to.
>
>> What version of SELinux Policy and RHT are you using?
>
>
>
>> ---------------------------------------------------------------------
>> -
>> ----------
>
>> *From:*owner-selinux@tycho.nsa.gov
>> <mailto:owner-selinux@tycho.nsa.gov>
>> [mailto:owner-selinux@tycho.nsa.gov] *On Behalf Of *Hung Truong
>> *Sent:* Monday, January 21, 2013 11:25 AM *To:* SELinux *Subject:*
>> Turn off "dontaudit" rules in monolithic policy
>
>
>
>> I have a custom monolithic build based on RHEL6 policy. I get this
>> error when try to turn off dontaudit rules:
>
>> $ semodule -DB
>
>
>> libsemanage.semanage_link_sandbox: Could not access sandbox base file
>> /etc/selinux/targeted/modules/bmp/base.pp. (No such file or
>> directory)
>
>> Is there other way to turn off dontaudit rules in a monilithic policy?
>
>
>
>> Many thanks,
>
>> --Hung Truong
>
> Why not compile two policies one with and one without dontaudit rules?
>
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
> quotes as the message.
>
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD+ruEACgkQrlYvE4MpobPNkACggndNE6JYVYFJIWRJ4UAjHEIw
WnQAn1iAHwPv3UtoiTt3MOSYOgnLtGOv
=/+7i
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
