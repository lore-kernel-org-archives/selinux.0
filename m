Message-Id: <200505311412.j4VECK5F030983@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>, "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <SELinux@tycho.nsa.gov>, <dwalsh@redhat.com>
Subject: RE: file_type_auto_trans is not sufficient
Date: Tue, 31 May 2005 10:12:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1117546555.13058.14.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Ivan Gyurdiev
> Sent: Tuesday, May 31, 2005 9:36 AM
> To: Stephen Smalley
> Cc: SELinux@tycho.nsa.gov; dwalsh@redhat.com
> Subject: Re: file_type_auto_trans is not sufficient
> 
> 
> > I'd advise against creating a composite interface like this, as it runs
> > into the same problems that we had with the original SELinux API (which
> > had extended forms of mkdir/creat/mknod/exec), i.e. use of glibc
> > functions that internally use these functions, as you note in a later
> > message.
> 
> I agree, that was a bad idea.
> 
> >   Instead, keep the setting and resetting of the fscreate
> > context as a separate operation, and then let the application continue
> > to use ordinary mkdir/create/mknod or glibc functions for the actual
> > creation.
> 
> Yes, but there's problems with that - in particular:
> 
> - is this thread-safe - see my later message
> 
> - is this a good idea - it pushes dynamic type changes into various
> programs, while otherwise it's all in the policy, and easier to analyze
> 
> - makes virtually everything depend on libselinux
> 
> - I'm replicating the same code pattern in lots of places...
> 
> - it puts linux-specific code into otherwise portable apps. I've
> surrounded it all by WITH_SELINUX, but it's still rather ugly -
> don't think upstream will like it.
> 

The other option, of course, is to change the applications to use/create many
more directories, each with a separate type to allow the file_type_auto_trans
rules to work. Your orbit example might mean that there is a /tmp/orbit
directory where all orbit files are created. This may not be any more feasible,
but I think it should at least be considered.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
