Subject: Re: Can someone please assist me with selinux issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Cottle <webmaster@aus-city.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <468C2D95.2010801@aus-city.com>
References: <20070521095414.832619201@tresys.com>
	 <1180137749.10334.18.camel@localhost.localdomain>
	 <4677F1BC.2000201@tresys.com>
	 <1182443353.11527.50.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com>
	 <1182449086.11527.80.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com>
	 <1182449898.11527.83.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com>
	 <1182450900.11527.88.camel@localhost.localdomain>
	 <467AE59E.2050501@tycho.nsa.gov>
	 <1182525734.3014.20.camel@localhost.localdomain>
	 <467BFF99.9000404@tycho.nsa.gov>
	 <1182540624.6599.5.camel@localhost.localdomain>
	 <467C3728.6070803@tycho.nsa.gov>  <468904FA.7030102@tresys.com>
	 <1183386217.16330.0.camel@localhost.locald! omain>
	 <46896D88.7060504@tresys.com> <1183425133.32465.16.camel@code.and.org>
	 <468A2FE2.5000903@aus-city.com>
	 <1183464455.12218.243.camel@moss-spartans.epoch.ncs! c.mil>
	 <468C2D95.2010801@aus-city.com>
Content-Type: text/plain
Date: Thu, 05 Jul 2007 08:33:58 -0400
Message-Id: <1183638838.12218.334.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-07-05 at 09:30 +1000, David Cottle wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Thanks for the reply Stephen.  How do I enable the 'link' permission
> as you described?

In the same way you allowed the others, i.e. add link to the list of
permissions in class key in the require block and in the allow rule.

> 
> Cheers!
> 
> David
> 
> Stephen Smalley wrote:
> > On Tue, 2007-07-03 at 21:15 +1000, David Cottle wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> Hi,
> >>
> >> I got a ftp session from a IP camera sending images every 1 minute.
> >>
> >> I keep getting these AVC messages in /var/logs/messages:
> >>
> >> Jul  1 04:43:40 server kernel: audit(1183229020.232:8256): avc:
> >> denied  { link } for  pid=2043 comm="in.proftpd"
> >> scontext=system_u:system_r:ftpd_t:s0
> >> tcontext=system_u:system_r:ftpd_t:s0 tclass=key
> >> Jul  1 04:44:40 server kernel: audit(1183229080.245:8257): avc:
> >> denied  { link } for  pid=2061 comm="in.proftpd"
> >> scontext=system_u:system_r:ftpd_t:s0
> >> tcontext=system_u:system_r:ftpd_t:s0 tclass=key
> >> Jul  1 04:45:40 server kernel: audit(1183229140.367:8258): avc:
> >> denied  { link } for  pid=2259 comm="in.proftpd"
> >> scontext=system_u:system_r:ftpd_t:s0
> >> tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=key
> >> Jul  1 04:46:40 server kernel: audit(1183229200.238:8259): avc:
> >> denied  { link } for  pid=2267 comm="in.proftpd"
> >> scontext=system_u:system_r:ftpd_t:s0
> >> tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=key
> >>
> >> Every time there is a transfer.  So at 1 minute intervals there are
> >> too many.  Also I want to add more webcams so no doubt its going to
> >> get worse.
> >>
> >> However I read and created a policy:
> >>
> >> grep proftpd /var/log/messages | audit2allow -M proftpd
> >> selinux -i proftpd.pp
> >>
> >>
> >> However the above I STILL get the annoying AVC denied messages.
> >>
> >> Can someone please explain and tell me how can I update and get rid of
> >> the denied messages?
> >>
> >> This is the proftpd.te rule it made:
> >>
> >> module proftpd 1.0;
> >>
> >> require {
> >>     type ftpd_t;
> >>     type crond_t;
> >>     type httpd_suexec_t;
> >>     class capability dac_override;
> >>     class key { write search };
> >> }
> >>
> >> #============= ftpd_t ==============
> >> allow ftpd_t crond_t:key search;
> >> allow ftpd_t httpd_suexec_t:key search;
> >> allow ftpd_t self:capability dac_override;
> >> allow ftpd_t self:key { write search };
> >
> > You don't seem to be allowing "link" permission above, which is what was
> > being denied by the audit messages you posted.
> >
> >> But I see crond, httpd and ftpd all there but this rule does nothing :(
> >
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFGjC2Ui1lOcz5YUMgRAuctAJ9ud3yxGylHozKDgI3eIf3U7p1vTgCgpaem
> 3taj9Wm+FbUKTtzw1w5ksLs=
> =/2aU
> -----END PGP SIGNATURE-----
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
