Subject: RE: file_type_auto_trans is not sufficient
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>, SELinux@tycho.nsa.gov,
   dwalsh@redhat.com
In-Reply-To: <1117561043.4455.1.camel@dhcp83-8.boston.redhat.com>
References: <200505311632.j4VGW95F032656@gotham.columbia.tresys.com>
	 <1117558114.4455.0.camel@dhcp83-8.boston.redhat.com>
	 <1117559223.28924.202.camel@moss-spartans.epoch.ncsc.mil>
	 <1117561043.4455.1.camel@dhcp83-8.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 31 May 2005 13:39:18 -0400
Message-Id: <1117561158.28924.211.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-31 at 13:37 -0400, Ivan Gyurdiev wrote:
> > BTW, what will per-user /tmp directories due to these conventions
> > anyway, even aside from any possible SELinux-related change?
> 
> What's the question again?

If Fedora implements private tmp directories (regardless of approach,
whether using namespaces and bind mounts ala polyinstantiated
directories or using the simple profile script suggested on fedora-
devel-list), then creating $TMPDIR/gconfd-$USER becomes rather silly, as
$TMPDIR becomes per-user anyway.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
