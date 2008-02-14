Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1E4QP55032022
	for <selinux@tycho.nsa.gov>; Wed, 13 Feb 2008 23:26:25 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1E4QNY2001165
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 04:26:23 GMT
Date: Thu, 14 Feb 2008 15:25:54 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Justin Mattock <justinmattock@gmail.com>
cc: selinux@tycho.nsa.gov, Arjan van de Ven <arjan@infradead.org>
Subject: SELinux power consumption (was Re: s.m.a.c.k)
In-Reply-To: <dd18b0c30802131822v3a7dd93bkba75363d65c262df@mail.gmail.com>
Message-ID: <Xine.LNX.4.64.0802141523010.10898@us.intercode.com.au>
References: <dd18b0c30802131822v3a7dd93bkba75363d65c262df@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Feb 2008, Justin Mattock wrote:

> I had a quick question about power consumption, I've been doing a lot of
> testing and seem to find no signs of SELinux or audit causing any wakeups at
> all to the processor, but then googling some web site I came acrossed  said
> there was a 7% overhead of energy or something in this area. What info do
> you have in the area of power consumption, wakeups to the processor or load
> on the processor with SELinux or audit that I should be aware of while Im
> doing some testing?

IIRC, this was something like the setroubleshoot desktop applet, and I'm 
not sure if it was fixed or not.  If not, it needs to be.

(cc'd Arjan, who I think discovered the issue).


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
