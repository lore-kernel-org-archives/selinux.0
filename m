Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5955drT017359
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 01:05:39 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5955YTV013203
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 01:05:36 -0400 (EDT)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: How to handle tmpfiles under /home ?
Date: Wed, 9 Jun 2004 15:05:52 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040607234412.GB2073@jmh.mhn.de>
In-Reply-To: <20040607234412.GB2073@jmh.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406091505.52603.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Jun 2004 09:44, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> I recently ran into a problem with tmpfiles in my homedir. I have
> configured mutt to store mails I write under ~/.mutt/tmp/.
> Unfortunately, current policy only allows postfix to read user_tmp_t.
> This leads to postfix sending totally empty mails in enforcing mode.

What version of the policy allows postfix to access user_tmp_t?

user_mail_t is allowed access to files of type user_tmp_t.  But apart from 
that there should be no access of postfix to user_tmp_t.

user_tmp_t generally should not be used for files under the user home 
directory, so ~/.mutt/tmp should be labelled as user_home_t.

If you create a file on /tmp and mv it to ~ then if ~ and /tmp are on the same 
file system then it will get the type user_tmp_t, is this the case with mutt?  
What does that have to do with Postfix anyway?  Postfix should not be 
attempting delivery to ~/.mutt anyway.

Your message didn't clarify what your problem is, or what your objectives are, 
so I can't give any advice until I get more information.


As for Steve's message about putting the MUA into it's own domain, the problem 
with that is that the MUA is usually expected to be able to attach files from 
any directory and save received attachments to any directory.  It wants to 
run gpg and store the gpg pass-phrase, so unless the usage patterns are 
significantly changed there's little ability to lock things down.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
