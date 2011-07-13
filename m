Message-ID: <4E1D99D7.1030504@secunet.com>
Date: Wed, 13 Jul 2011 15:12:55 +0200
From: Martin Christian <martin.christian@secunet.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: Sec context of unix domain sockets
References: <4E11E53A.6080003@secunet.com>	 <1310394094.3930.46.camel@moss-pluto>  <4E1C7D08.8000007@secunet.com> <1310491408.309.24.camel@moss-pluto>
In-Reply-To: <1310491408.309.24.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Stephen,

you pointed me into the right direction: We have a startup log daemon
which gets replaced by syslog at the end of the boot process. The AVC
message occurs when /dev/log still belongs to the startup log daemon.
Thanks for your hint!

What I was missing all the time during my investigation was a tool,
which displays the security labels of unix domain sockets. Is there
nothing like this around? netstat doesn't seem to support selinux labels
(an option -Z), does it? Maybe I could reserve some time in our schedule
to add such an option to netstat.

Regards,

Martin.


Am 12.07.2011 19:23, schrieb Stephen Smalley:
> On Tue, 2011-07-12 at 18:57 +0200, Martin Christian wrote:
>> Thanks Stephen for your extensive explanation.
>>
>> Maybe you - or someone else on the list, of course - could help me with
>> a unix socket problem. I'm still not sure whether your explanation (and
>> documentation you referred to) is missing something or if our policy has
>> a bug:
>>
>> We developed a targeted policy for a system with 2 confined services:
>>
>> * syslog is running in domain syslog_t and creates a unix domain socket
>> in /dev/log.
>>
>> * serva is running in domain serva_t and needs to send messages to
>> syslog via the socket.
>>
>> The rest of the system is unconfined with access to everything. Of
>> course, there is a little bit more, but everything else is working just
>> fine.
>>
>> Now, I get the following AVC message:
>>
>> [YYY] type=1400 audit(XXX): avc:  denied  { sendto } for
>>   pid=1879 comm="serva" path="/dev/log"
>>   scontext=system_u:object_r:serva_t:s1
>>   tcontext=system_u:object_r:unconfined_t:s1
>>   tclass=unix_dgram_socket
>>
>> What I don't understand is, why tcontext is not syslog_t but unconfined_t?
>>
>> I thought the following process applies:
>> 1. syslog creates a listing socket with label syslog_t.
>> 2. serva creates a socket for sending with label serva_t.
>> 3. In order to send a message serva would require sendto permissions on
>> syslog_t.
>>
>> There is certainly some more in between these steps, but nothing that
>> would make /dev/log labelled with unconfined_t, is it?
> 
> The socket is labeled when it is created.  So if it is created by a
> process that runs in unconfined_t and then inherited by your syslog as
> an open file descriptor, you would get the behavior you describe.  With
> some init programs (e.g. systemd, Android init), we've had to instrument
> the init program to properly label sockets because the init program
> creates the socket and hands it to the service rather than having the
> service daemon create the socket.
> 
> If that isn't your situation, then another possibility would be that
> syslog is in fact running in unconfined_t due to a policy or labeling
> error.
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJOHZnSAAoJEGpTkDITRjmoIgIIAJCcO1DIP6sidNmN9vbGfWTn
G3UCAWOtKxJ3ACBbGbkOHkvxeMz6BD+YLBLuuvKWdyUqrsAnkQukB8/TmrSuyEnv
1/nuINEZmklqM6SQdYcoFWwy/nNBTYYKWbCqeCJbwrtdUXZ2EsDoKOQ4D6l4n2wU
htq2x6S613yChGOsZEPYIRjH8RIVkzLI4yUgGXZM99HDRuTDPyMB7jcKVeiDfeBy
xq6LcSFngjnhkr1uAyPsNE4qKRyAQ3Cl+QhlbqVm/PWm2V7QWnDtCqUZI73DmM5I
ocCYyufDUWsjiuC0BZRrDytGzx72TeT4SgQ3s7Mh8CgHe6Hdow++bDCVaE0tFu4=
=tyJ5
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
