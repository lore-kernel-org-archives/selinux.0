Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1149253695.524.431.camel@moss-spartans.epoch.ncsc.mil>
References: <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil>
	 <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil>
	 <12509.1149240105@warthog.cambridge.redhat.com>
	 <12388.1149253325@warthog.cambridge.redhat.com>
	 <1149253695.524.431.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 09:28:38 -0400
Message-Id: <1149254918.524.441.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-02 at 09:08 -0400, Stephen Smalley wrote:
> On Fri, 2006-06-02 at 14:02 +0100, David Howells wrote:
> > Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:
> > 
> > > > I think I'd also split the second paragraph a bit.
> > > > 
> > > > Can you also wrap the text at 80 characters please?  I won't mention that
> > > > "labeled" should be "labelled":-)
> > > 
> > > I'm a proud American; I don't use British spelling. ;-)  Are you
> > > serious, though?  Is there some convention about American vs. British
> > > spelling in our section of the kernel?  I see both in the documentation.
> > 
> > I'm thinking people may see it in the document I wrote and think I'm a US-ian.
> > Brrr:-)
> > 
> > There isn't any convention on this that I know of.
> > 
> > > > Currently, all of the basic permissions explained above are provided in
> > > > SELinux as well, and are always checked before any discretionary
> > > > permission checks are performed.
> > > 
> > > I think you meant to reverse the last sentence, but correct me if I'm
> > > wrong...
> > 
> > Yes.  Assuming I understand what you're saying, and that "discretionary
> > permissions checks" are what SE Linux does, then yes, key_task_permission()
> > does those last.  If not, then it needs rewording rather than reversing to
> > make it clearer.
> 
> Discretionary access control is what the basic Linux access control
> model is.  Mandatory access control is what SELinux provides.

So to clarify:  SELinux is presently performing a parallel MAC
permission check for each existing DAC permission check, and the MAC
check occurs after the DAC check (and only occurs if the DAC check
succeeds).  

Also, to clarify re label(l)ing, each key is labeled based on the
creating task's security context, which doesn't necessarily have
anything to do with "belonging" or "possesssion", and the label remains
invariant for the lifetime of the key (non-tranquility).  An extended
interface will be added via subsequent patch to permit keys to be
created with a specified security context (using the existing model
of /proc/self/attr) so that the login managers can create keys based on
the session security context rather than based on their own security
context.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
