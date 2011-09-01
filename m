Message-ID: <4E5FD095.3020900@manicmethod.com>
Date: Thu, 01 Sep 2011 14:36:05 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Kohei Kaigai <Kohei.Kaigai@EMEA.NEC.COM>
CC: Kohei KaiGai <kaigai@kaigai.gr.jp>, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: sepgsql and process transition
References: <4E5D2DBA.9060201@manicmethod.com> <CADyhKSVBhXHsfyXVkWZxuJqAZ9-QgPjfhPZOdGyfBEEGb-iVbA@mail.gmail.com> <4E5E933B.6060604@manicmethod.com> <CADyhKSVcA2LtxMnVvcAZ5zvWbs8E=RtFrV9bvLYo6ukDpRYc-Q@mail.gmail.com> <D0C1A1F8BF513F469926E6C71461D9EC051E85@EX10MBX02.EU.NEC.COM> <4E5F9921.6020102@manicmethod.com> <D0C1A1F8BF513F469926E6C71461D9EC0523B8@EX10MBX02.EU.NEC.COM>
In-Reply-To: <D0C1A1F8BF513F469926E6C71461D9EC0523B8@EX10MBX02.EU.NEC.COM>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kohei Kaigai wrote:
<snip>
>> trusted procedures are not processes and should not use the process object class.
>>
> We may need to have an upper meta-level viewpoint.
>
> When a subject entity appeared in operating system, we call it "process".
> When a subject entity appeared in database system, we call it something like "db_client".
> And, a subject entity appeared in operating system tries to access database objects,
> its security label is dealt with "db_client" class. Hmm.
>

It isn't that surprising. When processes create sockets they are labeled as the 
process label by default, files in /proc/<pid> are labeled as the process label. 
Just because the label is the same doesn't mean the object class is.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
