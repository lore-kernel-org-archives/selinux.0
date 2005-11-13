Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jADJVoMA026653
	for <selinux@tycho.nsa.gov>; Sun, 13 Nov 2005 14:31:50 -0500 (EST)
Received: from www.gornall.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jADJOkQ8003340
	for <selinux@tycho.nsa.gov>; Sun, 13 Nov 2005 19:24:46 GMT
Received: from [192.168.1.100] (c-67-169-147-12.hsd1.ca.comcast.net [67.169.147.12])
	by www.gornall.net (Postfix) with ESMTP id 1D3BD1C4E4
	for <selinux@tycho.nsa.gov>; Sun, 13 Nov 2005 19:47:31 +0000 (GMT)
Mime-Version: 1.0 (Apple Message framework v746.2)
Message-Id: <840CEAA7-85D1-4C5B-8B8D-B8E55AB217A7@gornall.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: selinux@tycho.nsa.gov
From: Simon Gornall <simon@gornall.net>
Subject: Running programs from a PHP script under SELinux
Date: Sun, 13 Nov 2005 11:24:35 -0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

This is very much a newbie question I'm afraid - if there's a more- 
appropriate forum, I'll be glad to be pointed in their general  
direction :-) I can't see anything in the FAQ (though I guess I may  
not have recognised the solution) or after having googled...

I've set up RHEL-4 on a webserver machine that is going to ultimately  
replace my current one, and I've meddled with the .fc and .te files  
to successfully run mysql with its databases in /opt/mysql (large  
RAID) and have the webserver directories in /opt/www... I've made  
diffs so that if the 'official' targetted policies change I can  
easily recover my settings. So far, so good.

When  I call 'exec("/path/to/program") from within a PHP script, it  
does actually work, but I get a message in the 'dmesg' output like:

audit(1131753033.872:49): avc:  denied  { execute } for  pid=15678  
comm="fortune" name="ld.so.cache" dev=md2 ino=132328  
scontext=root:system_r:httpd_sys_script_t  
tcontext=root:object_r:ld_so_cache_t tclass=file

... so, ok, this is only 'fortune' that's running on the login  
screen, but there will be more-useful programs as well :-) The  
machine in question is on the other side of the world, so I thought  
I'd ask what to do before meddling with access to /etc/ld.so.cache in  
case the whole thing breaks...

Like I say, it does work, but I like to keep the message-logs as  
clear as possible so real problems can be more-easily tracked...

Any help appreciated :-)

ATB,
	Simon


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
