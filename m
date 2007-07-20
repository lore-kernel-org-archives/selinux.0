Subject: Re: [Fwd: cups AVC...]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Line.LNX.4.64.0707201045520.7144@d.namei>
References: <46A0C494.7060000@redhat.com>
	 <1184941981.17338.801.camel@moss-spartans.epoch.ncsc.mil>
	 <Line.LNX.4.64.0707201045520.7144@d.namei>
Content-Type: text/plain
Date: Fri, 20 Jul 2007 11:12:30 -0400
Message-Id: <1184944350.17338.813.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-07-20 at 10:46 -0400, James Morris wrote:
> On Fri, 20 Jul 2007, Stephen Smalley wrote:
> 
> > Yuck.  We need a better way to handle these things, to avoid having to
> > touch policy configuration each time a new pseudo fs type is introduced.
> > Possibly the file_system_type structure could also specify labeling
> > behavior for security modules.
> 
> What about some way of recognising that there is no policy at all for the 
> fstype, and just allowing the access (with a warning) ?

What, fail open?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
