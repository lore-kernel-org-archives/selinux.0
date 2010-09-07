Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o87IPcVX009133
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2010 14:25:38 -0400
Received: from exprod8og114.obsmtp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o87IPa8m004577
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2010 18:25:37 GMT
Received: by vws4 with SMTP id 4so6296349vws.35
        for <selinux@tycho.nsa.gov>; Tue, 07 Sep 2010 11:25:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C86508B.2030800@redhat.com>
References: <AANLkTinseSQrjX7QoLo8wxh_HX6o_nKDUOeiN4-FvZBy@mail.gmail.com> <4C86508B.2030800@redhat.com>
From: Jason Axelson <jaxelson@referentia.com>
Date: Tue, 7 Sep 2010 08:25:13 -1000
Message-ID: <AANLkTinLy2-b+OWmQfdUDhF_j4soq3uREjDyEUUKnUfQ@mail.gmail.com>
Subject: Re: What is the risk of allowing audit_write?
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Daniel,

Thanks for the information. I'll add a dontaudit rule.

Thanks,
Jason

On Tue, Sep 7, 2010 at 4:47 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 09/03/2010 05:31 PM, Jason Axelson wrote:
>> Hi,
>>
>> I have a bash script that I've written that runs in its own domain,
>> let's call it my_domain_t. When I run this script, I get a denial
>> stating that the script was denied audit_write. But all the script is
>> doing when it gets this denial is printing to the screen and asking
>> for user input.
>>
>> From the SELinux wiki I know that audit_write allows the program to
>> "send audit messsages from user space". But does that mean it is able
>> to write to /var/log/audit/audit.log? Or more likely send a message to
>> the audit daemon which then appends to the audit log?
>>
>> So given that I currently don't feel any need to audit the results of
>> my script should I use an allow rule or something like dontaudit?
>>
>> allow my_domain_t self:capability audit_write
>> or
>> dontaudit my_domain_t self:capability audit_write
>>
>> I'm running this script on CLIP.
>>
>> Thanks,
>> Jason
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>> the words "unsubscribe selinux" without quotes as the message.
> Just add dontaudit rule.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.16 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkyGUIsACgkQrlYvE4MpobPZxgCfU6HQw4TXYmMrrCoCcvUVNREr
> eMgAn3s4ks6EqSW3BDxwQ4J2A43mUmkm
> =Wpod
> -----END PGP SIGNATURE-----
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
