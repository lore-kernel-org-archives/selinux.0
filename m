Date: Mon, 29 Dec 2003 10:34:21 -0700
From: "Loughry, Joe" <joe.loughry@lmco.com>
Subject: RE: non-Linux behavior
To: Albert Cahalan <albert@users.sourceforge.net>, SELinux@tycho.nsa.gov
Message-id: <835AD41BA2589F49A8A34117D4C421DF02CA1E80@EMSS02M15.us.lmco.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I can help out with Trusted Solaris.  Which of the following versions
would you like?

Trusted Solaris 8 HW 7/03 (beta, not yet released)
Trusted Solaris 8 HW 12/02 (with current patches)
Trusted Solaris 8 4/01 (with current patches)
Trusted Solaris 2.5.1 (with current patches)

- -Joe

- -----Original Message-----
From: owner-selinux@tycho.nsa.gov
[mailto:owner-selinux@tycho.nsa.gov]On
Behalf Of Albert Cahalan
Sent: Friday, 26 December, 2003 08:41
To: SELinux@tycho.nsa.gov
Subject: non-Linux behavior


I've been adding SE Linux support to procps.
The 3.1.15 release supports "--context" when
run on a 2.6.0 kernel. (http://procps.sf.net/)

I need some help. One of my goals is to be
mostly compatible with both UNIX and BSD.
I'm looking for people willing to try out
security-related ps options on high-security
systems. Better yet would be a trial account.

I'm interested in whatever systems commonly
in use or are likely to be of importance.
I guess that means: Trusted IRIX, Cray's OS,
Trusted Solaris, FreeBSD with LOMAC, and
probably stuff from IBM or HP. Anything else?
If you'd like Linux compatible with whatever
it is you've been using, speak now.

For those who can help only by typing commands
themselves, feel free to change command names
to "[x]", "x", or "x x" as appropriate. (I need
to know if args are shown or if brakets are used)
The same goes for user names, etc.

I'd like to have output from at least:

ps -Z
ps -flZ
ps -Zlf
ps -ZelfLyPcj  (all the options you can do)
ps Z

Then again, replacing the 'Z' with 'z'.
Then again, this time with 'M'.
Then again, this time with 'x'.
Then again, this time with 'C'.
And so on, for every security-related option...

Plus this one:

ps -zMZ  (all available security options at once)

The goal here is to determine column width,
column order, interactions between options, etc.



- --
This message was distributed to subscribers of the selinux mailing
list.
If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5.8
Comment: Lockheed Martin Space Systems

iQA/AwUBP/BlnecUeovsi/gzEQIcRQCfammALYgcz5BeS8hXJ0XbpGvvK3gAn0+j
Bc7shb3HqcKQyqUZjQmd/ymg
=kAGI
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
