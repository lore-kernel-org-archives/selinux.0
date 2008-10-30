Subject: Re: README in libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: selinux@tycho.nsa.gov, sakaia@jp.fujitsu.com
In-Reply-To: <4909351B.5090805@ak.jp.nec.com>
References: <4909351B.5090805@ak.jp.nec.com>
Content-Type: text/plain
Date: Thu, 30 Oct 2008 10:33:30 -0400
Message-Id: <1225377210.13709.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-10-30 at 13:16 +0900, KaiGai Kohei wrote:
> Hi,
> 
> I got a question on the secure os users mailing-list in Japan.
> He said that he is interested in sVirt patches but not good at the way
> to apply the security policy of SELinux on userspace object manager, so
> it makes him hesitate to comment for the patches.
> 
> We know great manpages are provided yet, but a structured documentation
> to implement SELinux aware userspace object managers is not well known.
> It is not unclear whether it should be included within README, or not.
> 
> However, an official guidance for developers should be considered.
> 
> Any comment?

The intent was that these papers would serve as such a reference,
although they don't necessarily go into the level of detail an
implementer might want and the interfaces have of course changed over
time:
http://www.nsa.gov/selinux/papers/gconf07-abs.cfm
http://www.nsa.gov/selinux/papers/xorg07-abs.cfm
http://www.nsa.gov/selinux/papers/radac07-abs.cfm

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
