Subject: RE: Denials from newest kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joy Latten <latten@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <1160149463.2905.5.camel@twoface.columbia.tresys.com>
References: <36282A1733C57546BE392885C0618592015CFC0C@chaos.tcs.tcs-sec.com>
	 <1160148117.12253.106.camel@moss-spartans.epoch.ncsc.mil>
	 <1160149463.2905.5.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 11:56:19 -0400
Message-Id: <1160150179.12253.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 11:44 -0400, Joshua Brindle wrote:
> > Renaming them doesn't really help.  Classes have always been a fairly
> > artificial construct, and you can see that already in the existing
> > checks prior to this work.
> > 
> 
> Renaming does help, classes may be artificial but the target context
> *should* be an object that is represented by the target object class. It
> was very confusing writing rules (and seeing denials) where there is no
> such object of the tclass type that was labeled with tcon.

But in the case where an object inherits the label of another object,
that is to be expected - we will end up seeing "packets" with the labels
of associations, which in turn are labels of sockets, which in turn are
(usually) labels of processes.  No need to turn every check on a
"packet" into a check on some original class from which its label was
derived.

Also, the above isn't true of all checks, e.g.
	allow ftpd_t ftp_port_t:tcp_socket name_bind;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
