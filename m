MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: odd policy behavior
Date: Mon, 9 Feb 2009 11:07:23 -0500
Message-ID: <170D6ABBBA770349AA49582A86FCED15B25292@HAVOC.tcs-sec.com>
References: <cadfc0e40902030828v41f836eag84d5aaa0fa7bb899@mail.gmail.com> <1233679082.14235.21.camel@localhost.localdomain> <cadfc0e40902031159r55a12a02u46b0dde8f9356460@mail.gmail.com> <1233696489.14235.28.camel@localhost.localdomain> <cadfc0e40902031349w3c4d3abdgb5c7f5b5107a4001@mail.gmail.com> <cadfc0e40902031431w5532857fq2ecfd9485dfb26ee@mail.gmail.com> <1233755713.30244.7.camel@localhost.localdomain> <4989BE58.60408@redhat.com> <1233764068.30244.23.camel@localhost.localdomain>
From: <chanson@TrustedCS.com>
To: <sds@tycho.nsa.gov>, <dwalsh@redhat.com>
Cc: <txtoth@gmail.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
> > >> The plot thickens. semodule -B causes seusers to be relabeled
> > >> SystemLow. restorecon /etc/selinux/mls/seusers causes the file to
be
> > >> relabeled SystemHigh. Which is right?
> > > 
> > > I don't think that semodule/libsemanage explicitly set the context
of
> > > files they create, so they would just follow the default policy
behavior
> > > (in this case, inheriting the level of the creating process and
the type
> > > of the parent directory).
> > > 
> > > restorecon just applies whatever the file_contexts configuration
> > > specifies, which appears to be SystemHigh in the mls policy.  I'm
not
> > > sure if that is truly justified.
> > > 
> > Since all the login programs have to read this file it should be at
the
> > SystemLow, So that a login program running at a SystemLow can work.
> 
> Makes sense to me, but I assume that someone thought otherwise or it
> wouldn't have been marked as SystemHigh in the first place?  Does the
> LSPP impose a particular restriction on it?  There are
> other /etc/selinux files in file_contexts as well that are marked with
> SystemHigh (or to be precise, s15:c0.c1023) in the -mls policy.

I agree that the SystemHigh labeling of this file is probably overkill,
but we may have erred on the conservative side. I can see how this gets
in the way of getseuserbyname(). The RHEL 5.1 LSPP Configuration Guide
is a bit murky in this area. Section 4.3 states the administrator should
pick SystemLow or SystemHigh for administrative actions as well a note
for SystemLow for system administration. As noted above, the seusers
will get created at SystemLow or SystemHigh depending on the process
label when executing 'semodule -B'. The restorecon settings of the
policy can cause a a couple of problems. We perform policy management at
SystemHigh and have different inconsistencies, than seusers, with
restorecon based on running at SystemHigh. The other issue with the
restorecon is that the SELinux User will for the policy files will
always be different than the 'system_u' defined for the file after
running 'semodule -B' as 'staff_u' for example. This can be a problem if
you are storing SELinux attributes for integrity purposes or checking
them with restorecon.

-Chad


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
