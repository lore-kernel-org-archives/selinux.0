Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1MK2ant031989
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2012 15:02:38 -0500
Subject: Re: No feedback when cloning `http://oss.tresys.com/git/selinux.git`
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
From: Joe Nall <joe@nall.com>
In-Reply-To: <4F4546F6.5050603@tresys.com>
Date: Wed, 22 Feb 2012 14:02:35 -0600
Cc: Paul Menzel <paulepanter@users.sourceforge.net>, <selinux@tycho.nsa.gov>
Message-Id: <6BF36172-D831-4087-8096-803DCB9AD957@nall.com>
References: <1329939142.3296.5.camel@mattotaupa> <4F4546F6.5050603@tresys.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Feb 22, 2012, at 1:50 PM, Christopher J. PeBenito wrote:

> On 02/22/12 14:32, Paul Menzel wrote:
>> Dear SELinux folks,
>> 
>> 
>> trying to clone the SELinux user space programs [1] I issue
>> 
>> 
>>        $ git clone http://oss.tresys.com/git/selinux.git
>>        Cloning into 'selinux'...
>> 
>> but it just hangs there. So I thought it does not work. Letting it stay
>> for more than a minute it finished. Other Git repositories give some
>> kind of feedback. Are some hooks missing?
> 
> Are you sure you're waiting long enough?  I was able to clone a fresh copy of the repo using the above command w/o problem.  It took 48s for me.

I think what he is referring to is:

time git clone http://oss.tresys.com/git/selinux.git
Cloning into selinux...

real	0m46.487s
user	0m1.255s
sys	0m2.326s

time git clone https://github.com/joyent/node.git
Cloning into node...
remote: Counting objects: 60958, done.
remote: Compressing objects: 100% (15947/15947), done.
Receiving objects:  17% (10687/60958), 16.84 MiB | 820 KiB/s   

the remote: and Receiving objects: lines

joe




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
