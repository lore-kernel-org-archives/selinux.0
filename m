Message-ID: <001c01c12527$610738a0$020144c0@windows>
From: "Eric Peters" <eric@peters.org>
To: "Stephen Smalley" <sds@tislabs.com>
Cc: <SELinux@tycho.nsa.gov>
References: <Pine.SOL.3.95.1010814081547.15893C-100000@clipper.gw.tislabs.com>
Subject: Re: SE Linux II?
Date: Tue, 14 Aug 2001 18:12:36 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there an anonymous CVS server available for download?

This question is a little out of blue I suppose, but i'm looking to
hopefully setup a system of directory permission access so I can have:

/home/user1
/home/user1/subuser1
/home/user1/subuser1/subuser1subuser1
/home/user1/subuser1/subuser1subuser2
/home/user1/subuser2

Type of heirachy where the user1 can access everything under his
/home/user1, subuser1 can access everything under his subuser1 home
directoyr, and subuser2 acccess to his directory and etc.

Would something like this be implemented out of the box with SELinux, or
could I potentially modify SELinux with relative ease to accomplish this
type of access.  basically I want the "controlling" account "user1" to be
able and access any "subuser1", "subuser2" files, where "subuser1" also has
access to his child accounts "subuser1subuser1", and "subuser1subuser2"
(user1 could also access these/his "children's"-"child" accounts)

Thanks I appreciate all your time,

Eric

----- Original Message -----
From: "Stephen Smalley" <sds@tislabs.com>
To: "Eric Peters" <eric@peters.org>
Cc: <SELinux@tycho.nsa.gov>
Sent: Tuesday, August 14, 2001 5:20 AM
Subject: Re: SE Linux II?


>
> On Mon, 13 Aug 2001, Eric Peters wrote:
>
> > Is there really any ETA on this release?
>
> I'm afraid that it is out of my hands.  We're currently blocked for
> bureaucratic reasons rather than technical ones.  I expect that it
> will occur within a week, but then again, it was supposed to happen
> before the end of the July.  We're now working off of the lsm-2001_08_12
> patch against kernel 2.4.8 from lsm.immunix.org.
>
> > hopefully at that point be more "upgradeable" without excessive kernel
> > recompiles correct?)
>
> Well, sort of.  The LSM kernel patch is itself still under
> rapid development.
>
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
>
>
>
>
>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
