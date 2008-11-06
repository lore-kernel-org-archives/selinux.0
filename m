Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA6ExqIc011316
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 09:59:52 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA6EwC9d020935
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 14:58:12 GMT
Message-ID: <49130644.10303@redhat.com>
Date: Thu, 06 Nov 2008 09:59:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Murray McAllister <mmcallis@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>
Subject: Re: user guide drafts: "Searching for and Viewing Denials" and "Analyzing
 Denials"
References: <49114299.4070400@redhat.com> <4911FCA8.8040602@redhat.com> <4912701E.1070700@redhat.com>
In-Reply-To: <4912701E.1070700@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Murray McAllister wrote:
> Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Murray McAllister wrote:
>>> type=AVC msg=audit(1225875185.864:96): avc:  denied  { getattr } for
>>> pid=2608 comm="httpd" path="/var/www/html/file1" dev=dm-0 ino=284916
>>> scontext=unconfined_u:system_r:httpd_t:s0
>>> tcontext=unconfined_u:object_r:samba_share_t:s0 tclass=file
>>>
>>> { getattr }: The item in braces indicates the permission that was
>>> denied. getattr is used before opening a file. This action is denied due
>> getattr indicates the source process was trying to read the target files
>>   status information,  processes usually check files status before
>> reading.
> getattr indicates the source process was trying to read the target files
> status information (processes usually check the status of files before
> reading them)...
Great
>>> tcontext="unconfined_u:object_r:samba_share_t:s0": The SELinux context
>>> of the object (target) that the process or user attempted to access. In
>> Remove "or user"
>>> this case, it is the SELinux context of file1. Note: the samba_share_t
>>> type is not accessible to processes running in the httpd_t domain.
>>>
>>> In certain situations, the tcontext may match the scontext, such as when
>>> a Linux user is confined and SELinux policy prevents them from
>>> performing an action, for example, running a setuid application.
>>>
>> This happens when a process tries to execute a system service that will
>> change characteristics of the running process, such as changing the uid
>> or chaning limits, or calling the fork system service.  SELinux also
>> generates this type of access violation when a process tries to use a
>> DAC Capability such as reading files that you do not have read access
>> to, or binding to a network port less then 1024.
> How about:
> 
> In certain situations, the tcontext may match the scontext, for example,
> when a process attempts to execute a system service that will change
> characteristics of that running process, such as the user ID. Also, the
> tcontext may match the scontext when a process tries to use more
> resources (such as memory) than normal limits allow, resulting in a
> security check to see if that process is allowed to break those limits.
Great
>>
>> All process access
>>
>>         fork
>>         transition
>>         sigchld # commonly granted from child to parent
>>         sigkill # cannot be caught or ignored
>>         sigstop # cannot be caught or ignored
>>         signull # for kill(pid, 0)
>>         signal  # all other signals
>>         ptrace
>>         getsched
>>         setsched
>>         getsession
>>         getpgid
>>         setpgid
>>         getcap
>>         setcap
>>         share
>>         getattr
>>         setexec
>>         setfscreate
>>         noatsecure
>>         siginh
>>         setrlimit
>>         rlimitinh
>>         dyntransition
>>         setcurrent
>>         execmem
>>         execstack
>>         execheap
>>         setkeycreate
>>         setsockcreate
>>
>>
>> list of capabilities
>>
>>  chown dac_override dac_read_search fowner fsetid kill setgid setuid
>> setpcap linux_immutable net_bind_service net_broadcast net_admin net_raw
>> ipc_lock ipc_owner sys_module sys_rawio sys_chroot sys_ptrace sys_pacct
>> sys_admin sys_boot sys_nice sys_resource sys_time sys_tty_config mknod
>> lease audit_write audit_control setfcap
> Should these be in the user guide?
Maybe in an appendix.  Administrators should have an easy reference
describing some of the rules they are adding to policy via audit2allow.
 SELinux by Example has a good explanation of these. I still need to
reference it to see if allow rules make sense.
>>> As suggested, run the sealert -l 84e0b04d-d0ad-4347-8317-22e74f6cd020
>>> command to view the complete message. This presents the same information
>>> from the sealert GUI:
>>>
>> People don't understand that this command will only work on the local
>> machine, not sure if we need to say this.
>>> [example output]
> How about:
> 
> As suggested, run the sealert -l 84e0b04d-d0ad-4347-8317-22e74f6cd020
> command to view the complete message. This command only works on the
> local machine, and presents the same information as the sealert GUI...
> 
Super
> Thanks.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkTBkQACgkQrlYvE4MpobPiywCfUegwX7+TopPuDpbZp4xNYME7
zL0AnRt+D0hk9F6J2sre7UONqm6zKXg5
=UvKh
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
