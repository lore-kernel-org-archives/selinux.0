Date: Sat, 25 Mar 2006 21:29:11 -0500 (EST)
From: Gaurav Poothia <gpoothia@cs.sunysb.edu>
To: SELinux@tycho.nsa.gov
Subject: Query about desktop apps.
Message-ID: <Pine.GSO.4.53.0603252027240.10215@compserv1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi I am wondering how SELinux intends to handle desktop apps.
With daemons I understand SELinux restricts access to parts of the
filesystem which the application (almost always running as root) needs to
performs its job.

With a desktop app which is an editor (of any type, text/images
etc), its not clear how SELinux intends to restrict access to some
"safe" part of the filesystem.

Consider this problem: Superuser runs vi and decides to look at the
contents of the shadow file versus regular user decides to try his luck
and open it using vi.
MAC will allow former and deny latter.
To do this we are gonna need 2 different vi domains one belonging to the
role system_r and the other belonging to role user_r each with their own
policies.

Q1. Is the there a need for 2 different policies for an app like vi or is
there something I am missing?


Additionally it seems to me that we need a way for the regular users vi
policy to prevent him from overwriting other user's data (that probably
a solvable problem given the constructs,)

Q2. How do you make an app like vi when invoked by a regular user stick to
that particualar user's data?

Q3More importantly how do you prevent a malicious vi binary from modifying
any of the users own file on the sly (afterall the user can use vi to
modify ANY of his files, so no
policy should really stop vi from doing so)


Thanks in advance,
Gaurav

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
