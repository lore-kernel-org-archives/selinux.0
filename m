Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MLMrO1026718
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 17:22:53 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7MLMqBp021045
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 21:22:52 GMT
Message-ID: <46CCA926.3070205@redhat.com>
Date: Wed, 22 Aug 2007 17:22:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [Fwd: [PATCH] refpolicy: system_iptables changes]
References: <46B22279.9030909@redhat.com> <1187812514.13874.104.camel@gorn>
In-Reply-To: <1187812514.13874.104.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christopher J. PeBenito wrote:
> On Thu, 2007-08-02 at 14:29 -0400, Daniel J Walsh wrote:
>> Switch iptables to use nsswitch
>>
>> --- nsaserefpolicy/policy/modules/system/iptables.te    2007-07-25
>> 10:37:42.000000000 -0400
>> +++ serefpolicy-3.0.4/policy/modules/system/iptables.te 2007-07-25
>> 12:27:26.000000000 -0400
>> @@ -44,6 +44,8 @@
>>
>>  corenet_relabelto_all_packets(iptables_t)
>>
>> +auth_use_nsswitch(iptables_t)
>> +
> 
> I applied this part a few lines down
> 
>>  dev_read_sysfs(iptables_t)
>>
>>  fs_getattr_xattr_fs(iptables_t)
>> @@ -62,6 +64,7 @@
>>  init_use_script_ptys(iptables_t)
>>  # to allow rules to be saved on reboot:
>>  init_rw_script_tmp_files(iptables_t)
>> +init_rw_script_stream_sockets(iptables_t)
> 
> This is weird, what caused this behavior?
> 
Some firewall tool that execs iptables.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGzKkmrlYvE4MpobMRAjVpAJ9fsuWej8tKcqTObJ21bRtIooItuACfcKmg
9ARrzgIfAFMNwxcgvY6yuAE=
=eIl/
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
