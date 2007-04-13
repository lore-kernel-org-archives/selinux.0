Subject: Re: [Fwd: policycoreutils patches]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <461F9D6B.200@redhat.com>
References: <461F7D36.2070602@redhat.com>
	 <1176474662.3986.239.camel@moss-spartans.epoch.ncsc.mil>
	 <461F9611.9050204@redhat.com>
	 <1176475763.3986.248.camel@moss-spartans.epoch.ncsc.mil>
	 <1176475932.3986.251.camel@moss-spartans.epoch.ncsc.mil>
	 <461F9D6B.200@redhat.com>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 11:18:22 -0400
Message-Id: <1176477502.3986.257.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-13 at 11:10 -0400, Daniel J Walsh wrote:
> >>>>> Fix output of restorecon.c errors to show correct error message.
> >>>>>     
> >>>>>           
> >>>> Adding a ": %s" with strerror(errno) is fine, but I don't think you want
> >>>> to drop the existing error message altogether, as errno isn't always set
> >>>> properly. 
> >>>>
> >>>>   
> >>>>         
> >>> That error message is misleading and happens on messages that have 
> >>> nothing to do " error while labeling files under".
> >>>       
> >> Hmm..that seems to be due to the fact that apply_spec() doesn't return
> >> its error status to the caller, so nftw() doesn't see it (and thus just
> >> proceeds).  Which I suppose is what you want in some cases (e.g. skip
> >> that file and continue to the rest), but not always.
> >>
> >> Regardless, the errors would still come from ntftw, which is the file
> >> tree walk - what kinds of errors are you seeing?
> >>
> >>     
> I think you get this error even if you choose a directory that does not 
> exist. 
> 
> restorecon -R -v /some/nonexisting/dir
> restorecon:  error while labeling files under /some/nonexisting/dir
> 
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=229040

Ok, but I think you still want some prefix to handle other kinds of
error messages, e.g. it would be just as confusing to see:
	restorecon:  /foobar:  too many open files 
which could happen if nftw() ran out of descriptors during the file tree
walk.

So I think you want something like:
	fprintf(stderr,	"%s:  error while traversing %s:  %s", argv[0], buf,
strerror(errno));

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
