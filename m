Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAUJKWRb003401
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 14:20:32 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAUJJrp5020205
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 19:19:54 GMT
Received: from glaurung.green-gryphon.com (host-12-107-230-171.dtccom.net [12.107.230.171])
	by jazzswing.ncsc.mil  with ESMTP id hAUJJqt0020202
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 19:19:53 GMT
Received: from glaurung.green-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.green-gryphon.com (8.12.9/8.12.9/Debian-5) with ESMTP id hAUJAPRW019517
	for <selinux@tycho.nsa.gov>; Sun, 30 Nov 2003 13:10:27 -0600
To: selinux@tycho.nsa.gov
Subject: Re: Still no authentication from new debian packages
References: <20031125140255.GI2718@vnl.com>
	<20031125205010.GA2174@rom.cip.informatik.uni-muenchen.de>
	<20031125231100.GQ2718@vnl.com>
	<200311261454.14965.russell@coker.com.au>
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Sun, 30 Nov 2003 13:10:24 -0600
In-Reply-To: <200311261454.14965.russell@coker.com.au> (Russell Coker's
 message of "Wed, 26 Nov 2003 14:54:14 +1100")
Message-ID: <87d6b9fza7.fsf@glaurung.green-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 26 Nov 2003 14:54:14 +1100, Russell Coker <russell@coker.com.au> said: 

> On Wed, 26 Nov 2003 10:11, Dale Amon <amon@vnl.com> wrote:
>> > I also appended the line
>> >         session required pam_selinux.so
>> > to /etc/pam.d/{login,ssh}
>>
>> That is worth a look also. But I think Russell might

> That is the right answer.  An updated login or ssh package is no
> longer needed.

> I have to automate this somehow, unfortunately Debian policy
> prohibits interfering with the configuration files of another
> package.  Maybe I'll have to do a diversion.

	I am afraid that diversions of conffiles may also be frowned
 upon.  The best solution I can think of is a NEWS.Debian files, and a
 simple ed/sed/awk/perl utility that helps the sysadmin make these
 changes. (Or create a sample /etc/pam.d/{login,ssh}.selinux set of
 files, and ask the sysadmin to mv them over. Or something.

	manoj

-- 
"Science is to computer science as hydrodynamics is to plumbing." Stan
Kelly-Bootle, _Computer Language_, Oct 90
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024R/C7261095 print CB D9 F4 12 68 07 E4 05  CC 2D 27 12 1D F5 E8 6E
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
