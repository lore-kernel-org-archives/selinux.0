Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6UHVAHa028357
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 13:31:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6UHTxFB025600
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 17:29:59 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h6UHTuGD025591
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 17:29:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Dwayne C. Litzenberger" <dlitz@dlitz.net>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: proposal: per-user temporary directories on by default?
Date: Mon, 28 Jul 2003 15:27:55 -0400
References: <20030723211409.GA31197@dragon.kitenet.net> <20030725231644.GA1079@hezmatt.org> <20030726013325.GA22280@rivest.dlitz.net>
In-Reply-To: <20030726013325.GA22280@rivest.dlitz.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307281527.55128.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 25 Jul 2003 21:33, Dwayne C. Litzenberger wrote in the debian-devel 
mailing list:
> Pretty soon, normal users are going to start using multiple uids in a
> session.  (For example, each user could have their GnuPG/SSH/whatever
> private keys in a separate user's home directory that only

Currently in my SE Linux policy I have a different type used for the GPG keys 
which is not accessable to the regular user domain.

For example a user logs in with domain user_t and their home directory has 
type user_home_dir_t.  When they run gpg it runs in domain user_gpg_t.  When 
programs in the user_gpg_t domain create directories inside a directory of 
type user_home_dir_t the type for the new directories (and any files they 
contain) will be user_gpg_secret_t which is not readable by user_t.

So gpg has full read/write access to it's configuration files, but the domain 
which runs gpg does not.

The problem is that occasionally users need to change their gpg options file.
One possibility I am considering is to have a domain to use for this, so the 
user could run "newrole -t user_high_t" or something similar.  Newrole then 
asks the user for their password and runs a shell in the new domain.

Currently the protection for the ~/.ssh directory in the SE Linux policy is 
not as good, I should probably improve it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
