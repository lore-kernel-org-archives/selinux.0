Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8THoMrT017632
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 13:50:22 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8THnInY026655
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 17:49:19 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: Access to xdm_t
Date: Thu, 30 Sep 2004 03:50:06 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de>
In-Reply-To: <20040929163222.GA4125@rom.cip.ifi.lmu.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200409300350.06284.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 30 Sep 2004 02:32, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> I have a question about access to xdm_t:
> With KDM 3.3 I am seeing a lot of accesses to xdm_t:fd and
> xdm_t:fifo_file from user processes (say user_lpr_t and user_gpg_t)
> Should these be allowed?
> If yes, should xdm_t get the attribute privfd?

I don't think that is necessary.  gpg and lpr are both text based programs and 
have no need of direct communication with xdm_t.  I think that the wide 
inheritance of that file handle is a bug.

> Also, is it OK to dontaudit access to .xsession-errors (on SuSE it lives
> under ~ and I do not want to give all derived user domains access to user's
> home dir). Or will this cause errors with some programs?

That should be fine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
