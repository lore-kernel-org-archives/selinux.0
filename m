Subject: Re: s.m.a.c.k
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30802131822v3a7dd93bkba75363d65c262df@mail.gmail.com>
References: <dd18b0c30802131822v3a7dd93bkba75363d65c262df@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Feb 2008 07:31:47 -0500
Message-Id: <1202992307.16038.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-14 at 02:22 +0000, Justin Mattock wrote:
> Hello; Thanks for the info on s.m.a.c.k, ("I thought it was part of
> SELinux");  it seems similar to apparmour!  I think I'll stick with
> SELinux. 
> I had a quick question about power consumption, I've been doing a lot
> of testing and seem to find no signs of SELinux or audit causing any
> wakeups at all to the processor, but then googling some web site I
> came acrossed  said there was a 7% overhead of energy or something in
> this area. What info do you have in the area of power consumption,
> wakeups to the processor or load on the processor with SELinux or
> audit that I should be aware of while Im doing some testing?
> regards;

Smack is quite different from AppArmor, but also quite different from
SELinux.

SELinux imposes a performance overhead, but it shouldn't especially
affect power consumption.  You might be thinking of bugs in certain
SELinux-related daemons, like setroubleshootd in Fedora, that caused it
to spin.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
