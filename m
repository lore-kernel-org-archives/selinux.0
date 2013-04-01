Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r31HcZEK028919
	for <selinux@tycho.nsa.gov>; Mon, 1 Apr 2013 13:38:35 -0400
Received: by mail-lb0-f172.google.com with SMTP id u10so2162069lbi.31
        for <selinux@tycho.nsa.gov>; Mon, 01 Apr 2013 10:38:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <10afc77cc74d7492ba83dcb1c1766747@countercultured.net>
References: <71EBD3EA436C4B47B4A5FEFEB7370793389F07D5@Mail.cirris.com>
	<5151D34F.7090204@tresys.com>
	<5151EF48.3090403@redhat.com>
	<10afc77cc74d7492ba83dcb1c1766747@countercultured.net>
Date: Mon, 1 Apr 2013 13:38:32 -0400
Message-ID: <CACLa4psjCJNTLJY_2v4y3Wuqz3LC6gQ=gmi11+BbjdqM7kRxKQ@mail.gmail.com>
Subject: Re: Filesystem module
From: Eric Paris <eparis@parisplace.org>
To: David Quigley <dpquigl@davequigley.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Rob Shelley <rob@cirris.com>, SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Last I remember, nothing which took a full range component could be
properly supported in a module.  So the answer is 'that's just how it
is in the toolchain'.  But no inherent reason without a little coding
it couldn't be different.

On Thu, Mar 28, 2013 at 10:13 AM, David Quigley <dpquigl@davequigley.com> wrote:
> On 03/26/2013 14:56, Daniel J Walsh wrote:
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 03/26/2013 12:56 PM, Christopher J. PeBenito wrote:
>>>
>>> On 03/25/13 17:14, Rob Shelley wrote:
>>>>
>>>> I am evaluating OCFS2 on a CentOS 6.3 cluster and have run into a little
>>>> bit of a snag with SELinux.  After the OCFS2 partition is mounted no
>>>> writes can be performed to the shared device from either node because
>>>> they are being blocked by SELinux.  The core of the issue is that the
>>>> CentOS default policy does not list OCFS2 as a filesystem that supports
>>>> xattrs in filesystem.te.  It's a one line fix:
>>>>
>>>> fs_use_xattr ocfs2 gen_context(system_u:object_r:fs_t,s0);
>>>>
>>>> However, it would seem that the only way to implement this change in
>>>> filesystem.te is by rebuilding the base policy.  (I have not found a way
>>>> to just reload the filesytem module of the base policy.)  And even if
>>>> there were an easy way to reload just the filesystem module of the base
>>>> policy I believe this would be overwritten if an update is released.
>>>>
>>>> So, I was wondering if there was a way to incorporate this line into a
>>>> module, say ocfs2.te.  My initial attempts have failed, but I am
>>>> assuming
>>>> that is because I do not have the correct dependencies listed in the
>>>> require section.
>>>>
>>>> Any suggestions?
>>>
>>>
>>> Unfortunately you can only add fs_use statements to the base module, so
>>> you'd have to rebuild the base module.
>>>
>> You should be able to mount the file system with a single label.
>>
>> mount -o context="system_u..."
>>
>> -----BEGIN PGP SIGNATURE-----
>> Version: GnuPG v1.4.13 (GNU/Linux)
>> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>>
>> iEYEARECAAYFAlFR70gACgkQrlYvE4MpobNnFACglqXTfagTP1SGv4B48u40GcAR
>> v6EAni59zLo5gElDUCDuVueMXSI/0Ek2
>> =zKaF
>> -----END PGP SIGNATURE-----
>>
>> --
>> This message was distributed to subscribers of the selinux mailing list.
>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
>> with
>> the words "unsubscribe selinux" without quotes as the message.
>
>
>
> Is there a reason that fs_use statements need to be in the base module other
> than its just how it is in the kernel and tool chain? Is that something that
> could be changed?
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
