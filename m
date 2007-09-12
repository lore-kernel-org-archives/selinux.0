Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CDwuSs026476
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 09:58:56 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8CDwr0x015461
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 13:58:54 GMT
Message-ID: <46E7F05A.7070307@redhat.com>
Date: Wed, 12 Sep 2007 09:57:46 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: concept of a permissive domain
References: <1189537981.3407.51.camel@localhost.localdomain>	 <46E6FB25.5070507@redhat.com>	 <1189545987.4823.6.camel@localhost.localdomain>	 <1189547256.3407.57.camel@localhost.localdomain> <1189603642.3555.7.camel@localhost.localdomain>
In-Reply-To: <1189603642.3555.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl MacMillan wrote:
> On Tue, 2007-09-11 at 17:47 -0400, Eric Paris wrote:
>> On Tue, 2007-09-11 at 17:26 -0400, Karl MacMillan wrote:
>>> On Tue, 2007-09-11 at 16:31 -0400, Daniel J Walsh wrote:
>>> [...]
>>>> One other feature/requirement would be to not override dontaudit rules.
>>>> So if I have a domain in permissive mode and I have a dontaudit rule  on
>>>> reading /etc/shadow.  The app should still be denied reading
>>>> /etc/shadow.  (This is not a show stopper, but would allow us to force
>>>> apps to take the code paths they will take in enforcing mode.)
>>> This isn't specific to per-domain permissive, right? It would be useful
>>> in general for permissive.
>> You know, I'm quite happy that setenforce=0 ALWAYS means 'not selinux
>> fault'   not sure I'm comfortable with changing that, although I have no
>> problem with dan's suggestion....
>>
> 
> Well, there are very rare circumstances where permissive can still cause
> problems, but your general point is well taken.
> 
> Karl
> 
I agree, the precedence has been set, so I think we need to leave
setenforce 0 as is.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG5/BZrlYvE4MpobMRAp4hAKC+Agh5M+6stj+8OPTi0G1i1iy1BACglHMO
PVW9eHNHj9ww+VMXTG/N0nY=
=zoo4
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
