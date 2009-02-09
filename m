Date: Mon, 9 Feb 2009 14:42:00 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Xavier Toth <txtoth@gmail.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: problem with capabilities inheritance and auditing in python
Message-ID: <20090209204200.GA25401@us.ibm.com>
References: <cadfc0e40902050908n5391c4b4l417714fe87a47f29@mail.gmail.com> <1233857436.3181.40.camel@localhost.localdomain> <cadfc0e40902061356u466495ccyc471328485e2e80e@mail.gmail.com> <1234188170.28831.10.camel@localhost.localdomain> <cadfc0e40902090842i2a62ab85ucb6bfb0e9ee5a4be@mail.gmail.com> <1234210633.28831.87.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1234210633.28831.87.camel@localhost.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Mon, 2009-02-09 at 10:42 -0600, Xavier Toth wrote:
> > On Mon, Feb 9, 2009 at 8:02 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > On Fri, 2009-02-06 at 15:56 -0600, Xavier Toth wrote:
> > >> On Thu, Feb 5, 2009 at 12:10 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >> > On Thu, 2009-02-05 at 11:08 -0600, Xavier Toth wrote:
> > >> >> I've set the capabilities on a script that runs some python code with
> > >> >> auditing calls in it but I'm not getting audit records written to the
> > >> >> audit log. From what I've read I thought the +i would all the
> > >> >> capability to be inherited across execve but this doesn't appear to be
> > >> >> the case. Can anyone help me understand what's going wrong here? Is
> > >> >> there a way in the python code to get the capabilities to see if
> > >> >> indeed cap_audit_write was inherited?
> > >> >
> > >> > Linux doesn't honor setuid on scripts, and file capabilities are
> > >> > supposed to have the same behavior (they didn't for a while due to an
> > >> > oversight, but that was corrected).  You need an executable wrapper
> > >> > program that invokes the script, like:
> > >> > http://oss.tresys.com/projects/clip/browser/trunk/RHEL5.2/scripts/wrappers/wrapper.c
> > >> >
> > >> > --
> > >> > Stephen Smalley
> > >> > National Security Agency
> > >> >
> > >> >
> > >>
> > >> Having used this wrapper code pretty much as is I'm now seeing
> > >> self:capability dac_override and dac_read_search AVCs. Do I need to do
> > >> something similar to what newrole does to drop capabilities that I
> > >> don't need my python script to have after all I'm only trying to give
> > >> it the ability to audit?
> > >
> > > You can just dontaudit those denials if you don't need those
> > > capabilities.
> > >
> > > --
> > > Stephen Smalley
> > > National Security Agency
> > >
> > >
> > 
> > Unfortunately python doesn't survive the dac_read_search AVC. I also
> > tried removing the setreuid/setregid calls, doing a setcap
> > cap_audit_write=ep on the wrapper and not running the wrapper as
> > setuid but that doesn't work.
> 
> So what is it trying to access (enable syscall auditing with at least
> one audit syscall filter defined so the kernel will collect PATH records
> for you and emit them after any AVC denials)?
> 
> On the separate question of capability inheritance on exec of a script
> from a wrapper with file capabilities, I'll defer to Serge.

Right, file capabilities on scripts are disregarded.  So things to do
would include:

1. set capabilities on the interpreter (in which case you'll likely
want to make sure the interpreter can't be called by anyone else)

2. keep capabilities in pI, and place capabilities in fI (and if you
must fE) on all of the compiled programs called by the script.

3. Make the whole thing a compiled program...

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
