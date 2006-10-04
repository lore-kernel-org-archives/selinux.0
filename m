Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94M3ORG002098
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 18:03:24 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k94M2C5l020325
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 22:02:12 GMT
In-Reply-To: <200610041712.00629.sgrubb@redhat.com>
References: <36282A1733C57546BE392885C0618592015CF96F@chaos.tcs.tcs-sec.com> <1159993643.19176.256.camel@moss-spartans.epoch.ncsc.mil> <45241EFF.2000108@hp.com> <200610041712.00629.sgrubb@redhat.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C89A4409-F96D-430D-8DF5-7BEF0F972A4F@nall.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        SE Linux <selinux@tycho.nsa.gov>, eparis@redhat.com,
        James Morris <jmorris@namei.org>, Steve Grubb <sgrubb@redhat.com>
From: Joe Nall <joe@nall.com>
Subject: Re: [PATCH v4 1/2] NetLabel: secid reconciliation support
Date: Wed, 4 Oct 2006 17:03:21 -0500
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 4, 2006, at 4:12 PM, Steve Grubb wrote:

> On Wednesday 04 October 2006 16:52, Paul Moore wrote:
>> I think we are all in agreement that the current xinetd patch is  
>> broken.
>>  Hopefully Steve Grubb will have fix it soon (I just added him as  
>> a CC).
>
> In my opinion, this should be in bugzilla. This is the first I  
> heard of xinetd
> being broken. LSPP issues that need quick solutions like this can  
> get lost in
> mail.

Using Eric's kernel and rawhide xinetd, I get what I expect from this  
simple test -

[joe@mls user_u:user_r:user_t:SystemLow ~]$ telnet localhost test
Trying 127.0.0.1...
Connected to localhost.localdomain (127.0.0.1).
Escape character is '^]'.
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm), 
6(disk),10(wheel) context=user_u:user_r:user_t:SystemLow
Connection closed by foreign host.

[joe@mls user_u:user_r:user_t:SystemLow ~]$ newrole -l S-S
...
[joe@mls user_u:user_r:user_t:SECRET ~]$ telnet localhost test
Trying 127.0.0.1...
Connected to localhost.localdomain (127.0.0.1).
Escape character is '^]'.
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm), 
6(disk),10(wheel) context=user_u:user_r:user_t:SECRET

Where /etc/xinetd.d/test is
service test
{
         flags           = LABELED
         socket_type     = stream
         wait            = no
         user            = root
         group           = root
         server          = /usr/bin/id
         log_on_failure  += USERID
         disable         = no
}

Can anyone provide a simple test that demonstrates how xinetd is broken?

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
