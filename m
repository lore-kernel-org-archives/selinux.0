Subject: RE: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs,
	sshd,	and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Klaus Weidner <klaus@atsec.com>, James Antill <jantill@redhat.com>,
        Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 10:55:27 -0500
Message-Id: <1168012527.18961.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-01-04 at 22:35 -0500, Joshua Brindle wrote:
> > From: Klaus Weidner [mailto:klaus@atsec.com] 
> > 
> > On Thu, Jan 04, 2007 at 10:05:57PM -0500, Joshua Brindle wrote:
> > > Hardcoding types into code makes it inflexible to policy 
> > changes, this 
> > > is a bad idea IMO, the tty whitelist, however, is probably 
> > the way to 
> > > go. I don't know if we should use the existing 
> > /etc/securetty or  add 
> > > our own file though.
> > 
> > I'm not sure if the existing /etc/securetty is the right one, 
> > since people may make serial terminals available to users but 
> > would not want direct root login on those. Well, maybe not 
> > terribly likely these days.
> > 
> > Instead of hardcoded types, how about a configurable type or 
> > a /etc/securettytypes file that contains the types instead of 
> > tty names?
> 
> Sure, the securettycontexts might be the way to go. I'm dubious about
> just making this happen for level changes though, you shouldn't be able
> to bypass any part of the security policy using newrole.

We don't want to break newrole -r on a pty.  

(issue is that there are two ends for a pty, master and slave, and only
the slave end is relabeled by newrole.  master end is always /dev/ptmx
wrt the inode, only the open file is per instance IIUC).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
