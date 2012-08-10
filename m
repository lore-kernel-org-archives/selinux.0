Message-ID: <502500ED.5050502@redhat.com>
Date: Fri, 10 Aug 2012 08:39:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Colin Walters <walters@verbum.org>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, lennart@poettering.net, sds@tycho.nsa.gov
Subject: Re: A filename to label translation daemon
References: <1344454290.25533.12.camel@localhost> <201208100037.21877.russell@coker.com.au> <5023EE1C.5060205@redhat.com> <201208101228.11637.russell@coker.com.au>
In-Reply-To: <201208101228.11637.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/09/2012 10:28 PM, Russell Coker wrote:
> On Fri, 10 Aug 2012, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> On 08/09/2012 10:37 AM, Russell Coker wrote:
>>> On Thu, 9 Aug 2012, Colin Walters <walters@verbum.org> wrote:
>>>> Seems to make sense...though someone could also probably get fairly
>>>> far by writing a regular expression optimizer.  It might not even be
>>>> that hard to write a multi-regexp matching engine which took a set of
>>>> regexps at once and constructed a single matching DFA for them.
>>> 
>>> Is this really going to help?  My slowest system is a P3-866 which
>>> takes less than 30ms of user time for "restorecon /bin/bash" and takes
>>> a total of 136ms of wall time if the cache is cold.  On a 1.8GHz 64bit
>>> system it's only 8ms of user time.
>>> 
>>> What benefit are we expecting to get here?
>> 
>> kerberos library currently does a matchpathcon on /tmp/BLAH files and
>> sets the label correctly.  With this change in the library we are seeing
>> huge performance hits of apache services caused by loading the regex.
> 
> What is kerberos doing under /tmp and why is it being done repeatedly by 
> different processes?
> 
Actually /var/tmp/HOST_0 /var/tmp/HTTP_23 ...  Kerberos Replay Cache.   Every
time someone contacts an apache server using kerberos it needs to update this
file, it does this via mktemp (/tmpHTTPD_23XXXX), rename.

/var/cache/krb5rcache(/.*)?	system_u:object_r:krb5_host_rcache_t:s0
/var/tmp/nfs_0	--	system_u:object_r:krb5_host_rcache_t:s0
/var/tmp/host_0	--	system_u:object_r:krb5_host_rcache_t:s0
/var/tmp/HTTP_23	--	system_u:object_r:krb5_host_rcache_t:s0
/var/tmp/HTTP_48	--	system_u:object_r:krb5_host_rcache_t:s0
/var/tmp/ldap_55	--	system_u:object_r:krb5_host_rcache_t:s0
/var/tmp/ldap_487	--	system_u:object_r:krb5_host_rcache_t:s0
/var/tmp/ldapmap1_0	--	system_u:object_r:krb5_host_rcache_t:s0

>> Running make install has caused a huge hit if you are running thousands
>> of install commands which caused the remove of labeling from the install 
>> command.
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=638304
> 
> I believe that is a design bug in the SE Linux code in install, I've filed
> the above Debian bug report about it.
> 
> I think that correct design of install wouldn't have a "make install" 
> performed as part of a dpkg or rpm build do any SE Linux checks.  That
> would be faster than any other option.
> 
Programmers and testers regularly run make install and this ends up badly
mislabling files all over the place, telling everyone they have to use rpm or
dpkg is not going to fly.
>> Systemd has been is executing the load load many many times and is
>> showing up to 1 second slow down on startup.  If the startup is 10
>> seconds, it is kind of hard to justify 10% slowdown on boot.
> 
> Wow, who's got a 10 second boot?
> 
> Is systemd loading the file contexts 100 times?  If not then why is it
> taking a second?
> 
10 second boot is available with solid state machines.  Systemd has not seen
the kind of performance that you are and obviously this is sensitive to the
speed of the CPU/Memory.
>> I believe we just add support for this service and have the labeling
>> fall back to the default if the labeling socket does not exists, and
>> then distributions can decide whether or not they want to use it.
> 
> I'm not opposed to making such changes and a 10% performance improvement is
>  definitely worth getting.  But first I think we should consider other 
> approaches to some of these issues such as changing the way install works.
> 

I would prefer Colin suggestion to pre-compiling the regex, if this is
possible.  Then we could do it in the libsemanage any time file context got
updated and put a watch into selinux-policy package to recompile any time gcc
got updated.  I just have no idea how to do this.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAlAO0ACgkQrlYvE4MpobNyigCgzMUbwkHn+PRkvSHOzrwsNyfk
MkEAnjGO44MUdXtG+x97C3cpY75jDNdP
=1AdS
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
