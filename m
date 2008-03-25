Subject: Re: avc's
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30803250831i36f92d9fv5fa5b1b532cb9f8@mail.gmail.com>
References: <dd18b0c30803250831i36f92d9fv5fa5b1b532cb9f8@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 25 Mar 2008 12:35:18 -0400
Message-Id: <1206462918.3302.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-03-25 at 15:31 +0000, Justin Mattock wrote:
> Hello; I've noticed with using the latest refpolicy(svn) and kernel,
> after the policy compile and then a reboot im only receiving a few(10
> or so) avc's,
> then after I go and allow those avc's and reboot the next ten or so
> would appear. Is this something with the kernel, or libraries.
> when I issue dmesg it gives me something about: 200 messages
> suppressed. I thought it was because of the refpolicy being in svn and
> under heavy development, but I tried a stable refpolicy and received
> the same results.

Two observations:
1) Often a program will stop processing when it first hits a denial.  So
you might get one set of denials and then when you add allow rules for
those denials, that allows the program to proceed further, but it may
encounter later denials on different actions.  So what you describe can
be normal.
2) Since you said something about messages being suppressed, you might
be encountering the printk ratelimit.  That is to avoid flooding the
system log.  You can change it by writing
to /proc/sys/kernel/printk_ratelimit; a value of 0 should disable rate
limiting but this can lead to a denial of service.  Alternatively,
consider installing and using auditd to handle your audit messages.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
