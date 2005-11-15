Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAF5pYMA010853
	for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2005 00:51:34 -0500 (EST)
Received: from www.gornall.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAF5iG5T028174
	for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2005 05:44:17 GMT
Received: from [192.168.1.100] (c-67-169-147-12.hsd1.ca.comcast.net [67.169.147.12])
	by www.gornall.net (Postfix) with ESMTP id BA1AE1A24A
	for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2005 06:06:43 +0000 (GMT)
Mime-Version: 1.0 (Apple Message framework v746.2)
In-Reply-To: <1131981045.5415.103.camel@moss-spartans.epoch.ncsc.mil>
References: <840CEAA7-85D1-4C5B-8B8D-B8E55AB217A7@gornall.net> <1131981045.5415.103.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F2C51318-DBA7-49F0-BE5F-7A591238ADD8@gornall.net>
From: Simon Gornall <simon@gornall.net>
Subject: Re: Running programs from a PHP script under SELinux
Date: Mon, 14 Nov 2005 21:44:11 -0800
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Nov 14, 2005, at 7:10 AM, Stephen Smalley wrote:

> On Sun, 2005-11-13 at 11:24 -0800, Simon Gornall wrote:
>> This is very much a newbie question I'm afraid - if there's a more-
>> appropriate forum, I'll be glad to be pointed in their general
>> direction :-) I can't see anything in the FAQ (though I guess I may
>> not have recognised the solution) or after having googled...
>
> Just FYI, some other information resources about SELinux are listed in
> http://selinux.sourceforge.net/resources.php3

Cheers :-)

>> When  I call 'exec("/path/to/program") from within a PHP script, it
>> does actually work, but I get a message in the 'dmesg' output like:
>>
>> audit(1131753033.872:49): avc:  denied  { execute } for  pid=15678
>> comm="fortune" name="ld.so.cache" dev=md2 ino=132328
>> scontext=root:system_r:httpd_sys_script_t
>> tcontext=root:object_r:ld_so_cache_t tclass=file
>
> What does execstack -q `which fortune` show?  Typically, that audit
> message suggests that kernel is translating PROT_READ requests by that
> binary to PROT_READ|PROT_EXECUTE in order to provide compatibility  
> with
> "legacy" binaries that presumed read-implies-exec logic.

Hmm - in this case it reports '-', which would seem to suggest the  
stack isn't executable...

# execstack -q `which fortune`
- /usr/bin/fortune

in case it's any use:

# ls -lZ `which fortune`
-rwxr-xr-x  root     root     system_u:object_r:bin_t          /usr/ 
bin/fortune

I guess I can live with it if it's only the 'fortune' binary (this  
isn't crucial to end-user operations :-). I'll investigate other  
binaries and see if I get the same thing...

ATB,
	Simon

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
