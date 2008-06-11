MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MLS constraint interfaces
Date: Wed, 11 Jun 2008 14:01:13 -0400
Message-ID: <D709A20F2164C84E8B7014B0301F5EF8012E8312@HAVOC.tcs-sec.com>
References: <cadfc0e40806091430j7d4734c6l7af3cfbce395eeae@mail.gmail.com> <D709A20F2164C84E8B7014B0301F5EF8012E7F32@HAVOC.tcs-sec.com> <484FD5B9.1010302@gmail.com>
From: "Chad Hanson" <chanson@TrustedCS.com>
To: "Ted X Toth" <txtoth@gmail.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>
Cc: "Eamon Walsh" <ewalsh@tycho.nsa.gov>, "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Our initial MLS design and implementation kept things at the same level
of granularity as previous MLS implementations. SELinux is far more
granular and could support class specific MLS "privileges". TE policy
can help prevent unintended use of the "privilege" since a policy may
not permit write access to etc_t:s0, even though you have MLS write
access running at s1 (from the mlsfilewrite attribute).

If we wanted to be more granular in the class specifications, we would
need to create the specific interfaces and adjust the MLS constraint
file accordingly. If you have patch, we can review it. (I'm going to be
unavailable for a little over a week starting on Friday).

-Chad

> As I said in another post I've added mls interface calls to deal with 
> these constraint violations. However I'm concerned about the 
> breath of 
> the interfaces in that they cover many classes/types of files when as 
> far as I know the X server really only needs multilevel access to 
> 'chr_file'. Should there be more class specific interfaces?
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
