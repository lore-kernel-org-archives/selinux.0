Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0IJTEO7016076
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 14:29:14 -0500
Received: from web36615.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0IJU8ih006323
	for <selinux@tycho.nsa.gov>; Thu, 18 Jan 2007 19:30:08 GMT
Date: Thu, 18 Jan 2007 11:30:03 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Current/Future Plans to Support Stacking LSM Modules
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
In-Reply-To: <20070118185030.GB10975@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <629629.87353.qm@web36615.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- "Serge E. Hallyn" <serue@us.ibm.com> wrote:


> > Funny thing is that I would agree with you 100%
> > if LSM implemented authoritative hooks. Since
> > LSM implements a scheme that is supposed to
> > provide strictly for additional restrictions
> > it should be simple to stack modules safely.
> 
> An example where that is not the case is if LSM 2
> needs to label
> a file as 'toptopsecret noone may touch this', but
> LSM 1 has
> marked claimed that the user may not write an xattr.
>  So now
> the user's info can be leaked.

This is only an issue if LSM 2 puts "toptop..."
data into the file prior to setting the label
on the file, which I would argue ought not
happen. If you're refering to the case where
someone discovers toptop... data in an existing
'sure go ahead everyone read this' file and
they want to relabel it I say that the described
behavior is, however unfortunate, correct. There
have been sucessful MLS systems on which users
were not allowed to relabel files.

If an LSM is correct within its own rules,
such as the MLS reality that the container
has to be labeled before the data goes in,
and that the creation would fail if it
couldn't live up to its rules, the situation
described will not be a security problem.
It will be a operational problem, and the
admin who decided that she wanted both
mechanisms may have a tough choice, just
as she does when she puts too many layers
of spam filtering in place and nothing from
lkml gets through anymore.

Reminds me of changing planes at Heathrow,
where half the people had too much luggage
to go through security, but had already
gone through once at the previous airport.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
