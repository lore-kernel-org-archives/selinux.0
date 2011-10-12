Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p9CJJFvI026959
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 15:19:15 -0400
Received: from webserver.magitekltd.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p9CJJE9Z007382
	for <selinux@tycho.nsa.gov>; Wed, 12 Oct 2011 19:19:14 GMT
Subject: Re: Writing a program to monitor the SELinux log
From: LC Bruzenak <lenny@MagitekLtd.com>
To: Jason Axelson <jaxelson@referentia.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <CAC9ii1q_EKnM+akoiApESQfcERYKOx+nxX7iurVPbmrgrvd2Cg@mail.gmail.com>
References: 
	 <CAC9ii1q_EKnM+akoiApESQfcERYKOx+nxX7iurVPbmrgrvd2Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Oct 2011 14:19:07 -0500
Message-ID: <1318447147.2457.179.camel@lcb>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-10-11 at 17:07 -1000, Jason Axelson wrote:

> 
> Is this a valid approach? Is there a better way?
> 
> Thanks,
> Jason

Jason,

I did this exact thing.
I named it "avcAssassin".
:)

The reason I did this is because when my group delivers a system which
cannot be easily changed, we need insurance that some untested code path
cannot launch a crippling stream of useless AVCs. After seeing this
happen, I wrote the avcAssassin code.

The way I did this is to use the same socket as used by the
SETroubleshooter but all the code is in C. I do not use the
troubleshooter for delivered system code.

I use the audit auparse C library.
I wanted it to use little CPU as possible.

So what I do is this:

Launch a process which just reads the audit stream.
Launch a child which waits for those events.
Connect them via non-blocking pipe; it's lossy on purpose. 

Parent looks for avc events and only sends timestamp and PID to child. 
Child reads avs and keeps a configurable list (default 5) of processes
generating avcs. There is a timer window (default 2 seconds) where the
child checks the counts and does something heinous (kills them) if they
are over the configurable threshold (default is 100/second). Also there
is a configurable exclusion list in case you don't want them killed.

Everything is asynchronous and non-blocking. If the pipe is full the
parent doesn't care. 

The child does all the work of matching PID to process name, counting
AVCs, submitting an audit event about it, etc. 

The idea is that in the end you have a lossy time-sliced sample of avc
events that are actionable because you have defined it that way. It's a
brutal approach but then again if you have all your policy coverage
perfect, it will not do anything. Because it is launched as a service it
can be disabled easily. Some drawbacks are that it really only works on
persistent processes. Ones which spawn rapidly and spew avcs will burden
the child process but not be detected since the PIDs will differ.

Let me know if you want the code; it isn't perfect or ready for the
world but it does perform as described (so far). 
Hopefully this helps your decision.

If you are fluent in Python (I'm not) then maybe a SETroubleshoot plugin
is a better way to go, with the benefit that it might get upstreamed.

R,
LCB

-- 
LC (Lenny) Bruzenak
lenny@magitekltd.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
