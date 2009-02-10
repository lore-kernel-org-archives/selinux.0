Date: Tue, 10 Feb 2009 15:44:32 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: problem with capabilities inheritance and auditing in python
Message-ID: <20090210214432.GC11776@us.ibm.com>
References: <1233857436.3181.40.camel@localhost.localdomain> <cadfc0e40902061356u466495ccyc471328485e2e80e@mail.gmail.com> <1234188170.28831.10.camel@localhost.localdomain> <cadfc0e40902090842i2a62ab85ucb6bfb0e9ee5a4be@mail.gmail.com> <1234210633.28831.87.camel@localhost.localdomain> <20090209204200.GA25401@us.ibm.com> <cadfc0e40902100900n12d116b2m7b1c5db4ae43c9d@mail.gmail.com> <20090210183438.GA14133@us.ibm.com> <cadfc0e40902101220o7c7b162v84cbbfb264a7c980@mail.gmail.com> <1234301146.7397.45.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1234301146.7397.45.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Tue, 2009-02-10 at 14:20 -0600, Xavier Toth wrote:
> > On Tue, Feb 10, 2009 at 12:34 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > > Quoting Xavier Toth (txtoth@gmail.com):
> > >> I was not putting capabilities on the script but rather on a compiled
> > >> wrapper which execs a python script in which I need to do auditing.
> > >> Will this not work?
> > >
> > > No, because of the way capabilities are re-calculated on exec().
> > >
> > >        pI' = pI
> > >        pP' = (X&fP) | (pI & fI)
> > >        pE' = fE ? pP' : 0
> > >
> > > So since the interpreter has fI=fP=fE=0 and is not setuid root (which
> > > would fill in fP and/or fE to emulate privileged root), pP' and pE' will
> > > be empty after exec().
> > >
> > > Now you could use a wrapper as follows:  Have the wrapper fill pI,
> > > and then fill fI on the python interpreter.  Any user who has an
> > > empty pI (which generally is all users) will execute python scripts
> > > with no privilege, but when the wrapper execs the script, pP' will
> > > be filled with (pI&fI) = full.
> > >
> > > -serge
> > >
> > 
> > Thanks for the clarification.
> > For anyone one that is interested I've included some test code. The
> > wrapper is a modified version of a wrapper Stephen sent me a link to.
> > Basic steps to test are:
> > 1) edit the wrapper to set the path to the audit_test.py script
> > 2) compiler the wrapper
> >     gcc -o audit-wrapper audit-wrapper.c -lcap
> > 3) set the capabilities on the wrapper and python
> >     setcap cap_audit_write,cap_setfcap=epi audit-wrapper
> >     setcap cap_audit_write=ei /usr/bin/python
> > 4) run audit-wrapper
> > 5) check audit log for audit records.
> > 
> > I also ran audit_test.py without the wrapper to verify that no audit
> > would occur.
> > 
> > Ted
> > 
> > ------------------------------------------------------------------------------
> > audit-wrapper.c
> > ------------------------------------------------------------------------
> > 
> <snip>
> > 	cap_t cur = cap_from_text("cap_audit_write+i");
> > 	int ret = cap_set_proc(cur);
> > 	if (ret) {
> > 		perror("cap_set_proc");
> > 		return 1;
> > 	}
> > 	cap_free(cur);
> 
> Looks like you could make your wrapper generic for any capabilities by
> having it copy the permitted (or effective) set to the inheritable set.
> Something like this:
> 	cap_t cur = cap_get_proc();
> 	cap_value_t caps[1];
> 	cap_flag_value_t value;
> 	int i, rc;
> 	for (i = 0; i < CAP_LAST_CAP; i++) {
> 		rc = cap_get_flag(cur, i, CAP_PERMITTED, &value);
> 		if (rc < 0) {
> 			perror("cap_get_flag");
> 			return 1;
> 		}
> 		caps[0] = i;
> 		rc = cap_set_flag(cur, CAP_INHERITABLE, 1, caps, value);
> 		if (rc < 0) {
> 			perror("cap_set_flag");
> 			return 1;
> 		}
> 	}
> 	rc = cap_set_proc(cur);
> 	if (rc < 0) {
> 		perror("cap_set_proc");
> 		return 1;
> 	}
> 	cap_free(cur);

Neat.

> Serge - is there any easier way?

Not that I can think of.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
