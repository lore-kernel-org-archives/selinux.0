Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0DK1Crj031787
	for <selinux@tycho.nsa.gov>; Sat, 13 Jan 2007 15:01:12 -0500
Received: from web36615.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0DK23OK025953
	for <selinux@tycho.nsa.gov>; Sat, 13 Jan 2007 20:02:04 GMT
Date: Sat, 13 Jan 2007 12:01:48 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
To: russell@coker.com.au, casey@schaufler-ca.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200701132013.04807.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <534132.51731.qm@web36615.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Russell Coker <russell@coker.com.au> wrote:


> Do "most" systems have a copy of MV that preserves
> MAC attributes (and 
> therefore is a privileged process)?  Or are you just
> referring to the case of 
> moving files within a filesystem?

The "desired" behavior (mv retains, cp resets)
is an artifact of the behavior of the underlying
system calls used to implement the commands,
and nothing more. There has always been tension
around the behavior of mv when two file systems
are involved. Doing a link and an unlink has no
effect on the attribues of the file beyond a
brief increase in the link count, so mv "ought"
not need to worry about mode bits, ACLs, MAC
labels, or much of anything. When mv devolves
into a cp and an rm preserving the illusion of
the same file system behavior is hard,
especially when "the community" can't agree on
what attributes matter.

> I can imagine the benefits in having mv and cp
> preserve the context of files, 
> and it shouldn't be difficult to implement.

Remember the rule: mv acts as if you did rename.
cp acts as if you created a new thing with the
same contents as the old one.

As for what MLS systems have done, mv needs no
attention on the local file system and relies
on cp behavior off file system. cp makes a copy
with the user's attribute settings. Some have
tried to make mv off local attempt to do its
best to retain attributes, but always leave the
failure to do so a possibility.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
