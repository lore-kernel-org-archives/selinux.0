Subject: Re: Semanage for domain transitions
From: Martin Spinassi <martins.listz@gmail.com>
Reply-To: martins.listz@gmail.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1272907389.20339.128.camel@moss-pluto.epoch.ncsc.mil>
References: <1272905395.2206.7.camel@localhost>
	 <1272907389.20339.128.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 May 2010 12:17:47 -0300
Message-ID: <1272986267.2603.13.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-05-03 at 13:23 -0400, Stephen Smalley wrote:
> On Mon, 2010-05-03 at 13:49 -0300, Martin Spinassi wrote:
> > Hi list!
> > 
> > 
> > I'm trying to figure out how to make domain transition using semanage or
> > any userland command.
> > 
> > My problem is that I've just compiled a new version of memcached, and
> > configured it to use the sock file /tmp/memcached.sock, but httpd can't
> > write to it. The scontext is httpd_t, and the dcontext is tmp_t.
> > 
> > Probably later I'll make a context for memcached, but by now, I've just
> > find out that I don't really know how to make a domiain transition
> > without having to install selinux source policy, and that's something
> > that I'm really trying to avoid.
> > 
> > Any link/doc/tip is really appreciated.
> 
> You can create a local policy module without needing to install the
> sources for the base policy.
> 
> In simplest form, this might look like:
> 
> $ cat mymemcached.te
> policy_module(mymemcached, 1.0)
> require {
> 	type httpd_t, tmp_t, httpd_tmp_t;
> }
> type_transition httpd_t tmp_t:sock_file httpd_tmp_t;
> allow httpd_t httpd_tmp_t:sock_file { create open read write unlink };
> 
> $ make -f /usr/share/selinux/devel/Makefile mymemcached.pp
> $ sudo semodule -i mymemcached.pp


Stephan,

Thank you for your mail!
You answered me, and also sent me the example! I really appreciate it.

It's working perfect now. 

Best regards,

Martin



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
