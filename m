Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o45FrP58031805
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 11:53:25 -0400
Received: from mho-02-ewr.mailhop.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o45FqmPi008934
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 15:52:49 GMT
Subject: Re: The confusing dot operator
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Joe Nall <joe@nall.com>
In-Reply-To: <20100414061914.GA21894@myhost.felk.cvut.cz>
Date: Wed, 5 May 2010 10:53:21 -0500
Cc: selinux@tycho.nsa.gov
Message-Id: <B4BA93A9-0C9A-4C43-95A5-46979F2084DF@nall.com>
References: <20100406134846.GO1518@myhost.felk.cvut.cz> <1271185979.9577.62.camel@moss-pluto.epoch.ncsc.mil> <20100414061914.GA21894@myhost.felk.cvut.cz>
To: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Apr 14, 2010, at 1:19 AM, Michal Svoboda wrote:

> Stephen Smalley wrote:
>> mcstransd
> 
> I tried to use this daemon at first but it appeared to require one
> translation line for each possible combination of the categories and
> even ranges of them. For example, on a particular centos 5 machine I
> have to specify
> 
> s0-s0:c0=coreprocess
> s0-s0:c1=webprocess
> s0:c0=core
> s0:c1=web
> 
> Actually the same behavior is illustrated by the default
> 
> s0-s0:c0.c1023=SystemLow-SystemHigh
> s0:c0.c1023=SystemHigh
> 
> confusingly enough, s0 does not equal SystemLow but an empty string.
> 
> I recall reading a presentation (IIRC from a symposium proceeding) that
> would suggest an improvement was planned here, but how far has that
> effort progressed?

A version of mcstrans that can associate bits to words and has considerably
more flexibility is in fedora these days.

http://github.com/joenall/mcstrans

There has been some discussion of moving the master to userspace.selinuxproject.org.

> OTOH I somehow feel safer to have the words 'core' and 'web' stored
> directly in the inode of the disk rather than rely on a run time mapping
> from some generic number. (That's why I don't like unix UID/GIDs too
> much either.)

I disagree. I prefer something on the inode with predictable, portable
mathematical meaning. Adding web/code/fu/bar means that the policy on the
object is dependent on yet another config file/policy because you need
to encode the semantic meaning of those words somewhere. The beauty of the
current approach is that the kernel doesn't have to know word semantics
to do range dominance checks.

joe


> 
> Finally, it would appear that even the most smart mcstransd can't do too
> much about the 'rangeizing' feature. The kernel itself presents c0,c1,c2
> as c0.c2, so mcstrans can only *guess* that there is a c1 in between. Or
> is there a way to query the kernel about the exact list of categories?
> 
>> It also serves a practical end - keeping context string sizes sane for
>> kernel interfaces (/selinux/* and /proc/self/attr/*).
> 
> Does a category length such as 16 characters classify as 'sane' too, or
> is there a noticeable overhead?
> 
>> I think we're open to improvements in this area, but naturally we will
>> need to retain compatibility for the current users of the dot
>> notation.  We have talked in the past about improving direct kernel
>> support for complex label encodings, but unfortunately no one has
>> really moved forward in that space.
> 
> Do you have some pointers to these talks?
> 
> 
> Regards,
> Michal Svoboda
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
