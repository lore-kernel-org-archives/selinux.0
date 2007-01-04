Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l04H63et012677
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 12:06:03 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l04H6hVJ022773
	for <selinux@tycho.nsa.gov>; Thu, 4 Jan 2007 17:06:44 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: casey@schaufler-ca.com
Subject: Re: Latest diffs
Date: Fri, 5 Jan 2007 04:07:10 +1100
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <150714.60836.qm@web36610.mail.mud.yahoo.com>
In-Reply-To: <150714.60836.qm@web36610.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701050407.14369.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 05 January 2007 03:47, Casey Schaufler <casey@schaufler-ca.com> 
wrote:
> If noone is eager to make locate MLS
> cognizant there's always the option of
> polyinstantiating /var/lib/mlocate and running
> multiple updatedb's. Whichever (if either)
> scheme is best in keeping with the overall
> SELinux application philosophy ought to serve
> fine.

Having multiple copies of /var/lib/mlocate for each of s0..s15 might be 
viable, even if a separate "find /" is run for each.

Multiple copies of it for each of the 2^1024 category combinations isn't an 
option.  Multiple copies of it for each of the levels defined by "semanage 
translation" might be viable but it would involve some pain.

Could we have a version of locate that is a little slower than usual and which 
just calls find without telling the user?  :-#

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
