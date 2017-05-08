Message-ID: <1494250929.4621.4.camel@tycho.nsa.gov>
Subject: Re: Why does Python want to read /proc/meminfo
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
Date: Mon, 08 May 2017 09:42:09 -0400
In-Reply-To: <20170506180024.GA12984@julius>
References: <72df5e72-55ac-5696-ceb6-f50f98a35ea5@gmail.com>
 <87tw4yfs82.fsf@handshake.de>
 <8b1d353c-7f98-5522-4f42-906a7082d47a@gmail.com>
 <20170506180024.GA12984@julius>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-05-06 at 20:00 +0200, Dominick Grift wrote:
> On Sat, May 06, 2017 at 11:07:34AM -0500, Ian Pilcher wrote:
> > On 05/06/2017 12:51 AM, dieter wrote:
> > > Personally, I doubt that you will find a reference.
> > > Instead, I assume that the reference comes from the C runtime
> > > library.
> > > It might hepl optimize memory management to know about "meminfo"
> > > details.
> > 
> > You're right.  Seems that it's glibc's qsort().
> > 
> > So it seems that any service written in Python (or any other
> > program
> > that uses qsort) needs to be given read access to most of /proc or
> > deal
> > with the (unspecified) consequences of not allowing qsort() to
> > determine
> > the amount of memory in the system.
> > 
> > Delightful.
> 
> For SELinux policy writers the above is a minor issue compared to
> pythons' shutil.copy2() implementation
> shutil.copy2 behaves like `cp -a` and copies all of the security
> attriutes with the file.
> 
> This often causes us to give consumers of shutil.copy2() much broader
> access than strictly needed
> 
> This is also a problem with `cp -a` (so python is not alone in this).
> I am not sure how python handles shutil.copy2() but it would be much
> better for us if it would exclude the MAC security attributes when it
> copies
> 
> Sort of like shutil.copy2_except_MAC_security_attributes or `cp -a-
> minus-MAC-security-attributes`
> 
> Consider this:
> 
> some consumer of shutil.copy2 copies /etc/shadow to /tmp/myapp-XXXXX
> and edits it there.
> 
> Because it copies the security context with /etc/shadow, it later
> needs to be granted to edit files with the security context for
> shadow files. Effectively forcing us to allow the process to edit
> files with the shadow security context
> 
> Whereas if it would have excluded the MAC security contexts when it
> copied the file, we would have just been forced to allow the process
> to read file with the shadow file context, and not to write to it
> 
> The above is a little surrealistic example but it is a very common
> issue in general
> 
> for example pip3 does this all the time and so pip3 processes need
> much broader access than strictly necessary

shutil.copy2 behavior wrt SELinux was previously discussed here:
http://selinux.tycho.nsa.narkive.com/euegPAIr/copying-setting-security-selinux-xattr-explicitly

As a counterexample for your proposal, suppose that shutil.copy2()
defaults to not copying the MAC attributes.  Now a process copies
/etc/shadow to /tmp/myapp-XXXXX and edits it there.  Since we don't
copy MAC attributes, the file ends up being labeled with whatever type
and range transition is defined for the process on /tmp, or defaults to
that of /tmp.  As a result, the /etc/shadow data is now readable under
whatever type/range that happens to be, and potentially leaks to
processes not authorized to read /etc/shadow.

Given that shutil.copy2 says that it copies metadata, it makes sense to
at least try to copy SELinux attributes.  I think the only question is
what to do in case of failure; the earlier thread proposed ignoring
EACCES in the same way it already ignores several other errors.
