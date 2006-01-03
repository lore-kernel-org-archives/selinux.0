Subject: Re: libsetrans and libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, Chad Hanson <chanson@TrustedCS.com>,
   russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <43BABE99.301@redhat.com>
References: <200601031411.13500.russell@coker.com.au>
	 <43B9FAAD.10809@redhat.com>  <43BA11DD.4000907@tresys.com>
	 <1136307978.27632.129.camel@moss-spartans.epoch.ncsc.mil>
	 <43BABE99.301@redhat.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 13:22:14 -0500
Message-Id: <1136312534.27632.146.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-01-03 at 13:12 -0500, Daniel J Walsh wrote:
> There has been some thought to making it daemon based.  And allow 
> libsetrans setup a
> unix_domain_socket to talk across.  This would allow us to implement a 
> daemon and eliminate
> the reprocessing of the file each time an application starts.  Then you 
> could just replace the daemon.

Right, at that point, one might want to just fold it into libselinux.

> > MITRE also thought it possible that their translation library could be
> > open sourced, if that would help.  Not sure how long it would take to
> > gain approval though...
> >
> >   
> I thought there might be classification problems in there also?

Not for the library itself IIUC.  Just specific configuration files that
might be used.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
