MIME-Version: 1.0
In-Reply-To: <20090210213846.GB11776@us.ibm.com>
References: <cadfc0e40902061356u466495ccyc471328485e2e80e@mail.gmail.com>
	 <cadfc0e40902090842i2a62ab85ucb6bfb0e9ee5a4be@mail.gmail.com>
	 <1234210633.28831.87.camel@localhost.localdomain>
	 <20090209204200.GA25401@us.ibm.com>
	 <cadfc0e40902100900n12d116b2m7b1c5db4ae43c9d@mail.gmail.com>
	 <20090210183438.GA14133@us.ibm.com>
	 <cadfc0e40902101220o7c7b162v84cbbfb264a7c980@mail.gmail.com>
	 <1234298002.4642.140.camel@localhost.localdomain>
	 <cadfc0e40902101259q2c781ewa7056fad53beffb@mail.gmail.com>
	 <20090210213846.GB11776@us.ibm.com>
Date: Tue, 10 Feb 2009 15:45:13 -0600
Message-ID: <cadfc0e40902101345n33f9536arf2e6450da0b3c427@mail.gmail.com>
Subject: Re: problem with capabilities inheritance and auditing in python
From: Xavier Toth <txtoth@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 10, 2009 at 3:38 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Xavier Toth (txtoth@gmail.com):
>> On Tue, Feb 10, 2009 at 2:33 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> > On Tue, 2009-02-10 at 14:20 -0600, Xavier Toth wrote:
>> >> On Tue, Feb 10, 2009 at 12:34 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
>> >> > Quoting Xavier Toth (txtoth@gmail.com):
>> >> >> I was not putting capabilities on the script but rather on a compiled
>> >> >> wrapper which execs a python script in which I need to do auditing.
>> >> >> Will this not work?
>> >> >
>> >> > No, because of the way capabilities are re-calculated on exec().
>> >> >
>> >> >        pI' = pI
>> >> >        pP' = (X&fP) | (pI & fI)
>> >> >        pE' = fE ? pP' : 0
>> >> >
>> >> > So since the interpreter has fI=fP=fE=0 and is not setuid root (which
>> >> > would fill in fP and/or fE to emulate privileged root), pP' and pE' will
>> >> > be empty after exec().
>> >> >
>> >> > Now you could use a wrapper as follows:  Have the wrapper fill pI,
>> >> > and then fill fI on the python interpreter.  Any user who has an
>> >> > empty pI (which generally is all users) will execute python scripts
>> >> > with no privilege, but when the wrapper execs the script, pP' will
>> >> > be filled with (pI&fI) = full.
>> >> >
>> >> > -serge
>> >> >
>> >>
>> >> Thanks for the clarification.
>> >> For anyone one that is interested I've included some test code. The
>> >> wrapper is a modified version of a wrapper Stephen sent me a link to.
>> >> Basic steps to test are:
>> >> 1) edit the wrapper to set the path to the audit_test.py script
>> >> 2) compiler the wrapper
>> >>     gcc -o audit-wrapper audit-wrapper.c -lcap
>> >> 3) set the capabilities on the wrapper and python
>> >>     setcap cap_audit_write,cap_setfcap=epi audit-wrapper
>> >
>> > Why cap_setfcap (set file capability)?
>>
>> The wrapper adds the 'i' back to cap_audit_write as it goes away when
>> audit-wrapper runs.
>
>> I was printing the capabilities in the wrapper for
>> debug purposes when I noticed that it capabilities were "=
>> cap_audit_write,cap_setfcap+ep". I think without the i cap_audit_write
>> can't be inherited by the child process.
>>
>> > And do you need to set fI on the wrapper at all, given that it isn't
>> > inheriting anything from its caller?
>>
>> Without cap_setfcap cap_set_proc fails, without cap_audit_write
>> cap_set_proc fails (see cap_set_proc man page).
>>
>> >
>> >>     setcap cap_audit_write=ei /usr/bin/python
>> >
>> > Is setting fE required on the interpreter?
>>
>> I tried 'i' only it wouldn't work without 'e'.
>
> Right, without 'e' the final exec() will end up with
> cap_audit_write in pP' but not pE', so you won't be
> able to actually exercise the privilege (without using
> cap_set_proc() which I assume python doesn't support).
>
> It's no big deal, but your use of fI still is more liberal
> than it needs to be.  The following should suffice:
>
>     setcap cap_audit_write=p audit-wrapper
>     setcap cap_audit_write=ei /usr/bin/python
>
> Now anyone running audit-wrapper will get cap_audit_write
> in pP', but not be able to exercise it (it's not in pE').
> Audit-wrapper can put cap_audit_write into pI because it's
> in pP.  Finally, when audit-wrapper execs the python script,
> that will run with pP'=pI'=pP'=cap_audit_write.
>
> -serge
>

You're right 'setcap cap_audit_write=p audit-wrapper' is sufficient.

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
