Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: Valdis.Kletnieks@vt.edu, casey@schaufler-ca.com, redhat-lspp@redhat.com,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200610280904.25797.russell@coker.com.au>
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
	 <200610201700.31748.russell@coker.com.au>
	 <200610271536.k9RFactr013813@turing-police.cc.vt.edu>
	 <200610280904.25797.russell@coker.com.au>
Content-Type: text/plain
Date: Tue, 31 Oct 2006 09:29:22 -0500
Message-Id: <1162304962.32614.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-10-28 at 09:04 +1000, Russell Coker wrote:
> On Saturday 28 October 2006 01:36, Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 20 Oct 2006 17:00:28 +1000, Russell Coker said:
> > > On Thursday 19 October 2006 23:21, Daniel J Walsh <dwalsh@redhat.com> 
> wrote:
> > > > If we then remove -l from newrole we are done?
> > >
> > > Why remove it?  Why not just cease using it and leave it there for other
> > > people who have different needs?
> >
> > I suspect that it wouldn't fly during an eval, because even if unused, it
> 
> OK.
> 
> Well #if 0 would still be better than removing the code.  This is something we 
> may want to resurrect at a later time.

It isn't being removed, at least not upstream.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
