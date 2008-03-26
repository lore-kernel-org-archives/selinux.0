Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2Q5CPVf012796
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 01:12:26 -0400
Received: from nospam.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2Q5CMEq005026
	for <selinux@tycho.nsa.gov>; Wed, 26 Mar 2008 05:12:23 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Stone <mstone@debian.org>
Subject: Re: Bug#472590: ls in Debian/Unstable
Date: Wed, 26 Mar 2008 16:12:15 +1100
Cc: Jim Meyering <jim@meyering.net>, 472590@bugs.debian.org,
        "SE-Linux" <selinux@tycho.nsa.gov>
References: <200803251523.34329.russell@coker.com.au> <200803260824.17731.russell@coker.com.au> <20080325234310.GR2626@mathom.us>
In-Reply-To: <20080325234310.GR2626@mathom.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803261612.18018.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 26 March 2008 10:43, Michael Stone <mstone@debian.org> wrote:
> On Wed, Mar 26, 2008 at 08:24:15AM +1100, Russell Coker wrote:
> >Should there be some special marking of files with both a SE Linux context
> > and an ACL?
>
> (not cc'ing the closed selinux list again)

What is the problem with the list?  Are your messages bouncing?

You should expect that your messages will be delayed until business hours in 
the east coast of the US (unless someone is working on the weekend), but 
that's not really a problem.

> How much can you fit into one char before it gets confusing?

Character 10 in "ls -l" output can have values from "xtT", character 7 can 
have values from "xsS", and character 1 can have many values.

> As I 
> understand it, there can't be a case on an selinux system where you have
> an acl and not an selinux context--so why bother highlighting the case
> where you have both?

On a SE Linux system you can't have a file without a SE Linux context.  
Therefore the issue is whether you have an ACL or not.  Which is why I 
believe that having "+" or " " is a reasonable choice.

If that idea is not well regarded by the people who matter then I am not 
really bothered as long as something better than the current situation is 
chosen and implemented before Lenny freezes.

> If people really want something for that, fine, but 
> I suspect that the ls listings will be come unreadable in short order if
> that trend continues.

Actually I'm more worried about the ease of machine parsing of ls output.  I'm 
sure that someone will suggest a better option than having a shell script 
grep ls output, but there are a lot of people who are used to grepping ls 
output and it would be nice not to break things for them.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
