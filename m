Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA28712
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 18:17:45 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>
Subject: Re: Editing crontabs
Date: Tue, 1 Oct 2002 00:17:34 +0200
References: <20020930221243.GB9056@snoopy.apana.org.au>
In-Reply-To: <20020930221243.GB9056@snoopy.apana.org.au>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Message-Id: <200210010017.34485.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Oct 2002 00:12, Brian May wrote:
> What domain do I have to be in to look at somebodies cron tables?
>
> ns# crontab -e -u luser
> crontabs/luser: Permission denied
> ns# id
> uid=0(root) gid=0(root) groups=0(root) context=root:sysadm_r:sysadm_t
> sid=473

The same domain as them.  If you're sysadm_r then you should have permissions 
to change to that role.

Or I guess it would make sense to put the following in 
macros/programs/crontab_macros.te:
allow sysadm_crontab_t $1_crontab_t:file { getattr read };

Of course we must not give create or write access to the other user's crontab 
file to prevent mistakes...

What do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
