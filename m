Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PCO0d5017297
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 08:24:00 -0400
Received: from wx-out-0506.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3PCNxQt010782
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 12:23:59 GMT
Received: by wx-out-0506.google.com with SMTP id s17so212223wxc
        for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 05:23:59 -0700 (PDT)
Message-ID: <462F476B.40407@gmail.com>
Date: Wed, 25 Apr 2007 20:19:55 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, SELinux List <selinux@tycho.nsa.gov>,
        russell@coker.com.au
Subject: Re: can not boot with strict policy
References: <462CA1F0.2000400@gmail.com>	 <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil>	 <Line.LNX.4.64.0704231341100.3793@d.namei>	 <1177350508.24282.58.camel@moss-spartans.epoch.ncsc.mil>	 <462CF79C.5080804@redhat.com>  <462DBBC8.9060300@gmail.com> <1177417620.8672.28.camel@sgc>
In-Reply-To: <1177417620.8672.28.camel@sgc>
Content-Type: text/plain; charset=gb18030; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2007-04-24 at 16:11 +0800, Ken YANG wrote:
>> Daniel J Walsh wrote:
>>> So the real question, is there much value with the division between 
>>> lib_t and shlib_t.
>>> When dealing with strict policy, shared libraries were always getting 
>>> mislabeled as lib_t, and causing problems, for little security advantage.
>>> As we remove the differences between strict and targeted, I don't intend 
>>> to get rid of lib_t == shlib_t.
>>
>> i find most files labeled with "lib_t" are ".a" or symbolic link to
>> ".so"
>>
>> what difference between lib_t and shlib_t? what is the purpose of
>> "lib_t" type?
> 
> The difference boils down to being able to mmap shlib_t files as
> executable (which is required for shared libraries to work), whereas
> that is not allowed for lib_t files.  That means that only shared
> libraries are shlib_t and symlinks and static libraries (and other
> random files placed in /lib or /usr/lib) are lib_t.


the problem is due to my fault, rebooting with strict policy without
relabel in permissive mode.

in my opinion, the distinction between lib_t and shlib_t in strict
policy should be kept, we can not regards all libs as same with share
libraries.

we can avoid this "denial problems" by writing corresponding
informations in manual. In many situations, switching from targeted
to strict is a "big" changes, only certain people will perform this
kind of operation, and i guess these people will also study the manual,
before administrate SELinux system.



> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
