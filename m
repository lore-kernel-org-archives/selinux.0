Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3DBYnD1009676
	for <selinux@tycho.nsa.gov>; Mon, 13 Apr 2009 07:34:49 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3DBYm7H000866
	for <selinux@tycho.nsa.gov>; Mon, 13 Apr 2009 11:34:49 GMT
Message-ID: <49E32355.4000805@redhat.com>
Date: Mon, 13 Apr 2009 07:34:45 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: strange semanage user|login errors
References: <F7970D6F-6958-4157-9CD0-2818202619AD@gmail.com> <9e7fde520904110944s212b2e89uc22ddf7e451dc5de@mail.gmail.com>
In-Reply-To: <9e7fde520904110944s212b2e89uc22ddf7e451dc5de@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 04/11/2009 12:44 PM, Sebastian Pfaff wrote:
> I think big parts of my selinux installation are broken, i can't do
> any management task:
>
> [root@SecLab selinux_fcontext]# semodule -i *pp
> libsemanage.validate_handler: MLS range s0 for Unix user user exceeds
> allowed range s0:c0.c100 for SELinux user user_u (No such file or
> directory).
> libsemanage.validate_handler: seuser mapping [user ->  (user_u, s0)] is
> invalid (No such file or directory).
> libsemanage.dbase_llist_iterate: could not iterate over records (No
> such file or directory).
> semodule:  Failed
>
> tnx in advance
>
> --
> Sebastian Pfaff
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
You have setup an SELinux user_u record with a range of one category 
s0:c0.c100, and then are trying to add Linux login users to this user 
with a different category s0

semanage user -l | grep user_u

If you want to change the list of categories available to user_u you 
would execute

semanage user -m -r s0-s0:c0.c100 user_u

Which would allow you to add linux users with any range of categories 
form s0 to so:c0.c100.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
