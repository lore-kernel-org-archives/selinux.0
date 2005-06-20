Message-ID: <a1025d74050620061231e65d7d@mail.gmail.com>
Date: Mon, 20 Jun 2005 09:12:37 -0400
From: Trevor Vaughan <peiriannydd@gmail.com>
Reply-To: Trevor Vaughan <peiriannydd@gmail.com>
To: "R. Steven Rainwater" <srainwater@ncc.com>
Subject: Re: dumb newbie questions
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1119137931.11593.53.camel@rodan.ncc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050618153949.72823.qmail@web51502.mail.yahoo.com>
	 <1119137931.11593.53.camel@rodan.ncc.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Steven,

I'm also relatively new to the SELinux game and have run into some
similar PERL + Apache quirks.

Basically, it looks like you have a PERL script running from within
the Apache context (i.e. run by Apache) and the script is attempting
to write to a character device, probably the terminal (as mentioned in
a previous post).

The rule that you generated with audit2allow will work but you REALLY
need to think about whether or not you need to give Apache RW access
to the terminal.

Try this:

1. Run the script from your home directory as a normal user. (This should work).
2. Write a PERL script, to be run from within Apache, that writes a
file that is inside the web directory (whatever that may be on your
system, probably /var/httpd/htdocs or the like).  (This should work
since it is within the httpd system space.)

Also, are you running in strict or targeted mode?  It sounds like
targeted mode, if not, you might want to try that first.

Finally, as mentioned in another post, you'll need to get the policy
sources, add what you need to change, and re-compile them to make this
work.  I would not recommend adding any raw devices to the Apache
directive, but that's up to you.

Personally, I've found that the SELinux additions work great for boxes
that are stripped down servers and where the system linkages are well
understood but that when you start linking all around the system
(especially with PERL) you may get unexpected results.  However, most
of these can be fixed from within the script and, if not, solved with
a read-only context.  Any time that you need to change something to
provide write access, I would take a good, hard, look at the situation
at hand.

Good Luck,

Trevor

> kernel: audit(1119056704.257:0): avc: denied { read write } for pid=3020
> comm=test.pl path=/dev/pts/0 dev=devpts ino=2
> scontext=root:system_r:httpd_sys_script_t
> tcontext=root:object_r:devpts_t tclass=chr_file


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
