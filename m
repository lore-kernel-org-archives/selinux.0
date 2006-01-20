Message-ID: <43D0F5DE.2080901@linuon.com>
Date: Fri, 20 Jan 2006 23:38:22 +0900
From: Junji Kanemaru <linux@linuon.com>
MIME-Version: 1.0
To: linux-audit@redhat.com, SELinux@tycho.nsa.gov
Subject: [ANN] Linux Event Dispatcher
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm pleased to introduce Linux Event Dispatcher version 1.0 beta is
now ready for download. 
I thought some people on this list might be interested in this so I'm
posting this. It would be multi-posting. It so, I'm very sorry for bandwidth.

Led is realtime event filtering framework for Linux system that handles any
system events on the fly. 
You can register actions to particular events such as access violation and
login failures at realtime with led. The events can be fed from, via syslogd.
auditd, ulogd of netfilter and any other sources too. 

This is preliminary release to have people review. The base framework is
pretty much done but plugins. I'd need some help from people out there
to write more plugins.  
Any comments and requests are welcome  :) 

You can download led from: http://www.linuon.com/

[Brief Introduction]

First of all Linux Event Dispatcher, or led for short, is NOT a replacement 
for other traditional logging and filtering system. Instead led gets fed events
from them.
The main goal of led is to handle system events realtime and do action for
the events on the fly.

For example you can have filters for critical events from kernel audit system
and setup detailed actions for each event such as avc violation and
unexpected write operation on /var/www/html/index.hml. 
You may pick action for each event either shutdown system immediately or
block http port temporarily and recover whole web contents etc. And same
time you can check who did it and ban him/her from host if he/she is on
localhost and report it to you right away... 
You would be able to do such things with led.

Normally most of administrators won't realize attack until they get some
error or look into logwatch report email carefully. It might be too late.
You could have restricted setting to take the risk minimum but you can't block
port entirely.  As long as you are opening ports to public there's risk so how
fast you can notice error and recover from compromise is the key...

For more info please go to http://www.linuon.com/

Thanks,
--  Junji Kanemaru

Linuon Inc.
Tokyo Japan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
