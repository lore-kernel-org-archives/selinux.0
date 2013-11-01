Message-ID: <52741B6C.8010006@redhat.com>
Date: Fri, 01 Nov 2013 17:21:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, "Carlos O'Donell" <carlos@redhat.com>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov, codonell@redhat.com
Subject: Re: Handling unknown permissions in userspace object managers
References: <1383319095.28218.37.camel@flatline.rdu.redhat.com>  <5273CD37.6060602@tycho.nsa.gov> <1383321297.28218.40.camel@flatline.rdu.redhat.com> <5273D003.70601@tycho.nsa.gov> <5273DE3D.4070402@redhat.com> <5273DEB3.5050808@tycho.nsa.gov>
In-Reply-To: <5273DEB3.5050808@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/01/2013 01:02 PM, Stephen Smalley wrote:
> On 11/01/2013 01:00 PM, Carlos O'Donell wrote:
>> On 11/01/2013 12:00 PM, Stephen Smalley wrote:
>>> But selinux_check_access() is IMHO a better way to go for any new code 
>>> unless it is so performance-critical that the context, class, and perm 
>>> lookups per check are prohibitive.
>> 
>> The code in question is from glibc's nscd and used when determining if 
>> the user should or should not have access to specific cache results, and 
>> therefore it is performance sensitive. The faster we can determine if 
>> access is allowed the faster we can return a result to a client that 
>> needs an answer about a particular credential. I'm happing doing the 
>> translations at startup when the daemon is initializing, but I'm not 
>> happy to do them at every request arriving to the daemon. Unless someone 
>> says this needs to be fully dynamic I'd like to avoid any costs during 
>> the request handling phase.
> 
> I doubt the overhead of the SID/class/perm lookup compares to the IPC 
> overhead, but I can't say that I've measured it.  But feel free to use 
> whichever interface you prefer.
> 
> 
> 
> 
> -- This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without quotes
> as the message.
> 
We could potentially optimize the calls similarly to what we did with
procattr, where we cache the previous lookup.  Since the
source,type,class,perm flags will often be repeated.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJ0G2wACgkQrlYvE4MpobM5twCeN14XzW+AaRpnMHf58EAETeuu
IVYAoOmXkl9dIh4ARQjQDkl3JIH1WUnj
=5ZEm
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
