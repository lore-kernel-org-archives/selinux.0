Date: Fri, 17 Aug 2001 12:42:13 +0100
From: Dale Amon <amon@vnl.com>
To: Conan Callen <ccallen@windowpane.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Partial TOC for Comment]
Message-ID: <20010817124213.Q18183@vnl.com>
References: <3B7C7C69.E7B84C68@earthlink.net> <003f01c12746$e02faf60$3a8314d1@nwlink.com> <3B7D75C0.23A2B9C9@earthlink.net> <005501c12758$95f6cf70$3a8314d1@nwlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <005501c12758$95f6cf70$3a8314d1@nwlink.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 17, 2001 at 01:09:56PM -0700, Conan Callen wrote:

> On a different topic (installing linux and immediatly getting cracked):
> An interesting note. As soon as I finished installing Linux lastnight, I
> noticed the hard drive start whirling like someone was there doing searches
> of my hard drive. This morning I got the same thing. I ran ps -aux and could
> see a process as root running a something like ls | awk ... looking for
> different things. I didnt take time to write it down, I just shut the
> machine down.
> 

For the answer to your question, look at /etc/cron.*.

At various times of the wee hours, certain internal databases
are updated, in particular the locate db and the man db.

There are other cleanup tasks that occur as well.

I don't think you were hacked.

------------------------------------------------------
Use Linux: A computer        Dale Amon, CEO/MD
is a terrible thing          Village Networking Ltd
to waste.                    Belfast, Northern Ireland
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
