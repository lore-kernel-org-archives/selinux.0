Subject: Re: Adding local nodecon's through semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Christian Kuester <c.kuester@tarent.de>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200807031032.57875.paul.moore@hp.com>
References: <486CD88E.2000406@tarent.de>
	 <200807031032.57875.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 03 Jul 2008 12:16:27 -0400
Message-Id: <1215101787.22447.461.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-07-03 at 10:32 -0400, Paul Moore wrote:
> On Thursday 03 July 2008 9:47:58 am Christian Kuester wrote:
> > Hi List,
> >
> > I had a small conversation with Stephen Smalley on the
> > fedora-selinux-list about an easy way to add
> > (local) nodecon's on a SELinux enabled system. As this is not
> > implemented in semanage yet
> > he gave me the advice to revive a discussion[1] on this list from
> > 2006. It began because a patch against
> > semanage was posted which enabled nodecon support. It seems that the
> > patch never got commited
> > because it didn't work as expected.
> 
> Hello,
> 
> I think the idea of adding network node support to semanage is a good 
> one.  Unfortunately I have no experience with python or semanage so I'm 
> probably not the best person to provide coding advice or help.
> 
> Who does look after semanage these days?

Yes, I agree that we ought to support this functionality, especially as
libsemanage already provides the interfaces even if there are lingering
issues in the implementation.

Joshua can likely help with the libsemanage/libsepol side and Dan with
the semanage front end side.

Christian - do you have a re-based copy of the patch against the svn
trunk that you were testing with?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
