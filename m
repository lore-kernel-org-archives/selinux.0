Date: Mon, 17 Dec 2001 07:36:37 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Dale Amon <amon@vnl.com>
cc: <SELinux@tycho.nsa.gov>
Subject: Re: No consistancy in Make variable names
In-Reply-To: <20011216032408.GA9250@vnl.com>
Message-ID: <Pine.GSO.4.33.0112170731470.10438-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 16 Dec 2001, Dale Amon wrote:

> The biggest difficulty I'm having is a lack of
> consistancy in labeling. DESTDIR means one thing
> in one of the makefiles and something entirely
> different in another.
>
> It really would be a good idea to clean up this
> nomenclature.

This isn't a priority for us, but we'll gratefully accept patches to make
the Makefiles consistent.  While you can freely modify the Makefiles that
are completely "new" in SELinux, you should seek to minimize changes to
the Makefiles for the modified daemons and utilities, since we would like
to keep the patches against these packages small and to the point.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
