Message-ID: <4F673973.5060405@redhat.com>
Date: Mon, 19 Mar 2012 09:49:39 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: global name 'seinfo' is not defined
References: <201203191716.19321.russell@coker.com.au> <1332159108.23035.1.camel@moss-pluto>
In-Reply-To: <1332159108.23035.1.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/19/2012 08:11 AM, Stephen Smalley wrote:
> On Mon, 2012-03-19 at 17:16 +1100, Russell Coker wrote:
>> I'm stuck on the following error after updating the Debian
>> packages to the latest userspace.  Could someone please tell me
>> where this "seinfo" function is supposed to be defined?  I can
>> probably work out the cause of this if I could find where it's
>> defined.
> 
> setools (setools-libs-python in Fedora).
> 
>> 
>> As an aside, if someone who's good at Python wants to help out
>> with the Debian SE Linux work then that would be greatly
>> appreciated.  Not much work is required, but it's tough for
>> people like me who generally don't do Python.
>> 
>> 
>> # dmesg|audit2allow Traceback (most recent call last): File
>> "/usr/bin/audit2allow", line 354, in <module> app.main() File
>> "/usr/bin/audit2allow", line 345, in main self.__output() File
>> "/usr/bin/audit2allow", line 315, in __output 
>> g.add_access(self.__avs) File
>> "/usr/lib/python2.7/dist-packages/sepolgen/policygen.py", line
>> 211, in add_access self.__add_allow_rules(raw_allow) File
>> "/usr/lib/python2.7/dist-packages/sepolgen/policygen.py", line
>> 179, in __add_allow_rules self.domains = seinfo(ATTRIBUTE,
>> name="domain")[0]["types"] NameError: global name 'seinfo' is not
>> defined
>> 
> 


Here are the appatches to setools that Fedora applies, currently.  If
upstream is willing to take them, that would be great.

http://people.fedoraproject.org/~dwalsh/SELinux/setools/

The biggest change is the addition of setools bindings, which has
allowed us to build some interesting command line tools and enhance
setroubleshoot.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9nOXMACgkQrlYvE4MpobPuegCfaBSLAU4cY5CeJA0uQB4z08z+
6hYAn0COBnUBSSoaq1covtqMUn6CqZdk
=32fD
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
