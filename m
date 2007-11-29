MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Recurring SELinux events for similar violations...
Date: Thu, 29 Nov 2007 15:06:15 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D042DC0D5@de01exm68.ds.mot.com>
in-reply-to: <1192713224.32671.11.camel@moss-spartans.epoch.ncsc.mil>
References: <C3357D99.2F091%csellers@tresys.com> <1192356878.3376.3.camel@vogon> <47135FCE.5000403@redhat.com> <1192467177.28762.7.camel@blentz> <1192467538.29203.52.camel@moss-spartans.epoch.ncsc.mil> <4713B257.9020409@redhat.com> <1192473631.29203.56.camel@moss-spartans.epoch.ncsc.mil> <1192475354.2910.14.camel@localhost.localdomain> <1192650454.20908.30.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D040E2506@de01exm68.ds.mot.com> <7e0fb38c0710171518r645c1ce1l3e0653109f2d27b2@mail.gmail.com> <D06FE0A2807BC145B0D38744789D4F5D040E251B@de01exm68.ds.mot.com> <1192713224.32671.11.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

So here is my problem statement:

While running in "Permissive" Mode, and keeping the
/selinux/avc/cache_threshold at the default 512 value, is there any
*other* way to make sure that  EVERY  SELinux violation attempt still
automatically gets logged into the audit.log file ???

Currently, while running in "Permissive" mode, and with the default
cache_threshold value of 512:

- if a violation is attempted, I see a deny event only once in the
audit.log file ! Successive violation attempts within the same session
are NOT logged in the audit.log file  :(  I need to get a DENY for every
violation attempt during runtime !

- When I run in "Enforcing" mode, every single violation does get logged
in the audit.log file. But at this time, lets just say I CANT afford to
run in Enforcing mode ! I must run in Permissive mode for now !

- If I change the cache_threshold to 0, every single violation attempt
does get logged, but I also get some other useless frequent periodic
violations. Besides, it seems to have performance impacts of course...

Therefore, I am looking for any other good way to generate a deny in the
audit.log for every violation attempt. But I cant change to Enforcing,
and I would prefer not to modify the cache_threshold.

Please help. Thanks,

- Rezaul.


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
Sent: Thursday, October 18, 2007 8:14 AM
To: Hasan Rezaul-CHR010
Cc: Eric Paris; Daniel J Walsh; selinux@tycho.nsa.gov
Subject: RE: Recurring SELinux events for similar violations...

On Wed, 2007-10-17 at 18:22 -0400, Hasan Rezaul-CHR010 wrote:
> Yes, I am running in "Permissive" mode right now, just for testing
> purposes.
> 
> If this is by design, is there any way I can force SELinux to log
every
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
> > I am using a Fedora 6 STRICT policy as my base, and have written
some
> > additional custom policies on top.
> >
> > For example, I have allowed certain domains (e.g. staff_t) to modify
> > file types of  etc_t
> > And I have disallowed other domains (e.g. user_t) to modify file
types
> > of etc_t.
> >
> > When user_t makes the first attempt to modify an etc_t file, I do
get
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
> > - In other words, I would like every violation attempt to be
reported
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
> This message was distributed to subscribers of the selinux mailing
list.
> If you no longer wish to subscribe, send mail to
majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
