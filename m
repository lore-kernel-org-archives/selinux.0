Subject: Re: disabling selinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: abcde efghi <svmdcv@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6a9b0ede0609190031p7f7610cfy87d8c54ab90a32d4@mail.gmail.com>
References: <6a9b0ede0609140355i4eeb58a7na4306260bdff7d72@mail.gmail.com>
	 <1158235692.25629.25.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609142230u6db9a10fqf4f4059e7a90695e@mail.gmail.com>
	 <1158337309.18951.9.camel@moss-spartans.epoch.ncsc.mil>
	 <6a9b0ede0609190031p7f7610cfy87d8c54ab90a32d4@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 09:09:14 -0400
Message-Id: <1158671354.15340.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-19 at 13:01 +0530, abcde efghi wrote:
> my tests are failing bcoz i have disabled selinux post-install
> should i do any changes to filesystems then also?
> and what other things i need to do once i disable selinux which  was
> enabled during installation?

- What tests?
- How are they failing?
- What makes you think it has anything to do with SELinux?
- If you disable SELinux, then it is disabled.  End of story.  Nothing
more to do.  
- If you want to re-enable SELinux, you will need to relabel your
filesystems.
- You can check the status of SELinux by running /usr/sbin/sestatus.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
