From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Park Lee <parklee_2004@yahoo.com.cn>, SELinux@tycho.nsa.gov
Subject: Re: Something seems to be self-contradictory
Date: Tue, 17 Feb 2004 03:42:06 +1100
References: <20040216140245.87457.qmail@web15201.mail.bjs.yahoo.com>
In-Reply-To: <20040216140245.87457.qmail@web15201.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200402170342.06666.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 17 Feb 2004 01:02, Park Lee <parklee_2004@yahoo.com.cn> wrote:
> 1.  ... ... A program,like any other object, is assigned a type,....      (
> Page 4, subsection 3.1.TE Model,  Configuring the SELinux Policy). 2. ...
> ...These transitions ensure that system processes and certain programs are
> placed into their own separate domains automatically. ......    ( Page 2,
> section 2 Overview,  A Security Policy Configuration for the
> Security-Enhanced Linux ).
>
> Then I was confused by such a problem:
> Whether a program is assigned a type or a domain ?

A domain is a special type.

When you define types they can have attributes, one attribute is "domain" 
which indicates that it's possible to use that type for labelling processes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
