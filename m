Message-ID: <4706710B.8050006@redhat.com>
Date: Fri, 05 Oct 2007 13:14:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policycoreutils patch for semanage/seobject.py
References: <4703B5CA.7040309@redhat.com>	 <1191594199.891.11.camel@moss-spartans.epoch.ncsc.mil> <1191594937.891.17.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1191594937.891.17.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen Smalley wrote:
> On Fri, 2007-10-05 at 10:23 -0400, Stephen Smalley wrote:
>> On Wed, 2007-10-03 at 11:31 -0400, Daniel J Walsh wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Patch implements handling of booleans via semanage
>>>
>>> Adds display of local list.  So you can either show all booleans,
>>> fcontext, ports or just your local modifications.
>>>
>>> Implements a store command, so you can use semanage to manage
>>> alternative stores.
>>>
>>> Implements deleteall so you can remove all local customizations.
>>>
>>> Add support for <<none>> as a context type for fcontext.
>> Thanks, merged, although I think we will want to eventually revisit the
>> division of labor between semanage and libsemanage for
>> interpreting/handling <<none>>.
>>
>> Also, it seems like the deleteall method should be implemented for all
>> relevant objects - seems useful for fcontext as well as boolean.
>>
>> When would use you use setsebool -P vs. semanage boolean -m?
> 
> Actually, you don't appear to have fully implemented semanage boolean -m
> support (value is never defined).
> 
Yes the boolean support needs to be fully implemented.  Most of the
changes up to this part have been for support of the gui, which still
uses setsebool.  I would like to implement the rest of them and then
start adding fancier search capabilities to the commandline/gui.

Start to consolidate the translations, descriptions etc.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHBnEKrlYvE4MpobMRAmWuAKCFj7CzLu8pIhgNPc/IXhrDd9lo2wCfffC/
mUrDqW8XErDzeRqMSrJQjlc=
=gjW5
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
