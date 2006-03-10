Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2AJ3nar022108
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 14:03:49 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k2AJ3k59009835
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 19:03:47 GMT
In-Reply-To: <1142013189.25454.152.camel@moss-spartans.epoch.ncsc.mil>
References: <4411AFCB.60401@hp.com> <1142010664.25454.128.camel@moss-spartans.epoch.ncsc.mil> <4411B5F2.6060702@hp.com> <1142012234.25454.139.camel@moss-spartans.epoch.ncsc.mil> <4411B9A9.5020102@hp.com> <1142013189.25454.152.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BDEE5CBC-F62F-4B14-BCD3-42B7215987DD@nall.com>
Cc: James Morris <jmorris@namei.org>, SELinux List <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>
From: Joe Nall <joe@nall.com>
Subject: Re: Query MLS info outside of SELinux/LSM?
Date: Fri, 10 Mar 2006 13:03:39 -0600
To: Paul Moore <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> On Fri, 2006-03-10 at 12:38 -0500, Paul Moore wrote:
>> Agreed.  Although for most cases in SELinux there are no practical  
>> upper
>> bounds so such logic (that I am thinking of anyway) doesn't make  
>> sense.
>>     I was just looking for something to tell me the number of MLS  
>> levels
>> and categories in the current instantiated policy so I could do some
>> optimizations in the CIPSO/NetLabel code.

If there is a naming convention for system high you can ask for a  
translation of SystemHigh and look the the level and categories  
returned. Use of CIPSO could be dependent on certain names or aliases  
being available in setrans.conf.

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
