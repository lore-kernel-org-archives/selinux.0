Subject: Re: [PATCH] selinux: Kernel access key retention support for
	SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <12388.1149253325@warthog.cambridge.redhat.com>
References: <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil>
	 <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil>
	 <12509.1149240105@warthog.cambridge.redhat.com>
	 <12388.1149253325@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 09:08:15 -0400
Message-Id: <1149253695.524.431.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-06-02 at 14:02 +0100, David Howells wrote:
> Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:
> 
> > > I think I'd also split the second paragraph a bit.
> > > 
> > > Can you also wrap the text at 80 characters please?  I won't mention that
> > > "labeled" should be "labelled":-)
> > 
> > I'm a proud American; I don't use British spelling. ;-)  Are you
> > serious, though?  Is there some convention about American vs. British
> > spelling in our section of the kernel?  I see both in the documentation.
> 
> I'm thinking people may see it in the document I wrote and think I'm a US-ian.
> Brrr:-)
> 
> There isn't any convention on this that I know of.
> 
> > > Currently, all of the basic permissions explained above are provided in
> > > SELinux as well, and are always checked before any discretionary
> > > permission checks are performed.
> > 
> > I think you meant to reverse the last sentence, but correct me if I'm
> > wrong...
> 
> Yes.  Assuming I understand what you're saying, and that "discretionary
> permissions checks" are what SE Linux does, then yes, key_task_permission()
> does those last.  If not, then it needs rewording rather than reversing to
> make it clearer.

Discretionary access control is what the basic Linux access control
model is.  Mandatory access control is what SELinux provides.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
