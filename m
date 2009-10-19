Subject: Re: bounds domain
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <bb74313d0910190251w21117682p59d42db26b3f0191@mail.gmail.com>
References: <bb74313d0910170111r1fd7f59cl3556e59be1d2f7a8@mail.gmail.com>
	 <4ADBF832.8070001@ak.jp.nec.com>
	 <bb74313d0910190251w21117682p59d42db26b3f0191@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 19 Oct 2009 09:57:39 -0400
Message-Id: <1255960659.3099.10.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-10-19 at 13:21 +0330, michel m wrote:
> this is exactly what I am going to do. that is, I have  userspace some
> shared objects that I need to control my threads access to these
> objects. but I don`t know if I should consult AVC myself in userspace
> per access (because as we both agree that my userspace threads`
> context is bounded by my OS process)or SELinus does this for me
> itself.

If your threads are accessing kernel objects (e.g. files, sockets, etc),
then you can let the kernel perform the mediation based on the thread's
security context.  If your application is managing some
objects/abstractions of its own that do not map directly to kernel
objects (e.g. windows as in Xorg, connections as in DBus, database
records as in PostGres), then it needs to act as a userspace object
manager.

> I think it seems logical that since kernel doesnot know any thing
> about my threads(e.g. pthreads) I should have some hooks that consult
> SELinux when needed.how do you think? but here comes another question,
> if my thread were kernel level, would I need hooks for controling my
> threads access to userspace shared objects?
> 
> as the last question, I want to know, in a multithreaded process,
> which uses M:1 model, if access requests from threads to OS , are
> delivered by that single process or if not, how is it done?

On modern Linux distributions (with the Linux 2.6 kernel and the NPTL
library), the threading model is 1:1, and thus the kernel can directly
enforce the per-thread restrictions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
