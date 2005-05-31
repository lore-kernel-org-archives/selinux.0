Message-Id: <200505311632.j4VGW95F032656@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <ivg2@cornell.edu>
Cc: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <SELinux@tycho.nsa.gov>,
   <dwalsh@redhat.com>
Subject: RE: file_type_auto_trans is not sufficient
Date: Tue, 31 May 2005 12:32:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1117551440.15167.25.camel@dhcp83-8.boston.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Ivan Gyurdiev [mailto:ivg2@cornell.edu]
> Sent: Tuesday, May 31, 2005 10:57 AM
> To: Karl MacMillan
> Cc: 'Stephen Smalley'; SELinux@tycho.nsa.gov; dwalsh@redhat.com
> Subject: RE: file_type_auto_trans is not sufficient
> 
> 
> > The other option, of course, is to change the applications to use/create
> many
> > more directories, each with a separate type to allow the
> file_type_auto_trans
> > rules to work. Your orbit example might mean that there is a /tmp/orbit
> > directory where all orbit files are created.
> 
> The problem is not multiple source domains - that can be addressed
> through macros. The problem is that those domains use the same directory
> (Usually /tmp, or /home), for their own purposes, and they need the same
> transition (same directory and target class (dir/file)).
> 

I know - that is why I am suggesting that each application could use multiple
directories. That means that orbit might put files into multiple directories
that were previously created, e.g. both /tmp and /tmp/orbit. The net result is
the same as making them selinux aware, but without the problem of selinux
specific code. It also works fine for multiple threads.

Again, this might mean creating many directory types and forcing directory
layouts that upstream / users might not like so it may not be an real option,
but technically it would work.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134

> Because you can have only one transition, this creates a problem.
> 
> For example, look at mozilla, using the patches I posted earlier:
> 
> Needs transition on :
> 
> (ROLE_home_dir_t, file) -> ROLE_untrusted_content_t
>      when saving web pages
> (ROLE_home_dir_t, file) -> ROLE_fonts_cache_t
>      when updating the font cache (read_fonts macro, libfontconfig)
> (ROLE_home_dir_t, dir) -> ROLE_mozilla_home_t
>      when creating its home directory
> (ROLE_home_dir_t, dir) -> ROLE_untrusted_content_t
>      when saving web pages image data
> 
> (tmp_t, file) -> ROLE_untrusted_content_t
>      when saving temporary files from the internet
> (tmp_t, dir) -> ROLE_untrusted_content_t
>      same problem
> (tmp_t, dir) -> ROLE_orbit_tmp_t
>       when creating the ORBit temp folder, libORBit2 (through bonobo)
> 
> Evolution has most of the same problems.
> 
> This is most problematic when the creation code is in a shared library,
> because that gets called from lots of domains, which may use the same
> container directory/mode pair for their own data.
> 
> Earlier we discussed how keeping settings away from content would be a
> good idea. Still, that wouldn't solve the problem, since then you would
> have to distinguish between different types of settings, which would
> all need a transition (and an app may need to use all of them via
> shared libraries)
> 
> You're also suggesting that the problem is with the application, while
> to me this seems like a SELinux problem. I'm not sure restructuring
> directories so that they only store homogenous data (labeled the same
> way) is feasable (or desirable).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
