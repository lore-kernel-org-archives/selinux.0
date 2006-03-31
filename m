Subject: Re: The sort algorithm is broken by the second rule,  We need
	a	way to pin these rules to the top.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <442D5A3F.9090409@cornell.edu>
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com>
	 <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>
	 <442D5A3F.9090409@cornell.edu>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 13:52:31 -0500
Message-Id: <1143831151.17469.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-31 at 11:35 -0500, Ivan Gyurdiev wrote:
> >
> > At present, you can force the nvidia entry to win by adding it as a
> > local fcontext via semanage or file_contexts.local.  But if we add the
> > sort to libsemanage, we'll lose the ability to give precedence to local
> > fcontexts added by semanage unless we exclude the local ones from the
> > sort, right?
> >   
> Hmm, I think we actually don't have this capability as of right now - my 
> fault, as I didn't get around to addressing this issue, which would 
> consist of either not merging the .local file into the other one (as we 
> do now), or moving the sort algorithm into libsemanage, where it would 
> sort the local things separately from the module things.

Not sure we are all on the same page here.  At present, one can add
fcontext entries via semanage fcontext -a (which are then merged to the
end of the generated file_contexts file that is installed) or by
manually adding
to /etc/selinux/$SELINUXTYPE/contexts/files/file_contexts.local, which
is not managed presently but is still read by libselinux
matchpathcon(3).  Either approach will ensure that the entry you added
takes precedence over any existing ones.  Sorting is presently only
happening in the policy build process via the
refpolicy/support/fc_sort.c helper program, so it is only applied to the
file_context file provided by the policy itself, not to any local
entries (whether created via semanage or not).

If/when the sort logic is moved into libsemanage, we can still ensure
that it is only applied to the policy file contexts.  Why do we need to
refrain from merging the local file contexts into the final file?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
