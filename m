Subject: Re: su vs runuser
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ted Toth <txtoth@gmail.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <CAFPpqQEqJChweFaz-HyKVoUeBoL4ibER-dz=+p-FKYczyEFBKg@mail.gmail.com>
References: 
	 <CAFPpqQEqJChweFaz-HyKVoUeBoL4ibER-dz=+p-FKYczyEFBKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Aug 2011 11:09:01 -0400
Message-ID: <1313593741.28571.36.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-08-17 at 09:30 -0500, Ted Toth wrote:
> I've read that I should use runuser instead of su and I was having a
> problem getting a script to transition properly until I changed it to
> use runuser but I'm not clear on why this is. Can someone help me with
> an elevator speech that I can use when trying to explain this to
> others?

runuser runs in the same uid (i.e. it is not setuid-root) and security
context as the caller - it isn't a trusted application.  It can only be
used if the caller is already privileged.  It never requires
authentication, and thus can be easily used in non-interactive scripts.

su is a setuid-root program that typically runs in a different security
context than the caller so that it can read user authentication secrets
(/etc/shadow) and switch identities even if the caller can't directly do
so.  Early versions of Fedora/RHEL also put pam_selinux
into /etc/pam.d/su, causing it to explicitly switch to the new user's
security context, but that was later removed.  But even without that,
there is a security context transition when you invoke su (to enter su's
domain so that you can read /etc/shadow and switch uid) and when su
invokes the user shell or command (to transition back to the original
caller's domain).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
