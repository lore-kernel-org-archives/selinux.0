Subject: RE: Recurring SELinux events for similar violations...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Eric Paris <eparis@parisplace.org>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D040E251B@de01exm68.ds.mot.com>
References: <C3357D99.2F091%csellers@tresys.com>
	 <1192356878.3376.3.camel@vogon> <47135FCE.5000403@redhat.com>
	 <1192467177.28762.7.camel@blentz>
	 <1192467538.29203.52.camel@moss-spartans.epoch.ncsc.mil>
	 <4713B257.9020409@redhat.com>
	 <1192473631.29203.56.camel@moss-spartans.epoch.ncsc.mil>
	 <1192475354.2910.14.camel@localhost.localdomain>
	 <1192650454.20908.30.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D040E2506@de01exm68.ds.mot.com>
	 <7e0fb38c0710171518r645c1ce1l3e0653109f2d27b2@mail.gmail.com>
	 <D06FE0A2807BC145B0D38744789D4F5D040E251B@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 09:13:44 -0400
Message-Id: <1192713224.32671.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-17 at 18:22 -0400, Hasan Rezaul-CHR010 wrote:
> Yes, I am running in "Permissive" mode right now, just for testing
> purposes.
> 
> If this is by design, is there any way I can force SELinux to log every
> denial even in Permissive mode ?

It is by design, as otherwise you could end up with an unending stream
of duplicate denials since the application will keep on processing
(since the denials are not enforced), and thus flood the audit system
and logs with redundant information.

However, the denial will re-appear if the AVC entry is evicted.  You can
manually flush the AVC by:
- toggling enforcing mode (e.g. setenforce 1; setenforce 0),
- setting a boolean (e.g. setsebool <somebool>=<somevalue>),
- reloading policy (e.g. /usr/sbin/load_policy)

Or you should be able to effectively turn off caching by setting the
cache threshold down (performance will naturally suffer as a result):
echo 0 > /selinux/avc/cache_threshold
cat /selinux/avc/cache_threshold


> Thanks,
> 
> - Rezaul.
>   
> 
> -----Original Message-----
> From: Eric Paris [mailto:eparis@parisplace.org] 
> Sent: Wednesday, October 17, 2007 5:19 PM
> To: Hasan Rezaul-CHR010
> Cc: Stephen Smalley; Daniel J Walsh; selinux@tycho.nsa.gov
> Subject: Re: Recurring SELinux events for similar violations...
> 
> Are you running without enforcing just for testing?  When you turn off
> enforcing it only logs once (by design) but I think it should log the
> denial every single time in enforcing mode.
> 
> -Eric
> 
> On 10/17/07, Hasan Rezaul-CHR010 <CHR010@motorola.com> wrote:
> > Hi All,
> >
> > I am using a Fedora 6 STRICT policy as my base, and have written some
> > additional custom policies on top.
> >
> > For example, I have allowed certain domains (e.g. staff_t) to modify
> > file types of  etc_t
> > And I have disallowed other domains (e.g. user_t) to modify file types
> > of etc_t.
> >
> > When user_t makes the first attempt to modify an etc_t file, I do get
> > DENY events  :-)
> >
> > But subsequent attempts by user_t to modify etc_t files  *DO NOT*
> > generate any more events ?!?
> >
> > - Is this by design ???
> >
> > - Is there something I can do such that  EVERY time user_t  attempts
> to
> > modify a file type etc_t , I will get a corresponding DENY ?
> >
> > - In other words, I would like every violation attempt to be reported
> in
> > the audit.log file, even if the same violation occurs multiple times
> in
> > the same session.
> >
> > Thanks in advance,
> >
> > - Rezaul.
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing
> list.
> > If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
