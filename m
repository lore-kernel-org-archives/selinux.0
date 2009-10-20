Subject: Re: bounds domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <bb74313d0910200925o730bd5dfj627449e483c72f1f@mail.gmail.com>
References: <bb74313d0910170111r1fd7f59cl3556e59be1d2f7a8@mail.gmail.com>
	 <4ADBF832.8070001@ak.jp.nec.com>
	 <bb74313d0910190251w21117682p59d42db26b3f0191@mail.gmail.com>
	 <1255960659.3099.10.camel@moss-pluto.epoch.ncsc.mil>
	 <bb74313d0910200925o730bd5dfj627449e483c72f1f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Oct 2009 12:56:29 -0400
Message-Id: <1256057789.4061.134.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-10-20 at 19:55 +0330, michel m wrote:
> thanks for your guidance,
> if we turn our attention into Java virtual machine(JVM), I want to
> have an access control on conceptual java threads that are
> encapsulated inside jvm, so I need to know which kernel managed
> process, these threads are mapped to. Is there such a mapping at all?
> if yes, how is it?
> 
> I am going to manage java objects and java threads access to these
> objects. If I want to use setcon() API by JNI, I don`t know what will
> be labeled? Does a kernel thread get labeled or jvm process will be
> labeled?

Doesn't really make sense to do that in Java without Isolates (JSR 121).

setcon(3) acts on the current kernel thread only.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
