Date: Tue, 10 Feb 2009 12:34:39 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Xavier Toth <txtoth@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: problem with capabilities inheritance and auditing in python
Message-ID: <20090210183438.GA14133@us.ibm.com>
References: <cadfc0e40902050908n5391c4b4l417714fe87a47f29@mail.gmail.com> <1233857436.3181.40.camel@localhost.localdomain> <cadfc0e40902061356u466495ccyc471328485e2e80e@mail.gmail.com> <1234188170.28831.10.camel@localhost.localdomain> <cadfc0e40902090842i2a62ab85ucb6bfb0e9ee5a4be@mail.gmail.com> <1234210633.28831.87.camel@localhost.localdomain> <20090209204200.GA25401@us.ibm.com> <cadfc0e40902100900n12d116b2m7b1c5db4ae43c9d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cadfc0e40902100900n12d116b2m7b1c5db4ae43c9d@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Xavier Toth (txtoth@gmail.com):
> I was not putting capabilities on the script but rather on a compiled
> wrapper which execs a python script in which I need to do auditing.
> Will this not work?

No, because of the way capabilities are re-calculated on exec().

	pI' = pI
	pP' = (X&fP) | (pI & fI)
	pE' = fE ? pP' : 0

So since the interpreter has fI=fP=fE=0 and is not setuid root (which
would fill in fP and/or fE to emulate privileged root), pP' and pE' will
be empty after exec().

Now you could use a wrapper as follows:  Have the wrapper fill pI,
and then fill fI on the python interpreter.  Any user who has an
empty pI (which generally is all users) will execute python scripts
with no privilege, but when the wrapper execs the script, pP' will
be filled with (pI&fI) = full.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
