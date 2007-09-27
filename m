Message-ID: <46FBC2CF.4060605@tresys.com>
Date: Thu, 27 Sep 2007 10:48:47 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Todd Miller <Tmiller@tresys.com>, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: I am concerned about putting genhomedircon changesinlibsemanage
 into Fedora 8.
References: <200709262020.l8QKKDX7025382@tex.courtesan.com> <46FACCF8.2060500@redhat.com> <6FE441CD9F0C0C479F2D88F959B01588011446F4@exchange.columbia.tresys.com> <46FB08A0.2000308@redhat.com>
In-Reply-To: <46FB08A0.2000308@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Todd Miller wrote:
>> I see the issue, getpwnam_r() has surprising semantics when a user is not found.  I'll have a fix for that tomorrow AM.
>>
>>  - todd
>>
>>
>> -----Original Message-----
>>
>> But
>> /usr/sbin/semanage login -m -s guest_u __default__
>>
>> Is causing a segfault in genhomedircon line 627
> Already have it.
> 
> This is a repatch off of libsemanage-2.0.9
> 
> It should include your stuff plus it gets the fallback_user by looking
> up the __default__ login record.
> 
> That way if I change the __default__ record to use xguest_u, it will
> build all user accounts with this context.
> 
> getpwnam_r returns 0 even if an account does not exist.
> 
> So you need to check the pointer.
> 
> A couple of other translation problems also.
> 

Please inline patches and separate different changes out (eg., swigify 
makefile changes have nothing to do with this).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
