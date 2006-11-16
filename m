MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Multiple small fixes to policycoreutils
Date: Wed, 15 Nov 2006 19:05:27 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C79BC@exchange.columbia.tresys.com>
In-Reply-To: <455B8E56.4070708@mentalrootkit.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "SE Linux" <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> Daniel J Walsh wrote:
> > Joshua Brindle wrote:
> >> Karl MacMillan wrote:
> 
> <snip>
> 
> >>>
> >>> What about a top-level USE_PIE makefile variable that directs all 
> >>> sub-Makefiles to set PIE flags if appropriate for that module? By 
> >>> default it would be off. This gets the behavior you want without 
> >>> having to carry a patch and keeps the current behavior.
> >>>
> >>
> >> No patch necessary, like Chris said make CFLAGS="-fPIE -02 -Werror 
> >> -Wall" LDFLAGS="-pie"
> >>
> >> done and done.
> >>
> > No, because then all compiled apps become -pie.  We only 
> want this on 
> > the daemons.
> > 
> 
> What about this instead?

Why doesn't make CFLAGS="-fPIE -02 -Werror -Wall" LDFLAGS="-pie" work? 
Why does it matter if everything is built pie?

This is distro specific (gentoo completely overrides the CFLAGS and
LDFLAGS, I'm not sure what debian does). I don't think whether or not to
override the user CFLAGS with non-critical things (e.g., things
necessary to build the app like -I($PREFIX)/include) is appropriate for
the upstream makefiles.

For that matter, anyone know why -D_FILE_OFFSET_BITS=64 is in the
override?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
