Subject: Re: [PATCH 4/4] SELinux: allow userspace to read policy back out
 of the kernel
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Casey Schaufler
 <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org
In-Reply-To: <1276706472.17827.35.camel@moss-pluto.epoch.ncsc.mil>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
	 <1276526926.8863.23.camel@moss-pluto.epoch.ncsc.mil>
	 <1276528366.2749.3.camel@localhost>  <4C17049D.6090106@schaufler-ca.com>
	 <1276612389.2749.38.camel@localhost>
	 <1276700025.17827.29.camel@moss-pluto.epoch.ncsc.mil>
	 <1276701977.2749.51.camel@localhost>
	 <1276706472.17827.35.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Jun 2010 12:58:41 -0400
Message-ID: <1276707521.2749.52.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-06-16 at 12:41 -0400, Stephen Smalley wrote:
> On Wed, 2010-06-16 at 11:26 -0400, Eric Paris wrote:

> > No question wrapping my head around the new ebitmap format was the tough
> > part.  I added printk's to display every ebitmap and node as it was read
> > in and as I wrote them out.  Got the same thing for the couple thousand
> > lines I could show in dmesg, so I think I'm ok there.
> > 
> > I was trying to use gdb yesterday to figure out what was wrong, but
> > could get the darn thing to break where I wanted it to.  I'll debug like
> > I'm used to (in the kernel) and see what I did....
> 
> Oh, I found it.  mls_write_level() in your patch sets buf[1] rather than
> buf[0] and then writes buf[0].

/me feels like the compiler should have been able to find that
particular one....


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
