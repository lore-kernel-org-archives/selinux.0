Subject: Re: How can modular policy ever have worked? [patch]
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: sds@tycho.nsa.gov, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1142867787.6145.18.camel@wintermute.xmldesign.de>
References: <1142691657.4017.23.camel@wintermute.xmldesign.de>
	 <1142865553.16487.21.camel@moss-spartans.epoch.ncsc.mil>
	 <1142867787.6145.18.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 11:57:54 -0500
Message-Id: <1142873874.20739.54.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-20 at 16:16 +0100, Erich Schubert wrote:
> Any progress on the optional{} in base.pp issues?
> I have the impression that type attributes are broken; for example
> almost all (I can't say for sure, apol doesn't work for me; is there any
> other "policy decompiler"?) the restorecon_t relabelto rules are
> missing, which are defined for file_type.
> So I have the impression that when linking the base policy with
> optionals, these attributes are messed up.

I'm working on it right now.  It requires other changes, as you get
situations like this:

optional {
	require {
		type foo_t;
	}
	...
}

	type foo_t;

which results in an duplicate declaration (if this should be considered
a duplicate declaration is a different discussion).  There is some
sed'ing to move type declarations above, but it doesn't catch
declarations that don't start at the beginning of the line (like types
declared by templates), but if we allow whitespace before the type
declaration, we need a smarter sed script to skip over the ones in
require blocks (already written).  But the gen_require() isn't expanded
until m4 is run (current sed'ing happens before m4), so we have to push
the m4 to before the sed.  So the build has to be changed to run m4 on
the individual modules, which should have the added effect of making
compiler errors useful again.

Sorry for the stream of consciousness :)  Thats where it stands now;
right now I'm working on moving the m4 invocation.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
