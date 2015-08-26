Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7QEwiSi019082
 for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2015 10:58:45 -0400
Received: by oiey141 with SMTP id y141so122933652oie.1
 for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2015 07:58:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150826143203.GB26572@x250>
References: <9421874.fduThv0mJV@sifl>
	<20150826143203.GB26572@x250>
Date: Wed, 26 Aug 2015 10:58:42 -0400
Message-ID: <CAHC9VhT0yLEFfuHZpdTj9u9y5Ypw7ACyL418hXzRRMr3VoFKcA@mail.gmail.com>
Subject: Re: My notes on the 2015 Linux Security Summit
From: Paul Moore <paul@paul-moore.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Aug 26, 2015 at 10:32 AM, Dominick Grift <dac.override@gmail.com> wrote:
> ... I wish there were recordings of the various talk.

You are not the first person to request recordings, I don't think
anyone would be opposed to recording the sessions, but as usual it is
a matter of resources.  Perhaps we will be able to record the sessions
in the future.

> ... your talk about linux-audit is seems interesting and timely to me.
> Especially Since we currently have two audit daemons in Fedora by default,
> and people who actually use audit in a meaningful way know how io-intensive
> it can be. Let alone logging everything twice...

To be clear, we don't have two auditd instances running by default, we
have one auditd instance and the systemd-journald service; although I
admit this is a minor distinction from a performance point of view.  I
personally think that both solutions have merit for different reasons,
but I agree that it is doubtful most users would want both running at
the same time.  I know we have a bugzilla open against the systemd
journal to better handle auditing, although I haven't looked at it
lately to see where things stand.

Hopefully over the course of this next year you will start to see some
internal improvements to audit which will pave the way for more
visible functional and performance improvements.

-- 
paul moore
www.paul-moore.com
