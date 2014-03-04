Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s24EAmqg002463
 for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2014 09:10:49 -0500
Received: by mail-pb0-f46.google.com with SMTP id rq2so5221375pbb.19
 for <selinux@tycho.nsa.gov>; Tue, 04 Mar 2014 06:10:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5315D8D2.9050208@redhat.com>
References: <1393897055.79488.YahooMailNeo@web124904.mail.ne1.yahoo.com>
 <5315D8D2.9050208@redhat.com>
Date: Tue, 4 Mar 2014 09:10:47 -0500
Message-ID: <CAN4BvJ_zb_72G4XkTGdb_K-w1G9UqPbT7TcyQYajfHQEqPBsNQ@mail.gmail.com>
Subject: Re: sshd and setcurrent
From: Brandon Whalen <brandon@quarksecurity.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: SELinux ML <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 4, 2014 at 8:44 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 03/03/2014 08:37 PM, Andy Ruch wrote:
>> Hello,
>>
>>
>> I'm implementing a custom SELinux policy based on the reference policy for
>> a secure RHEL 6.5 system. Currently, my policy does not allow 'setcurrent'
>> for sshd_t and I'm seeing the appropriate AVCs associated to this. However,
>> even with these AVCs, everything appears to work. I still end up with a
>> bash process running as staff_t. The only difference I see using 'ps -efZ'
>> is the context of parent process of the bash shell:
>>
>> PERMISSIVE:
>>
>> system_u:system_r:sshd_t:s0-s0:c0.c1023    root    29470    1520     ...
>> sshd: myuser [priv] myuser_u:staff_r:staff_t:s0-s0:c0.c1023    myuser
>> 29475    29470    ...    sshd: myuser@pts/0
>> myuser_u:staff_r:staff_t:s0-s0:c0.c1023    myuser  29476    29475    ...
>> -bash
>>
>>
>>
>> ENFORCING (context on 2nd line different):
>>
>> system_u:system_r:sshd_t:s0-s0:c0.c1023    root    29505    1520     ...
>> sshd: myuser [priv] system_u:system_r:sshd_t:s0-s0:c0.c1023    myuser
>> 29510    29505    ...    sshd: myuser@pts/0
>> myuser_u:staff_r:staff_t:s0-s0:c0.c1023    myuser  29511    29510    ...
>> -bash
>>
>>
>> Does this second process labeled as "sshd_t" provide any usability or
>> security issues?
>>
>>
>> Digging into the policy code more, I see comments in domain.te along the
>> lines of "setcurrent breaks process tranquility" and "don't use it if you
>> don't understand it". Could someone provide some more details regarding
>> when to use 'setcurrent' for a secure system?
>>
>>
>> Also, I understand that the RHEL Targeted policy has a completely different
>> use case than my custom policy. However, why is it allowed in the Targeted
>> policy if the sshd appears to work without it?
>>
>>
>> Thanks, Andy Ruch
>>
>> _______________________________________________ Selinux mailing list
>> Selinux@tycho.nsa.gov To unsubscribe, send email to
>> Selinux-leave@tycho.nsa.gov. To get help, send an email containing "help"
>> to Selinux-request@tycho.nsa.gov.
>>
> The way sshd works is to setup a process running as the user without doing a
> fork/exec.  This is why we did a setcurrent in sshd.  The problem we were
> trying to solve, is if you have a user type that you do not want to prevent
> running as a service, like guest_t, you can get around it by using sshd tunnels.
>
> By setting this process to guest_t rather then sshd_t, the policy works as you
> would expect.  Also since this process is running as the User UID it might be
> able to be influenced by other processes with the same UID.  Running as sshd_t
> could be a risk.
>
> The problem with setcurrent is that it is not as clean as a setexeccon.  It is
> always better to do a fork/exec from an SELinux point of view.  But if the app
> does not implement this, we think setcurrent is a decent fall back.
>

If you are concerned with giving setcurrent to sshd_t IIRC you can add
'UsePrivilegeSeparation=no' to the sshd_config file and it won't try
to bracket down it's privileges after authentication.


>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iEYEARECAAYFAlMV2NEACgkQrlYvE4MpobOO2QCcDUTn3SaW4/jCH8/JGO7EHFdS
> T2wAoOrgSD+YJmpat76aUkrmpg3iq7Ba
> =obee
> -----END PGP SIGNATURE-----
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
