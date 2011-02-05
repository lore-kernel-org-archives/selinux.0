Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p15DQKgl008991
	for <selinux@tycho.nsa.gov>; Sat, 5 Feb 2011 08:26:20 -0500
Received: from mail-ey0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p15DQJmC024155
	for <selinux@tycho.nsa.gov>; Sat, 5 Feb 2011 13:26:19 GMT
Received: by eyh6 with SMTP id 6so1623523eyh.12
        for <selinux@tycho.nsa.gov>; Sat, 05 Feb 2011 05:26:18 -0800 (PST)
Message-ID: <4D4D4FF5.6000303@gmail.com>
Date: Sat, 05 Feb 2011 14:26:13 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Simon Peter Nicholls <simon@mintsource.org>
CC: selinux@tycho.nsa.gov
Subject: Re: Trouble logging in through SSH
References: <4D4C8A4C.1070101@mintsource.org> <4D4D0B63.8070509@mintsource.org>
In-Reply-To: <4D4D0B63.8070509@mintsource.org>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/05/2011 09:33 AM, Simon Peter Nicholls wrote:
> On 05/02/11 00:22, Simon Peter Nicholls wrote:
>> Hi All,
>>
>> I'm having some trouble setting up SELinux using refpolicy, and am
>> unable to login my test user through ssh when in enforcing mode. Could
>> someone help me work out where the problem lies? I have some basic
>> experience with SELinux, but based on working Fedora systems that have
>> gone slightly awry.
>>
>> Similar denial messages to the ssh one are seen when trying to run
>> software like Emacs in permissive mode. In each case it feels like I
>> am restricted by the consoletype_t, whilst I was expecting to gain an
>> unconfined_t type for my user (to match unconfined_u & unconfined_r).
>>
>> I also expected to see the sshd_t type for the sshd process, but it is
>> using init_t. Are transitions failing for my startup services?
> 
> Typical. The act of writing this gave substance to my suspicions. I
> checked the type for the the SSH init script and it was incorrectly set
> to etc_t, the underlying reason being that Arch Linux uses the
> non-standard /etc/rc.d directory for it's startup scripts.
> 
> As a quick test to confirm, I used chcon to set the sshd script to
> initrc_exec_t, rebooted, and I find I can login under enforcing mode.
> The sshd process now has the sshd_t type, and my user also has the
> unconfined_u:unconfined_r:unconfined_t context, as I previously
> expected. The subsequent running of programs like Emacs are now no problem.
> 
> I have some log related denials however, which I'll look into. Any
> pointers would be appreciated.

Looks like /dev/log is mislabelled for some reason.
Does syslog run in the proper domain?

> Feb  5 09:13:41 mailer kernel: type=1400 audit(1296893621.240:3): avc: 
> denied \
>  { write } for  pid=945 comm="sshd" name="log" dev=devtmpfs ino=4929
> scontext=s\
> ystem_u:system_r:sshd_t tcontext=system_u:object_r:device_t
> tclass=sock_file
> Feb  5 09:13:41 mailer kernel: type=1400 audit(1296893621.240:4): avc: 
> denied \
>  { connectto } for  pid=945 comm="sshd" path="/dev/log"
> scontext=system_u:syste\
> m_r:sshd_t tcontext=system_u:system_r:init_t tclass=unix_stream_socket
> 
> 
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk1NT/UACgkQMlxVo39jgT8mxQCg0se84g3dMmc89cQy/aY6i0+L
aLoAnjp5NaoR2OsHVGPdxPkHU7nG8sxL
=GXdW
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
