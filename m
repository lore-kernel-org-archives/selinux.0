Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i52Cm0rT003977
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 08:48:01 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i52KgVbn017270
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 16:42:31 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 2 Jun 2004 12:47:57 -0000
Date: Wed, 2 Jun 2004 12:45:23 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: tridge@samba.org
Cc: Volker.Lendecke@sernet.de, Samba-Technical <samba-technical@samba.org>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: se-samba
Message-ID: <20040602124523.GA3708@lkcl.net>
References: <20040529095153.GB16927@lkcl.net> <200405312249.11522.rcoker@redhat.com> <16571.47722.750708.219840@samba.org> <20040531232931.GE8312@lkcl.net> <1086081794.3268.39.camel@localhost.localdomain> <20040601110924.GE8312@lkcl.net> <1086096477.3268.63.camel@localhost.localdomain> <20040601133547.GU8312@lkcl.net> <E1BV9Yp-0002wU-00@intern.SerNet.DE> <16573.1058.707078.949935@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16573.1058.707078.949935@samba.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

just wanted to correct some things and also to apologise for having a
bad memory.

now that i recall that it is the SMBsessionandX that needs to be
de-multiplexed (not the SMBtconX unless, like as tridge says,
the SMBsesssetupX is skipped as with share-level security) i should
make this clear.

however, my faulty memory, has, i believe, no impact on the
solution: the solution remains the same (albeit slower than
it could be, and clumsy).


under which circumstances, yes, tridge is right: 1) the TconX
behaviour is irrelevant (for seteuid()) and 2) the present
samba(4) SMB client NT-VFS plugin's behaviour is less than ideal
(in that it creates new tcp connections for every single TconX
as _well_).

... but it will work, and provide the required security semantics.

in the back-end se-samba(3) all that should be required is to run
pam_selinux.so.  and the front-end se-samba(4) just use the new
proxy plugin.


at a later date, improvements in the SMB NT-VFS proxy plugin can
be made (see cliffs or samba tng libsmb code for example, somewhere,
i promise!, of modified libsmb which can do multiple tconXes over
a single TCP connection).

l.

On Wed, Jun 02, 2004 at 08:33:06AM +1000, tridge@samba.org wrote:
> Volker,
> 
>  > It's a), everything is done via a single tcp connection. One reason is that we
>  > want to mirror the behaviour that the server we proxy towards gives us as
>  > closely as possible. Separate smb connections give a difference that might have
>  > influence on the server's behaviour.
> 
> Nope, the we open a new connection for each tree connect in that
> backend.
> 
> It really doesn't matter though, as unless I have completely
> misunderstood se-linux, the TConX behaviour is completely irrelevant
> for the seteuid() problem that se-linux faces. All TConX does is
> establish a connection to a new directory (ignoring ancient share
> level security setups).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
