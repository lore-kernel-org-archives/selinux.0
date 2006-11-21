Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kALEpa6d003905
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 09:51:36 -0500
Received: from wx-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kALEosKX011144
	for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 14:50:55 GMT
Received: by wx-out-0506.google.com with SMTP id t10so2304540wxc
        for <selinux@tycho.nsa.gov>; Tue, 21 Nov 2006 06:51:53 -0800 (PST)
Message-ID: <45631210.8080405@kaigai.gr.jp>
Date: Tue, 21 Nov 2006 23:49:52 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Yoshinori Sato <yo-satoh@sios.com>,
        Yuichi Nakamura <ynakam@hitachisoft.jp>
Subject: Re: Question about stat
References: <4562EFE0.5080807@kaigai.gr.jp> <1164118344.13758.101.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1164118344.13758.101.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-11-21 at 21:24 +0900, KaiGai Kohei wrote:
>> I found a strange behavior of the stat in coreutils-5.97-14.fc7.src.rpm.
>>
>> see below,
>>
>> [kaigai@masu ~]$ stat -c "%C" mytest.sql
>> (null)
>> [kaigai@masu ~]$ stat -Z -c "%C" mytest.sql
>> user_u:object_r:user_home_t:s0
>> [kaigai@masu ~]$
>>
>> Because stat command without '-Z' option doesn't try to obtain
>> the security context of the files specified, the format string
>> which contains "%C" doesn't work correctly.
>>
>> Is it expected behavior?
> 
> That sounds like a bug to me; the use of '%C' in the format string
> should implicitly enable the invocation of getfilecon.  I'd suggest
> filing a bug against coreutils in fedora devel at bugzilla.redhat.com,
> as there is no "upstream" repository presently for the coreutils selinux
> patch.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=216672

I filed it at bugzilla.redhat.com.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
