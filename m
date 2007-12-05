Subject: Re: libsemanage patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Todd Miller <Tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <47546BE8.4010201@redhat.com>
References: <4754599A.8060605@redhat.com>
	 <6FE441CD9F0C0C479F2D88F959B0158801455C46@exchange.columbia.tresys.com>
	 <1196711592.27820.133.camel@moss-spartans.epoch.ncsc.mil>
	 <47546BE8.4010201@redhat.com>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 12:48:07 -0500
Message-Id: <1196876887.16006.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-12-03 at 15:49 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Stephen Smalley wrote:
> > On Mon, 2007-12-03 at 14:51 -0500, Todd Miller wrote:
> >> Daniel J Walsh wrote:
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA1
> >>>
> >>> genhomedircon includes the "\n" in /etc/shells so no shells in the
> >>> /etc/passwd match.
> >> Isn't this going to cause problems if the last line in /etc/shells has
> >> no newline?
> >>
> >> Instead of:
> >>     temp[strlen(temp)-1]=0;
> >>
> >> I would use:
> >>     temp[strcspn(temp, "\n")] = '\0';
> >>
> >> That will overwrite the first newline with a NUL or, if there is no
> >> newline, the terminating NUL will be overwritten with another NUL, which
> >> is harmless.  It is a useful idiom...
> > 
> > Given that getline() returns the length read (not to be confused with
> > the buffer length), why not just:
> > 	while ((len = getline(&temp, &buff_len, shells)) > 0) {
> > 		if (temp[len-1] == '\n') temp[len-1] = 0;
> > 
> Second try.

Merged with two changes (type on len => ssize_t, assert on store_path
after strdup so that we don't continue if allocation fails).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
