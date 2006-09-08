Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k88C6BcX015714
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 08:06:12 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k88C5K4V018440
	for <selinux@tycho.nsa.gov>; Fri, 8 Sep 2006 12:05:22 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Joshua Brindle" <jbrindle@tresys.com>
Subject: Re: [RFC] SELinux and PostgreSQL
Date: Fri, 8 Sep 2006 22:05:57 +1000
Cc: "James W. Hoeft" <Jim@MagitekLtd.com>,
        "KaiGai Kohei" <kaigai@kaigai.gr.jp>, selinux@tycho.nsa.gov
References: <6FE441CD9F0C0C479F2D88F959B015883C163D@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015883C163D@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609082206.02747.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 September 2006 12:10, "Joshua Brindle" <jbrindle@tresys.com> 
wrote:
> > I'm confused. Password column is a good example - let's say
> > the password column is labeled at top secret, then how can a
> > secret user create a new row? I would assume a password would
>
> Well, first of all a secret user can write a top secret column but I
> think I know what you meant..

Yes, in the MLS side of things the user can write-up (limited to the high 
level of their range unless there is an attribute on either the domain or the 
type to allow going higher).

But if you have the password labeled with a restrictive type (something 
equivalent to shadow_t) then it becomes a little more tricky.

> > be required, but that either means a secret user cannot read
> > or cannot write (or can't do either). If that's not the case,
> > then does that mean the row can be created without a
> > password? In which case, does that mean only top secret users
>
> Probably a trusted stored procedure that has a higher level of access
> would be used

Or a trusted SQL client program.  When considering ways of improving the 
security of database backed web sites my best ideas involved having multiple 
programs doing database access with different contexts.

For example the PHP script that wants to delete a topic might run a program 
that takes the user-name and password for the database connection on stdin 
(which would be used to validate the user's rights to delete the topic), and 
command-line parameters to specify the forum and topic to be deleted.  That 
way someone who cracks part of the forum software would only be able to 
delete topics that their UID is permitted to delete.

Also for database access I think we want permission for a trusted connection 
manager to perform connections on behalf of other contexts.  So we need to be 
able to specify in policy that domain foo_t can connect as bar_t and maybe 
permit range transitions too.  I expect this to be controversial.  But a very 
common need for database security is where you start with a front-end process 
that runs under the same context for all users.  There are several places 
where the privileges for different users can be separated, the database 
connection is one of them.

> > I would also think multiple security queries per database
> > query would present a significant performance hit (but then
> > again, that may be the price we have to pay for the added security).
>
> Many of the lookups are already going to be done (eg., table, column DAC
> permissions) and the AVC is pretty fast, I don't think the hit will be
> significant but I'd be very willing to find out..

I agree.  Lots of database operations can be CPU intensive, SE Linux checks 
with the AVC in user-space should not be a factor in overall performance.

Security Enhanced X is where we will have difficulty in delivering 
performance.

-- 
http://etbe.blogspot.com/          My Blog
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
