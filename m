Message-ID: <43DE8153.10400@cornell.edu>
Date: Mon, 30 Jan 2006 16:12:51 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [SEPOL] Fix overflow bugs on athlon 64
References: <43DC0E2E.7030804@cornell.edu>	 <1138650105.7076.167.camel@moss-spartans.epoch.ncsc.mil> <1138652517.7076.185.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1138652517.7076.185.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>>> Also, someone should take a look into this:
>>>
>>> ==31626== Syscall param write(buf) points to uninitialised byte(s)
>>> ==31626==    at 0x37E2EBBC60: __write_nocancel (in /lib64/libc-2.3.90.so)
>>> ==31626==    by 0x37E2E66812: _IO_file_write@@GLIBC_2.2.5 (in 
>>> /lib64/libc-2.3.90.so)
>>> ==31626==    by 0x37E2E66725: _IO_do_write@@GLIBC_2.2.5 (in 
>>> /lib64/libc-2.3.90.so)
>>> ==31626==    by 0x37E2E67B48: _IO_file_xsputn@@GLIBC_2.2.5 (in 
>>> /lib64/libc-2.3.90.so)
>>> ==31626==    by 0x37E2E5DB59: fwrite (in /lib64/libc-2.3.90.so)
>>> ==31626==    by 0x4A913D0: put_entry (private.h:69)
>>> ==31626==    by 0x4A93088: class_write (write.c:816)
>>> ==31626==    by 0x4A747D4: hashtab_map (hashtab.c:236)
>>> ==31626==    by 0x4A950EE: policydb_write (write.c:1483)
>>> ==31626==    by 0x4A81713: sepol_module_package_write (module.c:573)
>>> ==31626==    by 0x4BBD39F: semanage_write_module (in 
>>> /lib64/libsemanage.so.1)
>>> ==31626==    by 0x4BBD76C: semanage_direct_commit (in 
>>> /lib64/libsemanage.so.1)
>>>
>>> One suspicious thing is passing the 8-byte size_t values len/len2 into 
>>> cpu_to_le32, but I couldn't completely track this down, so I leave it to 
>>> someone else for now :)
>>>       
>
> Any other occurrences beyond the one from class_write?
>   
No, that's the only trace I got from valgrind /usr/sbin/semanage -B.

It'd be useful to be able to valgrind over some of the python code (like 
pywrap-test.py),
but that seems to be a hopeless task. I tried installing a suppressions 
file for python, which did not work for me..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
