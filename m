Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l18KVAlv022112
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 15:31:10 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l18KWIqP001600
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 20:32:19 GMT
Message-ID: <45CB88E0.4020203@mentalrootkit.com>
Date: Thu, 08 Feb 2007 15:32:32 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ANN: SETools Release
References: <1170958915.31164.45.camel@sgc.columbia.tresys.com>
In-Reply-To: <1170958915.31164.45.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> 
> libseaudit:
> 
>   * Rewrite of library to have proper namespaces.  libseaudit is now
>     fully documented and suitable for third-party users.
> 

Do you now handle USER_AVC and AVC_PATH audit messages? Also, any 
thoughts of using the new audit parsing library in the future?

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
