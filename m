Subject: Re: Permissive mode for xace is broken.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>, Steve Grubb <sgrubb@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <729568.16778.qm@web51505.mail.re2.yahoo.com>
References: <729568.16778.qm@web51505.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 24 Mar 2008 15:59:05 -0400
Message-Id: <1206388745.3302.88.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-24 at 08:55 -0700, Steve G wrote:
> 
> ----- Original Message ----
> > From: Eamon Walsh <ewalsh@tycho.nsa.gov>
> > To: Steve Grubb <sgrubb@redhat.com>
> > Cc: Stephen Smalley <sds@tycho.nsa.gov>; Daniel J Walsh <dwalsh@redhat.com>; SE Linux <selinux@tycho.nsa.gov>
> > Sent: Wednesday, March 19, 2008 11:56:00 PM
> > Subject: Re: Permissive mode for xace is broken.
> > 
> > Steve Grubb wrote:
> > > On Thursday 28 February 2008 21:02:28 Eamon Walsh wrote:
> > >   
> > >> Steve Grubb wrote:
> > >>     
> > >>> On Thursday 28 February 2008 13:51:05 Stephen Smalley wrote:
> > >>>       
> > >>>> On Thu, 2008-02-28 at 13:48 -0500, Eamon Walsh wrote:
> > >>>>         
> > >>>>> Stephen Smalley wrote:
> > >>>>>           
> > >>>>>> On Mon, 2008-02-25 at 20:12 -0500, Eamon Walsh wrote:
> > >>>>>>             
> > >>>>>>> Eamon Walsh wrote:
> > >>>>>>>               
> > >>>>>>>> The X object manager logs all avc's and status messages (including
> > >>>>>>>> the AVC netlink stuff) through the audit system using libaudit calls
> > >>>>>>>> (audit_log_user_avc_message, etc.)
> > >>>>>>>>                 
> > >>> Please tell me they have different record types. Also do you have any
> > >>> samples that we can look over to make sure they conform?
> > >>>       
> > >> type=USER_AVC msg=audit(1204226161.048:268): user pid=21267 uid=0
> > >> auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023
> > >> msg='avc:  denied  { read } for request=X11:QueryPointer
> > >> comm=/usr/libexec/at-spi-registryd xdevice="Virtual core pointer"
> > >> scontext=staff_u:staff_r:staff_t:s0
> > >> tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device :
> > >> exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
> > >>     
> > >
> > > comm & xdevice are not escaped the right way. exe is. The audit utilities are 
> > > expecting the comm field to be comm="/usr/libexec/at-spi-registryd" in this 
> > > case. The standard has been untrusted fields have " " enclosing the field. 
> > > Whenever there is a space, double quote, or control character, its ASCII HEX 
> > > encoded with no quotes. xdevice is not a field that the audit system knows 
> > > about, so we could do something different with it, but comm is known for a 
> > > long time and has to follow the standards.
> > >   
> > 
> > Why can't libaudit automatically perform this escaping?
> 
> Well, it could. However, this is the API that you currently have:
> 
> extern int audit_log_user_avc_message(int audit_fd, int type,
>         const char *message, const char *hostname, const char *addr,
>         const char *tty, uid_t uid);
> 
> The whole avc from msg=  up to the exe= statement comes from libselinux. So, libselinux has to do the escaping unless we build a better API for selinux use. I could probably expose the function that does the escaping, but I had really wanted to try to maintain some consistency in the event by API.
> 
> 
> >  That way we avoid promulgating this "standard" into every caller of libaudit.
> > 
> > If everything is going to be name-value based, then I want a libaudit 
> > function that takes a list of name/value pairs.
> 
> SE Linux is the only user of the audit system that does not follow the name=value standard. Would you (and the community) really be willing to convert selinux over to that if we have the API for it?  Do you have any suggestions about how you'd like to see the new API implemented?

When the topic last came up on list, we weren't opposed to converting to
the name=value model, just cautious about not breaking userspace in the
process.   We don't want users suddenly finding that audit2allow,
setroubleshoot, setools, etc suddenly stop working over night.  And that
isn't so far fetched - Fedora pushes new upstream kernels as updates to
old releases w/o any corresponding userland updates, which has caused us
breakage in the past, and akpm specifically tests new kernels on ancient
Fedora releases to see if anything breaks.

As I recall, we even agreed on field names for the avc fields during the
prior thread.  But no one followed up with actual patches to make it
happen.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
