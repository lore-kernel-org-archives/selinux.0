Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mBO7UGRT000578
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 02:30:16 -0500
Received: from yw-out-1718.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mBO7Rogs006654
	for <selinux@tycho.nsa.gov>; Wed, 24 Dec 2008 07:27:50 GMT
Received: by yw-out-1718.google.com with SMTP id 6so1002180ywa.84
        for <selinux@tycho.nsa.gov>; Tue, 23 Dec 2008 23:30:16 -0800 (PST)
Message-ID: <4951E501.30803@gmail.com>
Date: Tue, 23 Dec 2008 23:30:09 -0800
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: Atsushi SAKAI <sakaia@jp.fujitsu.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Question about SELinux userspace library and scripts?
References: <20081224062816.5200518070@m024.s.css.fujitsu.com>
In-Reply-To: <20081224062816.5200518070@m024.s.css.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Atsushi SAKAI wrote:
> Hi,
>
> I have a question about user-space library and script.
> As far as I know, following 6-library and 1-script are exists.
>
> Userspace library(6-libs(utils included))
>   http://userspace.selinuxproject.org/trac/wiki/Userland
>
> macro for reference policy(scripts in following dir)
>   serefpolicy-3.5.13/support
>
> Any other library and script exists ?
> and 
> some explanation about serefpolicy macros?
>
>
> Thanks
> Atsushi SAKAI
>
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   
 From experience with userland
just do a git-pull..
should give the the proper files
except for python-selinux to build a custom policy
(as for macros not too sure);

regards;

Justin P. Mattock








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
