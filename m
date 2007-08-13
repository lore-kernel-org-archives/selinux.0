Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7DGwFbd005076
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 12:58:15 -0400
Received: from web36606.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7DGwEDa019159
	for <selinux@tycho.nsa.gov>; Mon, 13 Aug 2007 16:58:14 GMT
Date: Mon, 13 Aug 2007 09:58:08 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 00/16] Permit filesystem local caching [try #3]
To: David Howells <dhowells@redhat.com>, casey@schaufler-ca.com
Cc: dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
        trond.myklebust@fys.uio.no, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>
In-Reply-To: <13221.1187022703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <959629.46851.qm@web36606.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- David Howells <dhowells@redhat.com> wrote:

> Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> > >   (1) int security_get_context(void **_context);
> > > 
> > > 	This allocates and gives the caller a blob that describes the current
> > > 	context of all the LSM module states attached to the current task and
> > > 	stores a pointer to it in *_context.
> > 
> > Is this intended to be anything more than a copy of current->security?
> 
> It has to be sufficient to fully effect security_push().

Which is why it requires an LSM interface. Just checking.

> > I assume that you're talking about the LSM specific data changing,
> > not the LSM itself.
> 
> Yes.
> 
> > If you change the task->security information you are definitly going
> > to change what other tasks can do to the calling task.
> 
> I dealt with that in my current act-as patch.  Under SELinux a task has two
> primary labels.  One with which it is labelled and is used to govern effects
> upon it, and one that is used to act upon things and follows changes to the
> former.

The specification of your push interface that the push operation
not affect how others access the process is OK for SELinux, but
not for any other MAC scheme that I've dealt with, and I think
that's most of them. Nuts. Smack, for example, uses exactly one
label on the process for all purposes.

Are you concerned about accesses other than signals? Signals
could be staitforward to deal with in a pushed situation, but
I'd hesitate to say that the solution would generalize without
additional thought.

> > >   (5) int security_xfrm_to_kernel_context(void *from, void **_to);
> > 
> > Woof. What are you transforming from? 
> 
> In CacheFiles case, the cachefilesd daemon's security label into the label
> the
> cache driver acts as on behalf of other processes.

I'm not sure I understand what this is doing.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
