Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l43IdO5j004038
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 14:39:24 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l43IdNNE004348
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 18:39:23 GMT
Subject: Re: squid patch
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1178204426.445.64.camel@sgc.columbia.tresys.com>
References: <46278600.2010806@redhat.com>
	 <1178204426.445.64.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 14:39:15 -0400
Message-Id: <1178217555.3404.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-03 at 15:00 +0000, Christopher J. PeBenito wrote:
> On Thu, 2007-04-19 at 11:08 -0400, Daniel J Walsh wrote:
> > @@ -181,3 +184,12 @@
> >  #squid requires the following when run in diskd mode, the recommended setting
> >  allow squid_t tmpfs_t:file { read write };
> >  ') dnl end TODO
> > +
> > +optional_policy(`
> > +       apache_content_template(squid)
> > +       corenet_tcp_connect_http_cache_port(httpd_squid_script_t)
> > +       squid_read_config(httpd_squid_script_t)
> > +       allow httpd_squid_script_t self:tcp_socket create_socket_perms;
> > +       sysnet_read_config(httpd_squid_script_t)
> > +       corenet_non_ipsec_sendrecv(httpd_squid_script_t)
> > +')
> 
> This brings up a problem to which I currently don't have a good
> solution.  Due to the encapsulation, the squid module doesn't actually
> know how many types are created or their names when using
> apache_content_template(), so httpd_squid_script_t can't be used here.
> 

Yeah - there isn't really a good solution. You could argue that the
types are actually for the squid module (otherwise it would be an
interface rather than a template), but you still have the problem that a
change to the template could result in different types.

We should think about this for when interfaces are pushed into the
language.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
