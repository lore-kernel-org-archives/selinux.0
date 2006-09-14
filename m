Subject: Re: disabling selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: abcde efghi <svmdcv@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6a9b0ede0609140355i4eeb58a7na4306260bdff7d72@mail.gmail.com>
References: <6a9b0ede0609140355i4eeb58a7na4306260bdff7d72@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 08:08:12 -0400
Message-Id: <1158235692.25629.25.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-14 at 16:25 +0530, abcde efghi wrote:
> Hi
> 
> can anybody tell , how does disabling selinux dynamically, affect
> running some memory related tests (i.e memory pressure, memory leak)
> 
> i have run some tests on linux which are related to memory(stress
> tests), they failed ,bcoz i have disabled selinux during run time(it
> was enabled during installation), if i dont disable selinux it works
> fine, why so?

Not sure I understand.  Are the tests publicly available somewhere?  In
what way do they fail when SELinux is disabled?  With what kernel
version?

I don't know of any reason offhand why they would be failing in that
situation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
