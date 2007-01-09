Subject: Re: [RFC] Support for bzip compressed modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: James Antill <jantill@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45A3BA1B.9000908@mentalrootkit.com>
References: <45A2AADC.1090907@mentalrootkit.com>
	 <1168327098.22423.93.camel@code.and.org>
	 <45A3BA1B.9000908@mentalrootkit.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 10:58:43 -0500
Message-Id: <1168358323.7993.102.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-09 at 10:51 -0500, Karl MacMillan wrote:
> James Antill wrote:
> > On Mon, 2007-01-08 at 15:34 -0500, Karl MacMillan wrote:
> > 
> >> The patch implements this support by changing sepol_policy_file_t to 
> >> support decompressing files or memory areas into a private memory copy. 
> >> This support is optional - dlopen is used so that a hard dependency to 
> >> libbz2 is not introduced. I took the approach of decompressing the 
> >> entire file or memory area because:
> > 
> >  Why don't we want to depend on libbz, if we are building with bz2
> > support? 
> > 
> 
> This allows the same binary to be installed with or without libbz2. 
> Since libsepol gets pulled into so many installs, it seems preferable to 
> not add additional dependencies.
> 
> On the other hand, I don't have a strong preference about that part of 
> the patch. If libbz2 is deemed sufficiently available (or even libz I 
> guess) we can just directly link. Perhaps with compile time options.

/sbin/init depends on libsepol, so if libsepol were to have a fixed
dependency on libbz2, then you might have a problem there (looks like
libbz2.so.1 lives in /usr/lib in Fedora, not in /lib, so it might not
even be available if /usr is a separate partition).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
