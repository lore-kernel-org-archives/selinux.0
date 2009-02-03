Subject: Re: odd policy behavior
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40902030828v41f836eag84d5aaa0fa7bb899@mail.gmail.com>
References: <cadfc0e40902030828v41f836eag84d5aaa0fa7bb899@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 03 Feb 2009 11:38:02 -0500
Message-Id: <1233679082.14235.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-02-03 at 10:28 -0600, Xavier Toth wrote:
> I have an app that wasn't working in enforcing but there are no AVCs.
> So I did 'semodule -DB' to see if there were any dontaudit denials and
> restarted the app. The problem is that the app then ran fine. So I
> tried load_policy which had no affect and 'semodule -B' which makes it
> work. Any ideas what could be happening? I've verified with 'semodule
> --list' that the module is loaded prior to doing the 'semodule -B'.

- How was the app failing?
- Did you try running the app in permissive as well?
- Is this reproducible at all or are you unable to reproduce the
application failure now under any conditions?
- Did the app create/use any transient resources (temporary files,
system v ipc objects, etc) that could have prevented it from succeeding
on subsequent execution if they weren't properly cleaned up on prior
exit?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
