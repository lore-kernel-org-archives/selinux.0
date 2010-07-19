Message-ID: <4C44AAB3.8050600@redhat.com>
Date: Mon, 19 Jul 2010 15:42:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: New init system hitting a distro near you.
References: <4C1BCA54.20005@redhat.com> <201006211120.29742.paul.moore@hp.com> <1277134008.6338.2.camel@moss-pluto.epoch.ncsc.mil> <201006211335.57122.paul.moore@hp.com>
In-Reply-To: <201006211335.57122.paul.moore@hp.com>
Content-Type: multipart/mixed;
 boundary="------------030709010307040103050504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030709010307040103050504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/21/2010 01:35 PM, Paul Moore wrote:
> On Monday, June 21, 2010 11:26:48 am Stephen Smalley wrote:
>> On Mon, 2010-06-21 at 11:20 -0400, Paul Moore wrote:
>>> On Friday, June 18, 2010 04:31:45 pm Stephen Smalley wrote:
>>>> On Fri, 2010-06-18 at 16:22 -0400, Stephen Smalley wrote:
>>>>> On Fri, 2010-06-18 at 16:00 -0400, Daniel J Walsh wrote:
>>>>>> On 06/18/2010 03:45 PM, Stephen Smalley wrote:
>>>>>>> On Fri, 2010-06-18 at 15:34 -0400, Daniel J Walsh wrote:
>>>>>>>> http://0pointer.de/blog/projects/systemd.html
>>>>>>>>
>>>>>>>> This has interesting ramifications for SELinux.  I have a
>>>>>>>> working version of this in Fedora 14, but we need to add rules
>>>>>>>> like
>>>>>>>>
>>>>>>>> allow sshd_t init_t:tcp_socket { getopt ioctl getattr setopt };
>>>>>>>>
>>>>>>>> Since systemd will be doing the listening and passing the socket
>>>>>>>> to sshd.
>>>>>>>>
>>>>>>>> Could we have risks of sshd_t grabbing the tcp_socket connected
>>>>>>>> to httpd_t?
>>>>>>>>
>>>>>>>> In this scenario we are no longer protecting against the
>>>>>>>> name_bind, and are forced to put more trust into init_t.
>>>>>>>
>>>>>>> Can we get systemd to use setsockcreatecon() to assign the right
>>>>>>> label to the socket?
>>>>>>
>>>>>> Probably but how does it figure out the context?
>>>>>
>>>>> The sockets would normally be labeled with the context of the
>>>>> individual daemon process.  So we would want to compute the context
>>>>> in which the daemon process will run and then use that for the
>>>>> socket.  Which we can do via security_compute_create().  Sample code
>>>>> attached.  Compile with: gcc -lselinux -o setsockcon setsockcon.c
>>>>>
>>>>> Example run (in permissive):
>>>>> $ runcon system_u:system_r:init_t:s0 ./setsockcon /usr/sbin/sshd
>>>>> /usr/sbin/sshd system_u:system_r:sshd_t:s0
>>>>
>>>> So the concept here is that systemd must already know the path to the
>>>> daemon executable as part of its config, so it can call the
>>>> setsockconfrompath() function on that path prior to calling socket() to
>>>> create the socket.  You can have the function bail immediately if
>>>> (is_selinux_enabled() < 1), and perhaps ignore errors from it if
>>>> (security_getenforce() < 1).
>>>>
>>>> We'll need something similar for Unix domain sockets to ensure that the
>>>> file gets labeled properly, but using security_compute_create() on the
>>>> daemon context, the parent directory context, and
>>>> string_to_security_class("sock_file") to determine the right context
>>>> and using setfscreatecon() before calling bind().  A bit messy.
>>>
>>> I would need to check the code a bit closer and test it to be certain but
>>> I believe that setsockcreatecon() should work for UNIX domain sockets
>>> too.  At least selinux_socket[_post]_create() applies the sockcreate_sid
>>> regardless of the socket's address family.
>>>
>>> Granted, determining the correct label is still a bit ugly but at least
>>> you don't have to use setfscreatecon() would could get nasty very
>>> quickly if you're not careful.
>>
>> With Unix domain sockets bound to the filesystem namespace, there are
>> two separate objects:  the socket and the file.
> 
> Yes, sorry, my mistake; I was thinking of the socket fsetxattr() labeling 
> support - that supported labeling the filesystem and socket components of a 
> UNIX domain socket.
> 

Hacked up setsockcon a little bit further to try to establish the
correct context for an object created by the executable in a particular
directory

