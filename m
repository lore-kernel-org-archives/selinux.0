Message-Id: <200305190212.AA00709@ilios104.ori.hitachi-sk.co.jp>
From: Yuichi Nakamura <ynakam@ori.hitachi-sk.co.jp>
Date: Mon, 19 May 2003 11:12:33 +0900
To: SELinux@tycho.nsa.gov
Cc: ynakam@ori.hitachi-sk.co.jp
Subject: Re: Compile Error of libsecure on Redhat9.0
In-Reply-To: <3EC83A0A.3070102@cpcug.org>
References: <3EC83A0A.3070102@cpcug.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I noticed that newstat.patch (attached with message  
"From: Stephen Smalley"
"Subject: Re: SELinux Compilation Error on Redhat 8.0 with  LSM 2.5" 
"Date: 02 May 2003 07:43:10"  )
may resolve this problem.

The patch was for lsm-2.5, but it seems to work also for lsm-2.4 SELinux.

Thank you.

James Griffin wrote:
>Christopher J. PeBenito wrote:
>> We encountered this on Gentoo.  It seems to be a glibc 2.3.2 problem. 
>> Once we downgraded to 2.3.1 it compiled fine.  Is 2.3.2 the version that
>> RedHat 9 is using?
>
>Yes.
>
>[artch@minerva artch]$ cat /etc/redhat-release ; rpm -q glibc
>Red Hat Linux release 9 (Shrike)
>glibc-2.3.2-27.9
>
>
>> 
>> Chris
>> 
>> On Sun, 2003-05-18 at 18:58, Yuichi Nakamura wrote:
>> 
>>>Hi.
>>>I'm researching SELinux in Japan.
>>>
>[snip]
>
>

--------------------
Yuichi Nakamura
Research&Development Department
Hitachi Software Engineering Co.,Ltd.
ynakam@ori.hitachi-sk.co.jp
http://www.selinux.hitachi-sk.co.jp/en/(SELinux Policy Editor)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
