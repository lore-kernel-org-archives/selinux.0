From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
Date: Mon, 24 Mar 2008 16:28:41 -0400
Cc: Steve G <linux_4ever@yahoo.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
References: <729568.16778.qm@web51505.mail.re2.yahoo.com> <1206388745.3302.88.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206388745.3302.88.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803241628.41673.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 24 March 2008 15:59:05 Stephen Smalley wrote:
> > SE Linux is the only user of the audit system that does not follow the
> > name=value standard. Would you (and the community) really be willing to
> > convert selinux over to that if we have the API for it?  Do you have any
> > suggestions about how you'd like to see the new API implemented?
>
> When the topic last came up on list, we weren't opposed to converting to
> the name=value model, just cautious about not breaking userspace in the
> process.

Sure. Completely understandable.


> As I recall, we even agreed on field names for the avc fields during the
> prior thread.  But no one followed up with actual patches to make it
> happen.

On the audit side, I implemented what we agreed on. It creates 2 fake names 
for use with values (seresult & seperm). At some point, I would recommend 
that the tools experiment with switching over to the auparse library. If that 
happens, then we can change the actual format since auparse is already 
providing the illusion of name=value for all of selinux.

I recommend experimenting with switching over for a couple other reasons. At 
some point we'll start zipping the logs. That will break existing tools 
unless they are gzip aware. And people have been talking about adding 
database support for audit records. If people store events that way, we'll 
have auparse updated to extract events. Its yet another hurdle for the tools 
doing their own parsing.

This isn't likely to happen for another month or two so there is time to 
experiment. What I am concerned about right now, though, is what to do about 
user space AVCs since that is needing some work.  :)

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
