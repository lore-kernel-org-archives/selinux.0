Subject: Re: Sendmail & SELinux policies, again
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Tanel Kokk <tanel.kokk@seb.ee>, SELinux@tycho.nsa.gov
In-Reply-To: <1144847773.29499.2.camel@sgc.columbia.tresys.com>
References: <443CB45E.5080400@seb.ee>
	 <1144845820.20422.84.camel@moss-spartans.epoch.ncsc.mil>
	 <1144847773.29499.2.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 09:23:43 -0400
Message-Id: <1144848223.20422.99.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-04-12 at 09:16 -0400, Christopher J. PeBenito wrote:
> On Wed, 2006-04-12 at 08:43 -0400, Stephen Smalley wrote:
> > On Wed, 2006-04-12 at 11:03 +0300, Tanel Kokk wrote:
> > > I just thought to add such policies for sendmail_t:
> > > 
> > > allow sendmail_t pegasus_https_port_t:tcp_socket recv_msg;
> > > allow sendmail_t mysqld_port_t:tcp_socket recv_msg;
> > > allow sendmail_t postgresql_port_t:tcp_socket recv_msg;
> > > allow sendmail_t pegasus_http_port_t:tcp_socket recv_msg;
> > > allow sendmail_t http_cache_port_t:tcp_socket recv_msg;
> > > 
> > > Is it good solusion?
> > 
> > If you just want to allow sendmail_t to receive from any port, then you
> > can just use:
> > allow sendmail_t port_type:tcp_socket { recv_msg };
> 
> > I think that the example sendmail policy does allow send_msg and
> > recv_msg to all port types (via the can_network macro).  
> 
> Both example policy and refpolicy already have this rule.  I don't know
> why you would be hitting this.

Because he rolled his own sendmail policy from scratch, since the
targeted policy in CentOS (derived from RHEL) didn't include a sendmail
policy.  Although I suspect the necessary .te files were included in
the .src.rpm, just omitted from the build.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
