Message-ID: <43568CE4.4030901@unify.com>
Date: Wed, 19 Oct 2005 11:13:56 -0700
From: Ron Kuris <rk@unify.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Loading things into policy
References: <43559474.1080905@cornell.edu> <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil> <43568C6E.5040106@cornell.edu>
In-Reply-To: <43568C6E.5040106@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ivan Gyurdiev wrote:

>>> add() - add a new thing, or fail if it exists (maybe add a
>>> configurable parameter saying whether we should fail, or only
>>> warn if it exists) modify() - add a new thing, or modify it if
>>> it exists
>>>
>>> In addition, I'm thinking of adding: set() - modify a thing,
>>> but don't add it if it doesn't exist (for booleans).
>>>
>>
>>
>> add() and set() as described above seem to be fundamental
>> primitives; modify() seems optional as it can be constructed by
>> the caller from the other two, i.e. if (add() < 0 && errno ==
>> EEXIST) { set(); }.
>>
>
> I plan to support those functions in all databases: Now, make add()
> take O(n) time, make set take O(n) time, and you're most likely
> taking twice as much time in modify() as you should be. Yes, I
> agree it's optional, but it's still useful to have... just like
> iterate() and list() can be implemented on top of each other
> (though iterate() over list() is a much worse idea than list() over
> iterate()).

Another interesting point is that your pseudo-code suffers from a race
condition: what if two processes try to add() at the same time?

Ron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDVozkVkC/44kdyuYRAmetAKDXOnQYpFQXEPe9INwWigoZ8D6uiACeLDQM
0A6ZMw89JEpm5l/h9DFATtU=
=yY0K
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
