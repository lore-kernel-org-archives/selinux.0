Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8RITYrT003420
	for <selinux@tycho.nsa.gov>; Mon, 27 Sep 2004 14:29:34 -0400 (EDT)
Received: from mail.mvalent.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8RISWhp005396
	for <selinux@tycho.nsa.gov>; Mon, 27 Sep 2004 18:28:33 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: bash_profile: Permission denied
Date: Mon, 27 Sep 2004 14:29:34 -0400
Message-ID: <E6E16A6D4277CD459BBDE6713766033CB72208@exchange.mvalent.local>
From: "James R. Marcus" <jmarcus@mvalent.net>
To: <russell@coker.com.au>, "Luke Kenneth Casson Leighton" <lkcl@lkcl.net>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry I haven't replied to this sooner. I'm fine with .bash_profile
getting a permission denied.  The first issue was that when I was
switching back and forth from permissive to enforced mode, my new login
shell would hang on the permission denied error, and I would never get
to a prompt. Maybe this was an issue with my ssh client? This error
seems to be some extreme case, because without changing anything it
appears I can login as root while in enforced mode.

James

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Russell Coker
Sent: Friday, September 24, 2004 4:25 AM
To: Luke Kenneth Casson Leighton
Cc: Daniel J Walsh; James R. Marcus; selinux@tycho.nsa.gov
Subject: Re: bash_profile: Permission denied

On Fri, 24 Sep 2004 09:15, Luke Kenneth Casson Leighton <lkcl@lkcl.net>
wrote:
>  ah, but running newrole is not enough: not having write access to
>  /root/.bash_profile results in bash not _reading_ the file either.

I wrote the following in my previous message to James R. Marcus on the
same 
topic:

If you enable the boolean staff_read_sysadm_file then staff_t can read 
sysadm_home_t files and can search sysadm_home_dir_t directories.  This
will 
allow you to login as root:staff_r:staff_t without any warning messages
AND 
with the aliases etc from .bashrc defined.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux
packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
