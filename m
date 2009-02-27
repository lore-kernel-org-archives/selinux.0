Message-ID: <49A83D73.6050706@redhat.com>
Date: Fri, 27 Feb 2009 14:22:27 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: Joe Nall <joe@nall.com>, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        ewalsh@tycho.nsa.gov, ajax@redhat.com, method@manicmethod.com
Subject: Re: [RFC] X+SELinux performance work
References: <1235752948.3386.53.camel@localhost.localdomain>	 <9F20CFFB-812C-4EDA-9764-3906427D36F6@nall.com> <1235754996.3386.55.camel@localhost.localdomain>
In-Reply-To: <1235754996.3386.55.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric Paris wrote:
> On Fri, 2009-02-27 at 11:12 -0600, Joe Nall wrote:
>> On Feb 27, 2009, at 10:42 AM, Eric Paris wrote:
>>
>>> (sorry for everyone who gets this twice, I misspelled the list address
>>> the first time)
>> That's ok. I enjoyed it just as much the second time.
>>
>>> As a great example of how much selinux is killing X performance ajax
>>> showed me the x11perf -create test.
>>>
>>> ...
>>> Last thing was that translating from raw to whatever looked to be  
>>> taking
>>> up tons of syscalls, open a socket, bind, fail, close over and over  
>>> and
>>> over.  So I added new hook where X can just disable translations
>>> altogether.  What does X care if it has raw strings?  I think as  
>>> soon as
>>> we have things to "display" strings to users they should take care of
>>> translation and just let X internally hand things back and forth the  
>>> way
>>> the AVC can use them.
>>
>> If X is going to call setrans that often, it needs to cache the  
>> result. Even if the cache period is short (60 seconds) it would  
>> dramatically improve performance under load. Especially if you are  
>> making 175000 identical translation requests :)
> 
> It looks like the libselinux code already caches one translation result.
> Seems kinda pointless since a typical permission request is going to
> have at least 2 contexts and a create event is going to have 3.  If
> people aren't keen on the idea of just allow apps to disable
> translations altogether maybe I should make this a better cache?
> 
> -Eric
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
THe caching that was placed in libselinux was more for the case of

ls -lZ /etc

Where the same context would be asked for repeatedly.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmoPXMACgkQrlYvE4MpobPMKACfSlKLc5lSt99+L3uuFq4neamr
2kUAn1Xs56fbe87naV2d3fTREFmGzbxo
=H8g+
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
