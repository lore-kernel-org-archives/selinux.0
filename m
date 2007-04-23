MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: Re: object class discovery userland
Date: Mon, 23 Apr 2007 12:36:12 -0400
Message-ID: <390A6B1AB2C08C4AB50BFD2992A5EDD58E9FBE@joker.antitrust.sultec.com>
From: "Nick Nam" <nnam@echostorm.net>
To: <jbrindle@tresys.com>, <sds@tycho.nsa.gov>, <cpebenito@tresys.com>
Cc: <ewalsh@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



-----Original Message-----
From: Joshua Brindle
To: Stephen Smalley; Christopher J. PeBenito
CC: Eamon Walsh; SELinux Mail List
Sent: Mon Apr 23 10:43:52 2007
Subject: RE: object class discovery userland

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Fri, 2007-04-20 at 13:19 -0400, Christopher J. PeBenito wrote:
> > On Fri, 2007-04-20 at 13:02 -0400, Eamon Walsh wrote:
> > > Eamon Walsh wrote:
> > > > Christopher J. PeBenito wrote:
> > > >> 3. stop exporting class and perm indexes outside of the 
> > > >> libraries.  Then the reverse lookup wouldn't be needed.  This 
> > > >> would involve some overhauling of the libraries.
> > > > 
> > > > I don't think this is a good idea because of the disruption it 
> > > > would cause with access vector processing (as passed to 
> > > > security_av_string() and avc_has_perm()).  How do you 
> or together strings?
> > > > 
> > > > Why not just cache the numbers in the library, as Karl 
> suggested, 
> > > > or create a parallel "class_num" or "class_index" 
> directory with 
> > > > numeric nodes (perhaps renaming class to class_name).
> > > > 
> > > class_num/1/perms/1
> > > class_num/1/name
> > 
> > I don't feel strongly about any of my suggestions, I mainly 
> wanted to 
> > get the discussion going.  The inspiration for symlink idea 
> was from 
> > all the symlinking you see in sysfs, but the above 
> structure certainly 
> > is an option too.
> 
> I'd recommend caching in the library and doing the reverse 
> lookup there rather than encoding it into the pseudo filesystem state.

Making the library open and cache every class and permission seems
undesirable. What do you have against doing it from the filesystem?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
