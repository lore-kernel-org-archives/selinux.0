Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UJ8BrT025842
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 15:08:11 -0400 (EDT)
Received: from venus.informatica.co.cr (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UJ74ng003513
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 19:07:05 GMT
Subject: Re: where is the modified login program's source code
From: Miguel Bolanos <mike@hsol.net>
To: Park Lee <parklee_sel@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040930141837.5407.qmail@web51503.mail.yahoo.com>
References: <20040930141837.5407.qmail@web51503.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1096571312.21508.16.camel@talena.hsol.net>
Mime-Version: 1.0
Date: Thu, 30 Sep 2004 13:08:32 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

On Thu, 2004-09-30 at 08:18, Park Lee wrote:
> Hi,
>   I know that login is a modified daemon program. Now, I want to do
> some work with the login program in SELinux. But, Where could I found
> the modified login program's source code? It seems that it isn't
> contained in Fedora Core 2.
>   If you know the matter, please tell me about it.

Well there is not such thing as a "login" package, this is part of
util-linux package. The FC2 srpm can be found here:

http://download.fedora.redhat.com/pub/fedora/linux/core/2/SRPMS/util-linux-2.12-18.src.rpm

There is also an srpm for util-linux at the selinux offical site:

http://www.nsa.gov/selinux/SRPMS/util-linux-2.12a-2.src.rpm

Or you can just get the source code from the original location:

ftp://ftp.win.tue.nl/pub/linux-local/utils/util-linux/
ftp://ftp.win.tue.nl/pub/linux-local/utils/util-linux/util-linux-2.12a.tar.gz

And use the patch available at the selinux site for it:

http://www.nsa.gov/selinux/patches/util-linux-selinux.patch.gz

Hope this helps enough to get you started.
best wishes

Miguel

>  
>   Thank you.
> 
> --
> Best Regards,
> Park Lee <parklee_sel@yahoo.com> 
>  
> 
> 
> ______________________________________________________________________
> Do you Yahoo!?
> Yahoo! Mail - 50x more storage than other providers!


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
