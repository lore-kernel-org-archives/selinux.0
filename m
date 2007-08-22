Message-ID: <46CBB0B7.2080503@ak.jp.nec.com>
Date: Wed, 22 Aug 2007 12:42:47 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Yuichi Nakamura <ynakam@hitachisoft.jp>
CC: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, busybox@kaigai.gr.jp,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [patch] Tuning avtab to reduce memory usage
References: <20070821130540.7AD3.YNAKAM@hitachisoft.jp> <Xine.LNX.4.64.0708210645130.16813@us.intercode.com.au> <20070822115145.E7D3.YNAKAM@hitachisoft.jp>
In-Reply-To: <20070822115145.E7D3.YNAKAM@hitachisoft.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Yuichi Nakamura wrote:
> On Tue, 21 Aug 2007 07:00:56 -0700 (PDT)
> James Morris  wrote:
>> On Tue, 21 Aug 2007, Yuichi Nakamura wrote:
>>
>>> Hi.
>>>
>>> I would like to propose patch that reduce memory usage of avtab again.
>> This looks good, although there are some coding style and other issues 
>> which need to be fixed.  Also see Documentation/SubmittingPatches and 
>> Documentation/CodingStyle in the kernel tree.
> Thanks for review !

FYI.

These documents are also translated into Japanese language.

http://www.linux.or.jp/JF/JFdocs/kernel-docs-2.6/SubmittingPatches.html
http://www.linux.or.jp/JF/JFdocs/kernel-docs-2.6/CodingStyle.html

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
