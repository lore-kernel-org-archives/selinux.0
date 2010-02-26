Subject: Re: Fixfiles using new setfiles/restorecon simplification
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>, SELinux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <4B880F0E.2010904@redhat.com>
References: <4B85902B.70300@redhat.com> <4B8726DA.8040806@manicmethod.com>
	 <4B87CFA0.8030707@redhat.com>
	 <1267193425.9997.5.camel@moss-pluto.epoch.ncsc.mil>
	 <4B87D94F.1000606@redhat.com>
	 <1267195015.9997.7.camel@moss-pluto.epoch.ncsc.mil>
	 <4B880F0E.2010904@redhat.com>
Content-Type: text/plain
Date: Fri, 26 Feb 2010 15:16:25 -0500
Message-Id: <1267215385.9997.51.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-02-26 at 13:12 -0500, Daniel J Walsh wrote:
> On 02/26/2010 09:36 AM, Stephen Smalley wrote:
> > On Fri, 2010-02-26 at 09:23 -0500, Daniel J Walsh wrote:
> >    
> >> On 02/26/2010 09:10 AM, Stephen Smalley wrote:
> >>      
> >>> On Fri, 2010-02-26 at 08:41 -0500, Daniel J Walsh wrote:
> >>>
> >>>        
> >>>> On 02/25/2010 08:41 PM, Joshua Brindle wrote:
> >>>>
> >>>>          
> >>>>> What version of the kernel was this added in? I don't want to
> >>>>> completely break old kernels using new toolchains (CLIP backports
> >>>>> toolchains to RHEL 4 and 5). It would be better to use seclabel if it
> >>>>> is there, otherwise fall back to the old list.
> >>>>>
> >>>>> -- 
> >>>>> This message was distributed to subscribers of the selinux mailing list.
> >>>>> If you no longer wish to subscribe, send mail to
> >>>>> majordomo@tycho.nsa.gov with
> >>>>> the words "unsubscribe selinux" without quotes as the message.
> >>>>>
> >>>>>            
> >>>> The problem with this is we end up with a lot of cruft in the toolchain,
> >>>> that is continually out of data, and makes it hard to figure out what
> >>>> the script is doing.  We have older versions of the tool chain for those
> >>>> platforms, shouldn't we have sort of the latest toolchain.
> >>>>
> >>>>          
> >>> If we do that, we ought to make a major bump in the version numbers,
> >>> e.g. finally go to 2.1 or 3.0 or something, and make sure the release
> >>> announcement clearly marks it as not backward compatible.
> >>>
> >>> With regard to fixfiles simplification though, can't we eliminate the
> >>> need to define or use FILESYSTEMS* altogether in the script by switching
> >>> all uses of setfiles to restorecon -R /, since that will automatically
> >>> skip non-labeled filesystems on kernels>= 2.6.30?
> >>>
> >>>
> >>>        
> >> It will still walk on read/only file systems.
> >>      
> > That should be fairly easy to fix in setfiles given that we are already
> > reading /proc/mounts - we can just add exclude on any ro mounts.
> >
> >    
> How about this patch to remove ro mount points from setfiles/restorecon

Your logic depends on the option order - if "seclabel" appears first,
then you'll break out of the loop and never see the "ro".  If we are ok
with that assumption (which happens to be true at present,
but /proc/mounts format is not guaranteed to remain stable), then it is
ok but then there is no reason to set found to 0 (already initialized to
0).  If we want to be robust against ordering changes, we'd need to drop
the break; from the seclabel case and keep scanning to check for any
subsequent "ro" options.  Or you could just use strstr() on the entire
mount_info[3] and not worry about splitting it into tokens.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
