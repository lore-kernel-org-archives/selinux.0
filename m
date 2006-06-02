From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil>  <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil> <12509.1149240105@warthog.cambridge.redhat.com> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: David Howells <dhowells@redhat.com>, jmorris@redhat.com,
        selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Fri, 02 Jun 2006 14:02:05 +0100
Message-ID: <12388.1149253325@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> > I think I'd also split the second paragraph a bit.
> > 
> > Can you also wrap the text at 80 characters please?  I won't mention that
> > "labeled" should be "labelled":-)
> 
> I'm a proud American; I don't use British spelling. ;-)  Are you
> serious, though?  Is there some convention about American vs. British
> spelling in our section of the kernel?  I see both in the documentation.

I'm thinking people may see it in the document I wrote and think I'm a US-ian.
Brrr:-)

There isn't any convention on this that I know of.

> > Currently, all of the basic permissions explained above are provided in
> > SELinux as well, and are always checked before any discretionary
> > permission checks are performed.
> 
> I think you meant to reverse the last sentence, but correct me if I'm
> wrong...

Yes.  Assuming I understand what you're saying, and that "discretionary
permissions checks" are what SE Linux does, then yes, key_task_permission()
does those last.  If not, then it needs rewording rather than reversing to
make it clearer.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
