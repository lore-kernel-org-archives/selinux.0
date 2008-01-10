Subject: Re: [RFC] Obtaining PATH entry without audit userland
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Alexander Viro <aviro@redhat.com>, linux-audit@redhat.com,
        Yuichi Nakamura <ynakam@hitachisoft.jp>, SELinux@tycho.nsa.gov
In-Reply-To: <200801101040.19032.sgrubb@redhat.com>
References: <20080110172605.89A2.YNAKAM@hitachisoft.jp>
	 <200801101019.50692.sgrubb@redhat.com>
	 <20080110153237.GH16537@devserv.devel.redhat.com>
	 <200801101040.19032.sgrubb@redhat.com>
Content-Type: text/plain
Date: Thu, 10 Jan 2008 11:42:03 -0500
Message-Id: <1199983323.29816.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-01-10 at 10:40 -0500, Steve Grubb wrote:
> On Thursday 10 January 2008 10:32:37 Alexander Viro wrote:
> > On Thu, Jan 10, 2008 at 10:19:50AM -0500, Steve Grubb wrote:
> > > I was under the impression that Al Viro has already sent a patch allowing
> > > for PATH in all AVC messages. Al?
> >
> > In the mainline for quite a while...
> 
> That's what I thought.
> 
> Yuichi, what kernel are you testing against that is having the problem? Is 
> there a simple test case that shows the problem so we can check the kernel to 
> make sure its working properly?

SELinux can still only audit a pathname (vs. just the component name)
when it has the (vfsmount, dentry) pair available in the LSM hook, which
often isn't the case still.  So we still depend on audit pathname
collection to give us more information than just the component name on
many permission checks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
