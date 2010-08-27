MIME-Version: 1.0
In-Reply-To: <4C777958.4060500@ak.jp.nec.com>
References: <4C76455E.6000504@ak.jp.nec.com>
	<4C76FDD2.4070800@ak.jp.nec.com>
	<4C777958.4060500@ak.jp.nec.com>
Date: Fri, 27 Aug 2010 11:48:05 -0400
Message-ID: <AANLkTimX8uFSE_twBw9KrUQA9+U6zLCeTZN_P0N8mT_A@mail.gmail.com>
Subject: Re: [PATCH] Fast status update interface (/selinux/status)
From: Eric Paris <eparis@parisplace.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, ewalsh@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2010/8/27 KaiGai Kohei <kaigai@ak.jp.nec.com>:
> I revised the /selinux/status implementation.
>
> * It becomes to report 'deny_unknown'. Userspace object manager
>  also reference this flag to decide its behavior when the loaded
>  policy does not support expected object classes.
> * It provided PAGE_READONLY to remap_pfn_range() as page protection
>  flag independent from argument of mmap(2), but it was uncommon.
>  I fixed to pass vma->vm_page_prot instead of the hardwired flag
>  according to any other implementation style.
>  Now it returns an error, if user tries to map /selinux/status as
>  writable pages.

I really hate blowing 4k of memory on every system to show 40 bytes of
data on just a few systems.  Is there any change we could allocate the
page the first time it is needed rather that at boot?  I know compared
to the size of policy and other memory usage in SELinux it's odd for
me to complain, but I've decided to get on a reduction if possible
kick.

Only other comment is that __initcall() is deprecated and we are
supposed to use device_initcall() now.

If you plan to use it, I'll ack if you change both of those things....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
