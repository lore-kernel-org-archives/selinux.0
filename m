Subject: dumb newbie questions
From: "R. Steven Rainwater" <srainwater@ncc.com>
To: SELinux@tycho.nsa.gov
In-Reply-To: <20050618153949.72823.qmail@web51502.mail.yahoo.com>
References: <20050618153949.72823.qmail@web51502.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1119137931.11593.53.camel@rodan.ncc.com>
Mime-Version: 1.0
Date: Sat, 18 Jun 2005 18:38:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just installed CentOS 4.1 on a box and have run into what I think
are selinux related issues. (CentOS is basically a renamed RedHat
Enterprise Linux). 

I moved all the files for an existing Apache website to the new server
including a variety of Perl programs and Perl CGI scripts, all of which
have been working fine for a year on a Red Hat 9 box. Some of these
scripts worked fine on the new box but others failed to run at all.
After spending hours trying to debug the problem, I wrote a simple one
line Perl program like so:

#!/usr/bin/perl
print "hello\n";

I would think a script this simple shouldn't fail to run in any normal,
functional environment but - it failed to run. This was all the more
baffling because some of the scripts that do run do little more than
print a few lines to stdout. After another hour or so of poking around
it finally occured to me to check the message log (should've done that
first!) and I discovered the source of the problem. Lots of cryptic
entries like this:

kernel: audit(1119056704.257:0): avc: denied { read write } for pid=3020
comm=test.pl path=/dev/pts/0 dev=devpts ino=2
scontext=root:system_r:httpd_sys_script_t
tcontext=root:object_r:devpts_t tclass=chr_file

I tried everything I could think of. Regardless of permissions, owners,
or what user I run them as (even root!) the scripts continued to not
run. 

I found and read several FAQs on selinux but most of them seem to be
written with the assumption that I already know a bunch of selinux
terminology - roles, contexts, type enforcement, domain transitions,
etc.

As best I can tell so far, each time I add a new program to the server
I'm going to have to do something to selinux to allow the new program to
run (except that maybe sometimes I don't because some of the scripts I
moved over work fine?).

Is there any chance someone can answer two dumb questions without using
a lot of selinux jargon (or point me to a document that can do this):

1. Why would some of my scripts run and some not - they're all pretty
much the same, they all do file I/O, print to stdout, a couple access an
SQL server on another box. But I can't find anything common to the ones
that don't work. I realize this might be hard to answer without seeing
the code but I'll take even a theory at this point.

2. How do I get a new scripts or program to run? One FAQ came near to
answering this but was incomplete. It said I should run the offending
program, then extract the warning line from the messages file and run it
through a program called audit2allow. Audit2allow seems to need an input
file so I copied one of the warning lines from the log into a text file,
test.txt, and did this:

audit2allow test.txt

The result message from audit2allow was "allow httpd_sys_script_t
devpt_t:chr_file { read write };". The "allow" sounded hopeful but when
I tried to run my script again it still didn't work. So I think there
must be some additional step that was left out of the FAQ. Any
suggestions appreciated.

-Steve



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
