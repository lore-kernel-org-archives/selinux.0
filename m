Subject: Re: Query about desktop apps.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Gaurav Poothia <gpoothia@cs.sunysb.edu>
Cc: Valdis.Kletnieks@vt.edu, SELinux@tycho.nsa.gov
In-Reply-To: <Pine.GSO.4.53.0603262138250.5076@compserv1>
References: <Pine.GSO.4.53.0603252027240.10215@compserv1>
	 <200603260351.k2Q3paAS022578@turing-police.cc.vt.edu>
	 <Pine.GSO.4.53.0603262138250.5076@compserv1>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 09:25:41 -0500
Message-Id: <1143469541.22696.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-03-26 at 22:14 -0500, Gaurav Poothia wrote:
> I still dont see it. I assume that there is a vi specific domain to which
> both both sys admin and regular user will have to transition. In which
> case there should be 2 vi domains one for admin and other for regular
> users and thus 2 policies. Please remember my question is about ANY
> desktop app and vi is just an example.

A few quick points:
- SELinux already supports and includes "derived domains", where you
instantiate a separate domain for the program per caller domain, e.g.
user_mozilla_t vs. staff_mozilla_t, so that you can allow each instance
appropriate permissions to e.g. home directory files, tty/pty, etc. of
the right type without allowing the ordinary user's browser to interfere
with the staff user's browser.
- vi is a bad example here, as it lacks a well-defined purpose (and
hence set of permissions) and it ultimately can do everything (e.g. run
commands in sub-shells), so it is difficult to write a meaningful policy
just for it.  Hence, it presently just runs in the caller's domain, as
Valdis noted.  However, one could create various domains for
well-defined purposes, and the user could invoke vi via a suitable
wrapper or via runcon -t to force it into an appropriate domain for a
given purpose (e.g. editing system config files vs. personal files).
There is already precedent for such wrappers in e.g. vipw, vigr.
- Ultimately, we would like to devolve many of the permissions currently
granted directly to the base user domain into more specific program
domains.   But this will require time and always requires acceptance by
users.

> Yes I dont want the regular permission model, I wanted MAC.
> I do agree that solution will work.Although it seems to me that the
> policy needs to be aware of the users. Thats not very scalable.

It needs to be aware of user roles, but not per-Linux user.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
