Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB4IB6IZ028463
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 13:11:06 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB4I9K5U006770
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 18:09:21 GMT
Message-ID: <457464A6.7000005@mentalrootkit.com>
Date: Mon, 04 Dec 2006 13:10:46 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: Linda Knippers <linda.knippers@hp.com>, selinux@tycho.nsa.gov
Subject: Re: User home directory creation with useradd (rhbz#217441)
References: <730781.75976.qm@web36610.mail.mud.yahoo.com>
In-Reply-To: <730781.75976.qm@web36610.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> --- Linda Knippers <linda.knippers@hp.com> wrote:
> 
> 
>> I don't want more stuff in semanage.  We should be
>> able to do it from
>> useradd, and from one role.  Right now its a multi
>> step operation and
>> we can't run useradd and semanage from the same
>> role.  Only sysadm_r
>> can run useradd and only secadm_r can run semanage
>> with the current
>> MLS policy.
> 
> While this is inconvenient, it is consistant
> with the separation of roles. You might want
> a role explictitly for this function.
> Experiance on other systems has been that
> neither the secadm nor the sysadm roles are
> sufficient for adding a user by themselves,
> nor should they be.
> 

It should be configurable via policy, which means the code should be 
present in useradd. The vast majority of SELinux systems shipped don't 
have a secadm role. For that configuration the sysadm should be able to 
create a user and a user mapping in a single step.


Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
