Message-ID: <46FA7572.4020809@redhat.com>
Date: Wed, 26 Sep 2007 11:06:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I am concerned about putting genhomedircon changes in libsemanage
 into Fedora 8.
References: <46CED283.8060804@redhat.com> <46FA661F.1080703@redhat.com> <46FA7107.2000003@manicmethod.com>
In-Reply-To: <46FA7107.2000003@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Joshua Brindle wrote:
> Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Daniel J Walsh wrote:
>>  
>>> I may hold off on this so we can get a full Rawhide cycle on it.
>>> genhomedircon has many corner cases and do not want to risk blowing F-8
>>> now that we are at Feature Freeze.
>>> All the rest of the patches have been integrated.
>>
>>
>>
>> The genhomedircon replacement is broken in libsemanage.  It is
>> generating invalid file context.  The python version verified the
>> file context it was creating were valid before assiging them.  This is
>> resulting in Fedora Core 8 not being able to autorelabel
>>
>>   
> 
> The python version did the wrong thing entirely. It validated the
> contexts against the running policy in the kernel, which breaks when you
> try to do an operation on another store. Also since we moved
> genhomedircon inside of libsemanage the new policy isn't even loaded yet
> so we can't validate against the kernel (or the new types added by the
> module being added would be 'invalid'). The only real way to validate
> the contexts now would be to load the newly generated policy into the
> libsepol security server and to the context validations on it.
> 

> This would work, it would just take extra time at module load time. It
> seems like the real problem is that the invalid contexts are being
> generated in the first place, relying on genhomedircon to sanity check
> your file contexts seems like you are punting the problem.
> 
Whether it did the wrong thing or not, the current functionality is more
broken.  You can not relabel with the current policy.  If SEManage could
automatically generate the homedir context based off the available
homedirectory context great.  Otherwise the only way we can do it is to
generate all the homedir context and then figure out which ones are
valid for this user.

Lets fix the short time problem, by putting in the simple check the
currently running kernel.   If semanage loads the policy before
generating the homedir context, it should work fine. It is the best we
can do in the short run. And it works in the real world for now.

If we want to invalidate this on -s TYPE not matching fine.  Once we
have patches that will validate on the installed context versus the one
loaded into the kernel.  We have other problems that I want to bring up
in other email chains.  About handling the installation of modules and
running of semanage when selinux is disabled.

For now we are in the Deep Freeze of Fedora 8 and I can't relabel
because of libsemanage/genhomedircon
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG+nVyrlYvE4MpobMRAoABAJ9im0eCkD2estiweUrj7tbC48WPNgCguLrJ
4yjcaWIZuUT01vCM+4cAJAQ=
=RKGY
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
