Subject: Re: About security field in struct sk_buff
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Park Lee <parklee_sel@yahoo.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20041224183055.44205.qmail@web51507.mail.yahoo.com>
References: <20041224183055.44205.qmail@web51507.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1104156347.15615.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 27 Dec 2004 09:05:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-12-24 at 13:30, Park Lee wrote:
> Hi,
>  In /usr/src/linux/security/selinux/include/objsec.h,
> there seems no SELinux security data structure for
> struct sk_buff.
>   Does this means that SELinux doesn't use the
> security field (i.e. the unsigned short security) in
> struct sk_buff at all?

As with your other question, please do not post the same question to all
three lists (selinux, fedora-selinux-list, linux-security-module).  Just
pick the most appropriate one (in this case, I'd say just selinux) and
wait for an answer.

I've explained previously that we had to drop the sk_buff security field
and hooks because it wasn't accepted into the mainline Linux 2.6
kernel.  The unsigned short security field isn't related to LSM, and
isn't useable for it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
