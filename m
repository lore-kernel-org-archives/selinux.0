Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2QIuG0D023220
	for <selinux@tycho.nsa.gov>; Tue, 26 Mar 2013 14:56:16 -0400
Message-ID: <5151EF48.3090403@redhat.com>
Date: Tue, 26 Mar 2013 14:56:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Rob Shelley <Rob@cirris.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Filesystem module
References: <71EBD3EA436C4B47B4A5FEFEB7370793389F07D5@Mail.cirris.com> <5151D34F.7090204@tresys.com>
In-Reply-To: <5151D34F.7090204@tresys.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/26/2013 12:56 PM, Christopher J. PeBenito wrote:
> On 03/25/13 17:14, Rob Shelley wrote:
>> I am evaluating OCFS2 on a CentOS 6.3 cluster and have run into a little
>> bit of a snag with SELinux.  After the OCFS2 partition is mounted no
>> writes can be performed to the shared device from either node because
>> they are being blocked by SELinux.  The core of the issue is that the
>> CentOS default policy does not list OCFS2 as a filesystem that supports
>> xattrs in filesystem.te.  It's a one line fix:
>> 
>> fs_use_xattr ocfs2 gen_context(system_u:object_r:fs_t,s0);
>> 
>> However, it would seem that the only way to implement this change in
>> filesystem.te is by rebuilding the base policy.  (I have not found a way
>> to just reload the filesytem module of the base policy.)  And even if
>> there were an easy way to reload just the filesystem module of the base
>> policy I believe this would be overwritten if an update is released.
>> 
>> So, I was wondering if there was a way to incorporate this line into a
>> module, say ocfs2.te.  My initial attempts have failed, but I am assuming
>> that is because I do not have the correct dependencies listed in the
>> require section.
>> 
>> Any suggestions?
> 
> Unfortunately you can only add fs_use statements to the base module, so
> you'd have to rebuild the base module.
> 
You should be able to mount the file system with a single label.

mount -o context="system_u..."

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFR70gACgkQrlYvE4MpobNnFACglqXTfagTP1SGv4B48u40GcAR
v6EAni59zLo5gElDUCDuVueMXSI/0Ek2
=zKaF
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
