Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13520
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 12:19:42 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA10899
	for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 16:18:31 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA10895 for <selinux@tycho.nsa.gov>; Thu, 25 Apr 2002 16:18:29 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: newrules
Date: Thu, 25 Apr 2002 18:19:30 +0200
References: <72222DC86846D411ABD300A0C9EB08A101524369@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524369@csoc-mail-box.csoconline.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020425161930.A2C853CCD@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please note that I'm sending this to the list because I think it's nothing 
private and it's something that will interest other people.

On Thu, 25 Apr 2002 17:53, you wrote:
> On Thursday, April 25, 2002 10:36 AM, Russell Coker wrote:
> > after that I  think you're better off just reading the logs yourself.
>
> I understand the log messages very well and I use the newrules allot.
> I do not blindly take what it put outs,

I never thought that you were the type of person who would do:
newrules.pl | sort -u >> /etc/selinux/domains/programs/new.te

> I do look at the messages files
> at the same time. I have always been a bad typist. I look at the logs
> then if I happy cut and paste from newrules output.

The problem is that such things never work very well because they only allow 
what has been done and don't extrapolate to what is likely to be done (an 
expert system would be good for this).

For example in most situations where newrules.pl will output "allow user_t"  
you instead want to update the user_macros.te file.

Similarly a change to the domains used for mail storage will probably require 
changes to POP, IMAP, and mail server configuration.

Then there's cases where the importance of files needs to be known.  If I see 
one program from a set of programs being denied access to resolv_conf_t then 
I may just allow a dozen domains read access to that type to save bothering 
about it in future.  However if I have a case where one program of a group 
needs access to the user_gpg_secret_t then there's no way I'll consider 
giving read access to the group of programs!

It would be nice if we had some sort of IDE for security policy where you can 
specify the reason for types/domains and the importance.  resolv_conf_t was 
created to permit write access not to restrict read access, so we can freely 
give away read access to it without much thought.  Wheras user_gpg_secret_t 
has to be highly protected and anything involving it must be very restrictive 
and done with care.

Also for the newrules.pl, "read" should usually be changed to r_file_perms 
and "read write" should usually be changed to rw_file_perms.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
