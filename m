Subject: Re: How can I know violations in denied timing ?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820809010206w21a07f7fya77e4ac89d6f938f@mail.gmail.com>
References: <f71a82820809010206w21a07f7fya77e4ac89d6f938f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 02 Sep 2008 09:01:15 -0400
Message-Id: <1220360475.26711.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-09-01 at 18:06 +0900, Shintaro Fujiwara wrote:
> Hello, I'm Shintaro, Fujiwara writer of segatex.
> 
> I wrote a small c program in latest segatex which pops up a widget
> when violation occurs but, 
> it only reads audit.log and make another file and periodically compare
> old one and new one.
> If new one differs from old one, it pops up a widget.
> 
> But what I really want to do is that something like setroubleshoot,
> which I imagine reads kernel directly.
> 
> I'm making segatex not to alternate Redhat's one, but for my own
> pleasure and my study.
> 
> I have no experiences reading kernel and don't know how to read kernel
> files at all.
> 
> So, if you have time to spare for me, please let me know how to read
> kernel files.
> 
> This time, I want to make a small program like setroubleshoot.
> 
> Thank you very much in advance.

I believe that setroubleshootd uses an audispd (audit dispatcher) plugin
in order to directly receive copies of audit messages in "real time".
Given that setroubleshootd source code is readily available, you should
be able to study it.  You don't need to directly read the audit log
file, nor should you do so.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
