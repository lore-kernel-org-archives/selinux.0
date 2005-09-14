Message-ID: <20050914172547.14693.qmail@web51506.mail.yahoo.com>
Date: Wed, 14 Sep 2005 10:25:47 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: New ideas on implementation on libsetrans.
To: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1126704790.12299.60.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>> >Am I missing other disadvantages?
>> 
>> How often would this library be called? Is it a performance hit for programs
to
>> parse the flat file everytime they run? I'm thinking mostly of coreutils style
>> programs that would be in shell scripts. What program would be the heaviest
>> user of the translation library? Is anything other than translation being 
>> considered? 
>
>so any program that gets or sets a context would exercise them.

My concern which lead to consideration of the daemon approach is the performance
penalty imposed by dlopen & dlsym as well as parsing the configuration each time
a program starts up. dlopen is a heavy function call. Communication across a
af_unix socket is likely to be faster since there are fewer syscalls. The
question is are there enough programs that would suffer a performance hit that we
should look at making a daemon. Admittedly the daemon would be simple and it
would load the plugin. I also was thinking about doing the config from shared
memory to avoid all the parsing on startup. Yes, there would need to be a cache
scrubber that times out the cache entries - which could be coordinated with
inotify. (If inotify never says the config changed, no need to timeout the
cache.)

> A simple ls -Z would exercise them. But the mapping file itself is typically
> only loaded once

Are there any other common utilities that would cause a performance hit? pam
modules for example. If its just ls -Z, I'm not too worried. I do worry if it
gets into something that is performance sensitive like dbus, nscd, etc.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
