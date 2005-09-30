Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UIQZNs002127
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 14:26:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UIKYbY009433
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 18:20:36 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C5D8E61B01
	for <selinux@tycho.nsa.gov>; Sat,  1 Oct 2005 04:20:39 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 23359-06 for <selinux@tycho.nsa.gov>;
	Sat, 1 Oct 2005 04:20:39 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id CEABE61AFB
	for <selinux@tycho.nsa.gov>; Sat,  1 Oct 2005 04:20:37 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: postfix.te
Date: Sat, 1 Oct 2005 04:20:08 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>
References: <200509301520.42488.russell@coker.com.au> <200509302216.47786.russell@coker.com.au> <433D45A3.9030705@redhat.com>
In-Reply-To: <433D45A3.9030705@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510010420.17427.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 01 October 2005 00:03, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >> Huh?  So we just allow spamassassin to fail if policy is not installed,
> >> which it is not in targeted policy.
> >
> > We remove the bad policy until we can determine how to write good policy.
>
> No We make it work on a customers machine or they turn off selinux,
> never to turn it on again.
> Turns out this is not bad policy and does not open up security holes.

The approach of adding allow rules when we don't know what the program is 
doing is not productive.  If we combine that with an extreme reluctance to 
ever remove allow rules then the result is an increasing permission creep 
that is not managable.

> > Who submitted the policy patch in regard to etc_mail_t and bin_t?  We
> > need to ask that person why they did it and find out what they were
> > trying to do. There is a better way of achieving the same result, but
> > until we know what they are trying to do it's not possible.  The
> > questions we need to ask that person are:
> > 1)  Are you using procmail for delivery?
> > 2)  If not how are you running spamassasin?
> >
> > The last thing I want to do is imagine how Postfix might be working, get
> > it wrong, and end up writing policy to permit Postfix to do things it can
> > never be configured to do!
>
> It is running postfix-script which is executing /bin/sed.
>
> This is standard postfix out of the box, running on steve grubb machine.

Running a default config of postfix on a rawhide machine I sent mail to a 
local address and had it delivered without any such access.  The file 
"postfix-script" has the comment "The postfix-script script executes Postfix 
administrative commands in an environment that is set up by the postfix(1) 
command".

Administrative commands shouldn't (and can't) be run from postfix_local_t.  
The normal use of "postfix-script" is to be run when starting postfix.  To 
verify this put "ls -l /tmp" near the start of the script (it doesn't do much 
error checking so that won't affect the operation in any serious way).  You 
will see an audit message similar to the following:

avc:  denied  { read } for  pid=13843 comm="ls" name="/" dev=dm-2 ino=2 
scontext=rjc:system_r:postfix_master_t:s0-s0:c0.c127 
tcontext=system_u:object_r:tmp_t:s0 tclass=dir

To test postfix local delivery I ran "mail rjc" from the command-line where 
"rjc" is a local account.  Mail was delivered to /var/spool/mail/rjc with no 
need for postfix_local_t to access bin_t.  I've tested without sendmail and 
spamassassin installed (with no /etc/mail) and it worked OK, I've tested it 
with them installed and there was no access to /etc/mail by postfix_local_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
