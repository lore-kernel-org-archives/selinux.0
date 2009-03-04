Message-ID: <49AEA224.1060304@redhat.com>
Date: Wed, 04 Mar 2009 10:45:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dbus reading /proc/X/cmdline
References: <200903042309.37571.russell@coker.com.au> <1236175254.2679.19.camel@localhost.localdomain>
In-Reply-To: <1236175254.2679.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Wed, 2009-03-04 at 23:09 +1100, Russell Coker wrote:
>> Why does the dbus-daemon want to read the cmdline of every process that it 
>> talks to?  Is it something to allow or dontaudit?  It appears to work without 
>> allowing it.
>>
>> type=AVC msg=audit(1236168464.840:83): avc:  denied  { search } for  pid=2757 
>> comm="dbus-daemon" name="2874" dev=proc ino=12535 
>> scontext=unconfined_u:unconfined_r:system_dbusd_t:s0-s0:c0.c1023 
>> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=dir
>> type=AVC msg=audit(1236168464.840:83): avc:  denied  { read } for  pid=2757 
>> comm="dbus-daemon" name="cmdline" dev=proc ino=12536 
>> scontext=unconfined_u:unconfined_r:system_dbusd_t:s0-s0:c0.c1023 
>> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=file
>> type=SYSCALL msg=audit(1236168464.840:83): arch=40000003 syscall=5 success=yes 
>> exit=16 a0=b8481fa0 a1=0 a2=b3a a3=b84826c0 items=0 ppid=1 pid=2757 
>> auid=4294967295 uid=103 gid=105 euid=103 suid=103 fsuid=103 egid=105 sgid=105 
>> fsgid=105 tty=(none) ses=4294967295 comm="dbus-daemon" 
>> exe="/usr/bin/dbus-daemon" 
>> subj=unconfined_u:unconfined_r:system_dbusd_t:s0-s0:c0.c1023 key=(null)
> 
> It appears to fetch that information for logging purposes (comm= field).
> 
dbus also has the ability to state that an executable is the only one
that is able to communicate over it.  Not very secure.  But it is there.

I can put in the config that only /usr/libexec/nm-applet is able to
communicate with network-manager.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmuoiQACgkQrlYvE4MpobM/JgCgzin1pYFSKS4ka2sdpbstaMxf
plcAoOLQSrfWgeoOHjwDtc+CFm4Btzfa
=xCKi
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
