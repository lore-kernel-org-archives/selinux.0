Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2FFcSjB031779
	for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2007 11:38:28 -0400
Received: from web86907.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l2FFcRlZ024507
	for <selinux@tycho.nsa.gov>; Thu, 15 Mar 2007 15:38:27 GMT
Date: Thu, 15 Mar 2007 15:38:11 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: SELinux configuration problems on Fedora Core 6
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20070315150506.99935.qmail@web86915.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <385971.61397.qm@web86907.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

...sorry to mention one thing that:

newrole -r SysAdmin_r is also not working and giving
the error:

'couldn't get default type'

Thanks,
JG


--- JanuGerman <doublemalam@yahoo.co.uk> wrote:

> Hi Every body,
> 
>  I am not able to configure the SELinux policy on
> the
> Fedora Core 6 (2.6.20.1). There is no folder called
> /etc/selinux/src/policy. Where as, in the all
> internet
> documentation, this folder is referenced. Plus,
> there
> is no sample policy shipped with the SELinux on
> Fedora.
> 
> The refPolicy tool from tresys, tries to referece a
> command called  /usr/bin/checkpolicy, which is also
> not lodable. Is there is some problem with this
> kernel
> version, or my installation did not went successful
> of
> SELinux.
> 
> THanks.
> JG
> 
> 
> 		
>
___________________________________________________________
> 
> What kind of emailer are you? Find out today - get a
> free analysis of your email personality. Take the
> quiz at the Yahoo! Mail Championship. 
>
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk
> 
> 
> --
> This message was distributed to subscribers of the
> selinux mailing list.
> If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as
> the message.
> 



		
___________________________________________________________ 
Copy addresses and emails from any email account to Yahoo! Mail - quick, easy and free. http://uk.docs.yahoo.com/trueswitch2.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
