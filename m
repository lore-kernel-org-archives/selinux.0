Subject: non-Linux behavior
From: Albert Cahalan <albert@users.sourceforge.net>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1072453276.953.89.camel@cube>
Mime-Version: 1.0
Date: 26 Dec 2003 10:41:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
