Subject: Re: launching apps at level (MLS) and polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Xavier Toth <txtoth@gmail.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <463A4F7C.7000302@trustedcs.com>
References: <463243E3.2060602@gmail.com>
	 <1177700491.3357.113.camel@moss-spartans.epoch.ncsc.mil>
	 <1177700749.3357.116.camel@moss-spartans.epoch.ncsc.mil>
	 <463360B0.7020106@gmail.com>
	 <1177934887.16232.7.camel@moss-spartans.epoch.ncsc.mil>
	 <4636002F.5000100@gmail.com>
	 <1177944754.16232.28.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705020849o3f1b90c4l6f7bb5d9dcbc3c23@mail.gmail.com>
	 <1178125027.3443.67.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40705030611l532d490dr2016dbff69a51628@mail.gmail.com>
	 <1178200148.3443.166.camel@moss-spartans.epoch.ncsc.mil>
	 <1178219938.3443.209.camel@moss-spartans.epoch.ncsc.mil>
	 <463A4F7C.7000302@trustedcs.com>
Content-Type: text/plain
Date: Tue, 08 May 2007 13:54:39 -0400
Message-Id: <1178646879.6056.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-03 at 16:09 -0500, Darrel Goeddel wrote:
> Stephen Smalley wrote:
> > How about the revised patch below (only including the newrole.c and
> > Makefile diffs since the hashtab code is unchanged)?  The changes from
> > your patch are:
> > - Make sure everything is properly enabled/disabled by USE_PAM and move
> > the code into the existing USE_PAM block where appropriate.
> > - Call the config file newrole_pam.conf since there could be other
> > newrole config files in the future.
> > - Distinguish missing config file (ok) from errors during parsing of the
> > config file (should abort).
> > - Remove the Authenticating <username> message since it could be
> > confusing in the case where you are using a pam config that doesn't
> > require it and it doesn't really provide any benefit.
> > - Improve error checking and handling.
> > - Coding style cleanups (indentation, comment style, etc).
> > 
> > To test, I created a /etc/pam.d/newrole-noauth config that had
> > pam_permit.so for its auth module and created
> > a /etc/selinux/newrole_pam.conf that mapped one program to
> > newrole-noauth.
> > 
> > The alternative model would be to eliminate /etc/selnux/newrole_pam.conf
> > entirely from the equation, and just have newrole look for (test via
> > access()) a /etc/pam.d/newrole_<appname> config and use
> > newrole_<appname> as the service name if present.
> 
> I like this idea.  I haven't had a chance to test this yet, but it looks
> to be assuming that the arg to -c is just the command name without any
> path info.  Should we strip that down to its basename in case someone runs
> 'newrole -l secret -c /usr/bin/foo' as opposed to 'newrole -l secret -c foo'?

Actually, on second thought, do we really want that behavior?  IOW, if I
specify "/usr/bin/foo newrole-noauth" in
my /etc/selinux/newrole_pam.conf, then I want "newrole -l s1 --
-c /usr/bin/foo" to use /etc/pam.d/newrole-noauth.  But I don't want the
caller to be able to do "newrole -l s1 -- -c ./foo" and get the same
effect.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
