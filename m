Date: Mon, 22 Aug 2005 05:40:56 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: hallyn@serge.ibm.com, SELinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libsepol resource leak
Message-ID: <20050822104056.GD12029@sergelap.austin.ibm.com>
References: <20050818182043.GA7622@serge.ibm.com> <1124397680.25854.168.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1124397680.25854.168.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Thu, 2005-08-18 at 13:20 -0500, hallyn@serge.ibm.com wrote:
> > (I am sending out four patches to libsepol.  Another 6 or so which I
> > investigated were not actual bugs.  This leaves me with a little over
> > half to still look at, hopefully tomorrow.  After that I'll hop to
> > libsemanage or the kernel code).
> 
> Thanks, merged.  Did you look at policycoreutils?

No, I haven't looked at that yet.  Right now I'm sorting through a
huge mess of false positives in libsepol...

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
