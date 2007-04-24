Subject: Re: can not boot with strict policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Ken YANG <spng.yang@gmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <462DBBC8.9060300@gmail.com>
References: <462CA1F0.2000400@gmail.com>
	 <1177340494.24282.28.camel@moss-spartans.epoch.ncsc.mil>
	 <Line.LNX.4.64.0704231341100.3793@d.namei>
	 <1177350508.24282.58.camel@moss-spartans.epoch.ncsc.mil>
	 <462CF79C.5080804@redhat.com>  <462DBBC8.9060300@gmail.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 08:26:59 -0400
Message-Id: <1177417620.8672.28.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-24 at 16:11 +0800, Ken YANG wrote:
> Daniel J Walsh wrote:
> > So the real question, is there much value with the division between 
> > lib_t and shlib_t.
> > When dealing with strict policy, shared libraries were always getting 
> > mislabeled as lib_t, and causing problems, for little security advantage.
> > As we remove the differences between strict and targeted, I don't intend 
> > to get rid of lib_t == shlib_t.
> 
> 
> i find most files labeled with "lib_t" are ".a" or symbolic link to
> ".so"
> 
> what difference between lib_t and shlib_t? what is the purpose of
> "lib_t" type?

The difference boils down to being able to mmap shlib_t files as
executable (which is required for shared libraries to work), whereas
that is not allowed for lib_t files.  That means that only shared
libraries are shlib_t and symlinks and static libraries (and other
random files placed in /lib or /usr/lib) are lib_t.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
