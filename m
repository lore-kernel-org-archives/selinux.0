Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA15388
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 11:32:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA06193
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 16:29:20 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id QAA06189
	for <selinux@tycho.nsa.gov>; Tue, 4 Feb 2003 16:29:17 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Daniel J Walsh <dwalsh@redhat.com>, Tom <tom@lemuria.org>
Subject: Re: SELinux question?
Date: Tue, 4 Feb 2003 17:31:49 +0100
Cc: selinux@tycho.nsa.gov
References: <200301271320.IAA05862@moss-shockers.ncsc.mil> <20030204154613.A7115@lemuria.org> <3E3FE0EF.8030105@redhat.com>
In-Reply-To: <3E3FE0EF.8030105@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200302041731.49651.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Feb 2003 16:49, Daniel J Walsh wrote:
> So they did it because it was easier to wrap the application then to
> change the code, correct?

Yes.  Changing the application requires keeping up to date with new versions 
of the application (on-going work) and also it's easy to make a mistake when 
working with someone else's uncommented code.

For some things it's necessary, EG changing the login programs and cron 
because the change is so tightly related to the task.  For some things it 
doesn't make sense to try and wrap it (EG ls).

For some programs such as passwd it's not something you want to get into 
yourself, it's easiest to write a wrapper, and there are a family of programs 
which can all be serviced by the same wrapper if done properly.

> I would like to know if there was any other reason to use the s* syntax,
> or all things being equil
> you would replace the passwd command with a SELinux aware passwd command?

The spasswd program is hard-coded to run /usr/bin/passwd, so if you rename it 
then you'll also have to change the code.

I could do such things quite easily for my Debian packaging of SE Linux 
programs, but the NSA are focusing on a tarball release which makes such 
things impractically difficult.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
