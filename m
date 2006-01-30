Subject: Re: [SEPOL] Fix overflow bugs on athlon 64
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43DC0E2E.7030804@cornell.edu>
References: <43DC0E2E.7030804@cornell.edu>
Content-Type: text/plain; charset=utf-8
Date: Mon, 30 Jan 2006 14:41:45 -0500
Message-Id: <1138650105.7076.167.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-01-28 at 17:37 -0700, Ivan Gyurdiev wrote:
> Fix overflow bugs of two kinds, visible on my athlon64:
> 
> - find perm should not abuse the integer (4 byte) return value to put an 
> 8-byte char* in it.

Sigh.  This one was fixed in checkpolicy a long time ago (2003/05/09),
not sure how it crept back into libsepol.

> - Use %ul to print size_t, %u will overflow.

No good, as that then complains on x86:
module.c:278: warning: format ‘%lu’ expects type ‘long unsigned int’,
but argument 5 has type ‘size_t’
...

Have to double-check, but I think that %z is what we have to use here
for portability.

> Also, someone should take a look into this:
> 
> ==31626== Syscall param write(buf) points to uninitialised byte(s)
> ==31626==    at 0x37E2EBBC60: __write_nocancel (in /lib64/libc-2.3.90.so)
> ==31626==    by 0x37E2E66812: _IO_file_write@@GLIBC_2.2.5 (in 
> /lib64/libc-2.3.90.so)
> ==31626==    by 0x37E2E66725: _IO_do_write@@GLIBC_2.2.5 (in 
> /lib64/libc-2.3.90.so)
> ==31626==    by 0x37E2E67B48: _IO_file_xsputn@@GLIBC_2.2.5 (in 
> /lib64/libc-2.3.90.so)
> ==31626==    by 0x37E2E5DB59: fwrite (in /lib64/libc-2.3.90.so)
> ==31626==    by 0x4A913D0: put_entry (private.h:69)
> ==31626==    by 0x4A93088: class_write (write.c:816)
> ==31626==    by 0x4A747D4: hashtab_map (hashtab.c:236)
> ==31626==    by 0x4A950EE: policydb_write (write.c:1483)
> ==31626==    by 0x4A81713: sepol_module_package_write (module.c:573)
> ==31626==    by 0x4BBD39F: semanage_write_module (in 
> /lib64/libsemanage.so.1)
> ==31626==    by 0x4BBD76C: semanage_direct_commit (in 
> /lib64/libsemanage.so.1)
> 
> One suspicious thing is passing the 8-byte size_t values len/len2 into 
> cpu_to_le32, but I couldn't completely track this down, so I leave it to 
> someone else for now :)
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
