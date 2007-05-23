Subject: RE: object class discovery userland
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <jbrindle@tresys.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1177340283.24282.24.camel@moss-spartans.epoch.ncsc.mil>
References: <1177077717.15762.32.camel@sgc> <4628F05B.7040309@tycho.nsa.gov>
	 <4628F20E.2000208@tycho.nsa.gov>  <1177089541.24870.17.camel@sgc>
	 <1177338792.24282.16.camel@moss-spartans.epoch.ncsc.mil>
	 <6FE441CD9F0C0C479F2D88F959B01588A71927@exchange.columbia.tresys.com>
	 <1177340283.24282.24.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 23 May 2007 14:17:32 +0000
Message-Id: <1179929852.10995.51.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-23 at 10:58 -0400, Stephen Smalley wrote:
> On Mon, 2007-04-23 at 10:43 -0400, Joshua Brindle wrote:
> > > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > > 
> > > On Fri, 2007-04-20 at 13:19 -0400, Christopher J. PeBenito wrote:
> > > > On Fri, 2007-04-20 at 13:02 -0400, Eamon Walsh wrote:
> > > > > Eamon Walsh wrote:
> > > > > > Christopher J. PeBenito wrote:
> > > > > >> 3. stop exporting class and perm indexes outside of the 
> > > > > >> libraries.  Then the reverse lookup wouldn't be needed.  This 
> > > > > >> would involve some overhauling of the libraries.
> > > > > > 
> > > > > > I don't think this is a good idea because of the disruption it 
> > > > > > would cause with access vector processing (as passed to 
> > > > > > security_av_string() and avc_has_perm()).  How do you 
> > > or together strings?
> > > > > > 
> > > > > > Why not just cache the numbers in the library, as Karl 
> > > suggested, 
> > > > > > or create a parallel "class_num" or "class_index" 
> > > directory with 
> > > > > > numeric nodes (perhaps renaming class to class_name).
> > > > > > 
> > > > > class_num/1/perms/1
> > > > > class_num/1/name
> > > > 
> > > > I don't feel strongly about any of my suggestions, I mainly 
> > > wanted to 
> > > > get the discussion going.  The inspiration for symlink idea 
> > > was from 
> > > > all the symlinking you see in sysfs, but the above 
> > > structure certainly 
> > > > is an option too.
> > > 
> > > I'd recommend caching in the library and doing the reverse 
> > > lookup there rather than encoding it into the pseudo filesystem state.
> > 
> > Making the library open and cache every class and permission seems
> > undesirable. What do you have against doing it from the filesystem?
> 
> You don't have to cache them all - the cache can be populated lazily
> (but I'd expect it to pull in an entire class at a time).
> 
> I'm not keen on having redundant information in the filesystem state,
> and I don't think these operations are on the critical path anyway for
> performance.

One issue that we realized on this is that the cache is going to have to
be flushed when the policy is reloaded.  For object managers that have a
full AVC that is simple, since we can just add it to the netlink socket
handler where it resets the AVC.

However, for simple ones such as passwd and crond which, don't need an
AVC, there isn't a facility now.  Crond should be ok since it only
checks process permissions, which can't change on policy reload.
Perhaps a lighter version of the netlink support that just listens for
policy reloads?

The object manager will also have to be modified to get the new class
and perm values on a policy reload.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
