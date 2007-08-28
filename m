Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7S50DJK001108
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 01:00:13 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7S50BrQ007353
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 05:00:12 GMT
Received: by py-out-1112.google.com with SMTP id u77so1525231pyb
        for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 22:00:11 -0700 (PDT)
Message-ID: <8f34198c0708272200o245e1edcl47d4004f7b5fa659@mail.gmail.com>
Date: Tue, 28 Aug 2007 13:00:11 +0800
From: "Ian jonhson" <jonhson.ian@gmail.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Subject: Re: About the SELinux in FedoraCore
Cc: "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <46D2F37C.6030209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8f34198c0708250022v194622eaqb7926a1ef3508eeb@mail.gmail.com>
	 <46CFED5B.5010607@redhat.com>
	 <8f34198c0708260055t3206d9eajb5e51f9274e99f57@mail.gmail.com>
	 <46D2F37C.6030209@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank you very much~

Could you give me some example about how they do? Especially about how
the process fork its child processes and change their domain contexts.
In this case, I need not to compile the policy, right? Also, I must
predefine some contexts before the parent process do the allocation,
but if there are many contexts needed to allocate, can I predefine
them as a parameters, because I don't know how many context string I
will use ?

For example, I define them as follows:

type my_context_%d

%d is a paremeter, which can be 1,2,3,...., so I can create large
group of contexts as:

my_context_1
my_context_2
my_context_3
...
my_context_n

but not need to do the definition:

type my_context_1
type my_context_2
type my_context_3
...
type my_context_n


On 8/27/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Ian jonhson wrote:
> > It sounds very good.
> >
> > Can I change the context of object in user mode dynamically? What I
> > mean is that I can fork some processes and allocate different context
> > (or domain context) to them; so they can create their own files
> > (object) holding different file context.
> >
> > I google some references about the selinux in internet, and found many
> > cases can be dealt with by Apol, and maybe it also needs to compile
> > the policy file, right? Is it possible that I build a daemon to
> > allocate different domain context to its child processes? how to do ?
> Yes if selinux policy allows, programs can change the context of
> processes that they fork/exec.  You can also just change the context of
> the current running process, but this is not as secure.  You should ask
> your questions on the selinux@tycho.nsa.gov list
> >
> > Thank you very much for  your advices.
> >
> > Ian
> >
> >
> >
> > On 8/25/07, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > Ian jonhson wrote:
> >>>> Dear Daniel,
> >>>>
> >>>>
> >>>> I studied your wiki of FedoraCore, but still don't know how to start
> >>>> my jobs. What I want to do is:
> >>>>
> >>>> With the help of SELinux,
> >>>>
> >>>> 1. add some identity tag in subject's processes. The tag maybe is a
> >>>> integer, which can be set in SID of SELINUX.
> >>>>
> > SID are inside the kernel.  What you call tags are called security
> > contexts "strings" are used for processes and files/directories.  When
> > they are associated with a process they are sometimes called a domain.
> > When they are with a physical object they are called a file context.
> >
> >>>> 2. the tag mentioned above can be stored in local filesystem, if the
> >>>> subject's processes create his files or temporary files. In other
> >>>> words, objects (here, it is files) can hold a tag identified who
> >>>> created them.
> >>>>
> > Well in SELinux there are four parts of the security context.  The
> > SELinux user will be associated with any file created by the process
> > that creates it.  But there is also a file context.  So as an example
> >
> > system_u:system_r:smbd_t:s0 is the default security context of the
> > running sampa process.  We can set it up so that it has read/only access
> > to files/directories  labeled system_u:object_r:public_content_rw_t:s0
> > root:system_r:httpd_t:s0 is the process domain of the apache server, if
> > it had been restarted by the root SELinux user.  It could be setup with
> > read/write access to system_u:object_r:public_content_rw_t:s0, depending
> > on how the policy is setup.  If apache creates a file in a directory
> > labeled system_u:object_r:public_content_rw_t:s0, it will get a label
> > of root:object_r:public_content_rw_t:s0.
> >
> > If a third process say named running as system_u:object_r:named_t:s0
> > tries to read this file, selinux will deny it.
> >
> >
> > All three of these processes had UID=0
> >
> > Read danwalsh.livejournal.com from the beginning for a full discussion
> > of how SELinux works.
> >
> >>>> 3. when two processes with different tag access a file holding owner's
> >>>> tag, the SELINUX can distinguish the processed with different tag and
> >>>> do access control.
> >>>>
> >>>> The two processes with different tag can have different uid or,
> >>>> evenly, same uid, but their tags are not the same.
> >>>>
> >>>> How to implement these functionalities?
> >>>>
> >>>> Could you give me some advices?
> >>>>
> >>>> Thanks advance,
> >>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.7 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>
> iD8DBQFG0vN7rlYvE4MpobMRAgN/AJ9iLQnUYhuEhmuYZhEKPzZwWM/ItgCfSOBg
> i30HYwWoxY3awdVUGMXtvmI=
> =ch01
> -----END PGP SIGNATURE-----
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
