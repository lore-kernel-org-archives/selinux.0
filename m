MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: object class discovery userland
Date: Mon, 23 Apr 2007 10:43:52 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588A71927@exchange.columbia.tresys.com>
In-Reply-To: <1177338792.24282.16.camel@moss-spartans.epoch.ncsc.mil>
References: <1177077717.15762.32.camel@sgc> <4628F05B.7040309@tycho.nsa.gov> <4628F20E.2000208@tycho.nsa.gov>  <1177089541.24870.17.camel@sgc> <1177338792.24282.16.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
