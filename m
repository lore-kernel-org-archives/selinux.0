Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8FFcK7n000585
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 11:38:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8FFbq7O015453
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 15:37:52 GMT
Message-ID: <450AC8E7.10306@redhat.com>
Date: Fri, 15 Sep 2006 11:38:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux770@tortenboxer.de
CC: selinux@tycho.nsa.gov
Subject: Re: Cannot find your entry in the shadow passwd file
References: <20060914172151.119780@gmx.net>
In-Reply-To: <20060914172151.119780@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

selinux770@tortenboxer.de wrote:
> Hey there,
>
> i've got a strange problem. I created a new user on my system which is
> not able to switch between different roles. Looks like this:
>
> ~ $ id -Z
> setester:user_r:user_t
> ~ $ newrole -r staff_r
> Authenticating setester.
> Cannot find your entry in the shadow passwd file.
> ~ $
>
> This happens to all users except root:
>
> ~# id -Z
> root:staff_r:staff_t
> ~# newrole -r sysadm_r
> Authenticating root.
> Password:
> ~# id -Z
> root:sysadm_r:sysadm_t
>
> Any suggestions what is wrong? Could that be a misfunction in pam?
>
>   
I think newrole is looking up setester in /etc/passwd.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
