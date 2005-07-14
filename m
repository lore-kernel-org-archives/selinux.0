Subject: Re: id -Z causing some problem
From: Tobias Nijweide <tobias@neatech.nl>
To: SELinux@tycho.nsa.gov
In-Reply-To: <e8a2934d0507132336220fb171@mail.gmail.com>
References: <e8a2934d0507132336220fb171@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 09:22:44 +0200
Message-Id: <1121325764.10813.6.camel@nachtwacht>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-14 at 12:06 +0530, Preeti Malakar wrote:
>  When i am the root and issuing the command id -Z <username> why am i
> getting the following message? but SELinux is enabled
> 
> [root@pryber /]# id preeti
> uid=500(preeti) gid=500(preeti) groups=500(preeti)
> [root@pryber /]# id -Z preeti
> id: cannot display context when selinux not enabled or when displaying the id
> of a different user
> [root@pryber /]# cat /selinux/enforce
> 1

I'm not much of an SELinux expert yet, but I think you'll find your
question is answered in the second part of sthe error msg:
'or when displaying the id of a different user'.

Does 'id -Z' instead of 'id -Z preeti' work?

Because there is no real tie between unix (/etc/passwd) users and
SELinux users, and even if there were the role/domain are dependent
on context, it's not evem theoretically possible for the system
to give an unambiguous answer.

Regards,
Tobias Nijweide


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