runcon system_u:system_r:init_t:s0 ./setsockcon /bin/dbus-daemon
/var/run/dbus/ sock_file
/bin/dbus-daemon system_u:system_r:system_dbusd_t:s0
system_u:object_r:system_dbusd_var_run_t:s0

runcon system_u:system_r:init_t:s0 ./setsockcon /usr/sbin/avahi-daemon
/var/run/avahi-daemon sock_file
/usr/sbin/avahi-daemon system_u:system_r:avahi_t:s0
system_u:object_r:avahi_var_run_t:s0

This does not currently handle creating multiple objects in the path if
they do not exist.



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxEqrMACgkQrlYvE4MpobPXuACfQi1BUE3l3IwxfGdBAsuv5KXh
RXcAoKTxC3wZrScQtvRqLvius46EcUl3
=Zd4q
-----END PGP SIGNATURE-----

--------------030709010307040103050504
Content-Type: text/plain;
 name="setsockcon.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="setsockcon.c"

I2luY2x1ZGUgPHNlbGludXgvc2VsaW51eC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1
ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+Ci8qCiAgY2xhc3MgY2FuIGJlCiAg
ImZpbGUiCiAgImRpciIKICAibG5rX2ZpbGUiCiAgInNvY2tfZmlsZSIKICAiZmlmb19maWxl
IgogICJjaHJfZmlsZSIKICAiYmxrX2ZpbGUiCiovCgpzdGF0aWMgaW50IGdldGZpbGVjb25m
cm9tcGF0aChzZWN1cml0eV9jb250ZXh0X3Qgc2NvbiwgY29uc3QgY2hhciAqcGF0aCwgY2hh
ciAqY2xhc3MsIHNlY3VyaXR5X2NvbnRleHRfdCAqbmV3Y29uKSB7CglzZWN1cml0eV9jb250
ZXh0X3QgZmNvbiA9IE5VTEw7CglzZWN1cml0eV9jbGFzc190IHNjbGFzczsKCWludCByYyA9
IDA7CgoJcmMgPSBnZXRmaWxlY29uKHBhdGgsICZmY29uKTsKCWlmIChyYyA8IDApCgkJZ290
byBvdXQ7CglzY2xhc3MgPSBzdHJpbmdfdG9fc2VjdXJpdHlfY2xhc3MoY2xhc3MpOwoJcmMg
PSBzZWN1cml0eV9jb21wdXRlX2NyZWF0ZShzY29uLCBmY29uLCBzY2xhc3MsIG5ld2Nvbik7
CglpZiAocmMgPCAwKQoJCWdvdG8gb3V0OwpvdXQ6CglmcmVlY29uKGZjb24pOwoJcmV0dXJu
IHJjOwp9CgpzdGF0aWMgaW50IGdldGNvbmZyb21leGUoY29uc3QgY2hhciAqZXhlLCBzZWN1
cml0eV9jb250ZXh0X3QgKm5ld2NvbikKewoJc2VjdXJpdHlfY29udGV4dF90IG15Y29uID0g
TlVMTCwgZmNvbiA9IE5VTEw7CglzZWN1cml0eV9jbGFzc190IHNjbGFzczsKCWludCByYyA9
IDA7CgoJcmMgPSBnZXRjb24oJm15Y29uKTsKCWlmIChyYyA8IDApCgkJZ290byBvdXQ7Cgly
YyA9IGdldGZpbGVjb24oZXhlLCAmZmNvbik7CglpZiAocmMgPCAwKQoJCWdvdG8gb3V0OwoJ
c2NsYXNzID0gc3RyaW5nX3RvX3NlY3VyaXR5X2NsYXNzKCJwcm9jZXNzIik7CglyYyA9IHNl
Y3VyaXR5X2NvbXB1dGVfY3JlYXRlKG15Y29uLCBmY29uLCBzY2xhc3MsIG5ld2Nvbik7Cglp
ZiAocmMgPCAwKQoJCWdvdG8gb3V0OwpvdXQ6CglmcmVlY29uKG15Y29uKTsKCWZyZWVjb24o
ZmNvbik7CglyZXR1cm4gcmM7Cn0KCnZvaWQgdXNhZ2UoY29uc3QgY2hhciAqcHJvZ3JhbSkg
ewoJcHJpbnRmKAoiJXMgZXhlY19wYXRoIGxpc3Rlbl9kaXJlY3RvcnkgdHlwZVxuXG4iCiIl
cyAvdXNyL3NiaW4vYXZhaGktZGFlbW9uIC92YXIvcnVuIGZpbGVcbiIKLCBwcm9ncmFtLCBw
cm9ncmFtKTsKCQoJCn0KaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KSAKewoJaW50
IGk7CglzZWN1cml0eV9jb250ZXh0X3QgbmV3Y29uID0gTlVMTDsKCXNlY3VyaXR5X2NvbnRl
eHRfdCBmaWxlY29uID0gTlVMTDsKCglpZiAoIGFyZ2MgPCAzICkgewoJCXVzYWdlKGFyZ3Zb
MF0pOwoJCWV4aXQoMSk7Cgl9CgoJLyogVGhpcyBmdW5jdGlvbiByZXR1cm5zIHRoZSBjb250
ZXh0IGRlZmluZWQgaW4gcG9saWN5IGZvciB0aGUgCgkgICBleGVjdXRhYmxlIGFyZ3ZbMV0s
IGFmdGVyIGl0IHRyYW5zaXRpb25zIGZyb20gdGhlIGN1cnJlbnQgY29udGV4dCAqLwoJaWYg
KGdldGNvbmZyb21leGUoYXJndlsxXSwgJm5ld2NvbikgPCAwKSB7CgkJcGVycm9yKGFyZ3Zb
MV0pOwoJCWV4aXQoMSk7Cgl9CgkvKiBUaGlzIGZ1bmN0aW9uIHRlbGxzIHRoZSBrZXJuZWwg
dG8gbGFiZWwgYWxsIHNvY2tldHMgYWZ0ZXIgdGhpcyBjYWxsIAoJICAgd2l0aCB0aGUgbmV3
Y29uIGNvbnRleHQsIHVudGlsbCB0aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBhZ2FpbiAqLwoJ
aWYgKHNldHNvY2tjcmVhdGVjb24obmV3Y29uKSA8IDApIHsKCQlwZXJyb3IoYXJndlsxXSk7
CgkJZXhpdCgxKTsKCX0KCS8qIFRoaXMgZnVuY3Rpb24gcmV0dXJucyB0aGUgZmlsZSBjb250
ZXh0IGRlZmluZWQgaW4gcG9saWN5IGZvciB0aGUgCgkgICBjb250ZXh0IG5ld2NvbiwgY3Jl
YXRpbmcgYSBvYmplY3Qgb2YgdHlwZSBhcmdbMl0gaW4gdGhlIGRpcmVjdG9yeSAKCSAgIGFy
Z3ZbMl0gKi8KCWlmIChnZXRmaWxlY29uZnJvbXBhdGgobmV3Y29uLCBhcmd2WzJdLCBhcmd2
WzNdLCAmZmlsZWNvbikgIDwgMCkgewoJCXBlcnJvcihhcmd2WzJdKTsKCQlleGl0KDEpOwoJ
fQoJcHJpbnRmKCIlcyAlcyAlc1xuIiwgYXJndlsxXSwgbmV3Y29uLCBmaWxlY29uKTsKCS8q
IFRoaXMgZnVuY3Rpb24gdGVsbHMgdGhlIGtlcm5lbCB0byBsYWJlbCBhbGwgZmlsZSBzeXN0
ZW0gb2JqZWN0cyAKCSAgIGNyZWF0ZWQgYWZ0ZXIgdGhpcyBjYWxsIHdpdGggdGhlIGZpbGVj
b24gY29udGV4dCwgdW50aWwgdGhpcyAKCSAgIGZ1bmN0aW9uIGlzIGNhbGxlZCBhZ2FpbiAq
LwoKCWlmIChzZXRmc2NyZWF0ZWNvbihmaWxlY29uKSA8IDApIHsKCQlwZXJyb3IoZmlsZWNv
bik7CgkJZXhpdCgxKTsKCX0KCWZyZWVjb24obmV3Y29uKTsKCWZyZWVjb24oZmlsZWNvbik7
CgoJLyogY2FsbGluZyBzZXRzb2NrY3JlYXRlY29uIGFuZCBzZXRmc2NyZWF0ZWNvbiB3aXRo
IHRoZSBOVUxMIHBhcmFtZXRlciAKCSAgIHJlc2V0cyB0aGUgc3lzdGVtIHRvIHRoZSBkZWZh
dWx0ICovCglzZXRzb2NrY3JlYXRlY29uKE5VTEwpOwoJc2V0ZnNjcmVhdGVjb24oTlVMTCk7
CgoJZXhpdCgwKTsKfQo=
--------------030709010307040103050504
Content-Type: application/pgp-signature;
 name="setsockcon.c.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="setsockcon.c.sig"

iEYEABECAAYFAkxEqrMACgkQrlYvE4MpobO8eACeKMMx26ANSgJ0UdmW5MxE0OnZ3qAAniO1
Y0k94TZVRO/4IWutfVZMoWix
--------------030709010307040103050504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
