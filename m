Message-ID: <00d901c361f5$a44cbc40$f800a8c0@cathy>
From: "Dan Anderson" <dtndan@cox.net>
To: <SELinux@tycho.nsa.gov>
References: <E2462F68A99DB74D8AEDF13B261B1BDD02A69594@Larry.widevine.com> <200308131757.18235.joseph_a_nagy_jr@charter.net>
Subject: Re: Linux Wipe Disk Utility
Date: Wed, 13 Aug 2003 18:50:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

----- Original Message ----- 
From: "Joseph A Nagy Jr" <joseph_a_nagy_jr@charter.net>
> Unless I'm mistaken, files on ext3 have their inodes automatically
> zeroed out upon file deletion. If this is the case, the above solutions
> are entirely unneccessary (at least the linux ones).

Inodes are not sufficient (unless ext3 is using really odd terminology,
inodes are essentially just collections of pointers to data blocks), you
need to wipe all of the data blocks, as I recall 3x, once with all 1's, once
with all 0's and once random (or a char and it's complement, and then
random).

My initial thought would be to use dd and /dev/zero, and /dev/random or
something along these lines (although, this would probably not be 100%
(blocks marked bad, and the alternate pool wouls also probably need wiped)).

We used to keep bootable floppies with "flush" on them for this purpose.
Which might suite your needs also.

Dan Anderson


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
