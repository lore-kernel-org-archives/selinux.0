Subject: Re: End User Mailing List / Group
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Erich Schubert <erich@debian.org>
Cc: James Morris <jmorris@namei.org>,
        "Randal T. Rioux" <randy@procyonlabs.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1144067579.22768.3.camel@wintermute.xmldesign.de>
References: <442B182D.9060104@redhat.com> <442B7848.8060406@hotmail.com>
	 <4430AABF.5000301@procyonlabs.com>
	 <1144067579.22768.3.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 09:52:28 -0400
Message-Id: <1144072348.9028.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-04-03 at 14:32 +0200, Erich Schubert wrote:
> Hi,
> I've done that split for the Debian SELinux lists, but these are pretty
> much no-traffic lists so far.
> In my personal opinion, SELinux isn't end-user ready yet (or not
> anymore, it was when we were still using the old policy). Too many
> pitfalls (module linking not yet working entirely right, so you need to
> put everything in base you want) and way too little documentation.

Support for a modular base policy didn't exist at all in old policy - it
hadn't been invented yet ;)  So no regression there.  And the breakage
in the modular policy support is only for optionals-in-base, which
wasn't part of the original design and implementation.  Documentation
for the new support is improving, contributions welcome.

On the end user mailing list question, I'm not sure it would have much
life isolated from the distribution-focused lists and from the upstream
developers list.  Most end users will deal with SELinux through their
particular distributions, as integrating SELinux does take work and is
difficult to maintain long term outside of the main packages of a
distribution.  If there is a real demand for such a list, possibly it
could be created on a community site like selinuxnews.org.   But I'm not
sure if there is a such demand presently.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
