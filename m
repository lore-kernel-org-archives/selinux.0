Subject: Re: semanage man page updated for booleans
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1208529338.18883.480.camel@moss-spartans.epoch.ncsc.mil>
References: <47FB7A26.6020604@redhat.com>
	 <1208529338.18883.480.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 10:39:30 -0400
Message-Id: <1208529570.18883.485.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-04-18 at 10:35 -0400, Stephen Smalley wrote:
> On Tue, 2008-04-08 at 09:59 -0400, Daniel J Walsh wrote:
> > plain text document attachment (diff.part003)
> > --- nsapolicycoreutils/semanage/semanage.8	2008-04-08 09:37:21.000000000 -0400
> > +++ policycoreutils-2.0.46/semanage/semanage.8	2008-04-08 09:35:46.000000000 -0400
> > @@ -3,7 +3,9 @@
> >  semanage \- SELinux Policy Management tool
> >  
> >  .SH "SYNOPSIS"
> > -.B semanage {login|user|port|interface|fcontext|translation} \-l [\-n]
> > +.B semanage {boolean|login|user|port|interface|fcontext|translation} \-{l|D} [\-n] 
> > +.br
> > +.B semanage boolean \-{d|m} [\-T] boolean
> 
> Merged with some fixes (no -T, added --on/--off/-1/-0).
> 
> Also added a mention of the -C/--locallist option for only listing local
> settings.  And added error checking on the set_active() call.

Also, last I tried, policy didn't allow semanage_t to set boolean
values, so attempting to modify booleans using semanage rather than
setsebool fails.  So policy needs to be updated.

And what domain is system-config-selinux running in at present?

> 
> >  .br
> >  .B semanage login \-{a|d|m} [\-sr] login_name
> >  .br
> > @@ -43,6 +45,9 @@
> >  .I                \-d, \-\-delete     
> >  Delete a OBJECT record NAME
> >  .TP
> > +.I                \-D, \-\-deleteall
> > +Remove all OBJECTS local customizations
> 
> Does this actually yield the expected result for booleans?  IOW, if I
> delete all local customizations, does it also change the active boolean
> settings to the base policy values?  If not, then the user won't see the
> real effect until they next reboot since the kernel will keep preserving
> the active boolean settings across reload.
>  
> > +.TP
> >  .I                \-f, \-\-ftype
> >  File Type.   This is used with fcontext.
> >  Requires a file type as shown in the mode field by ls, e.g. use -d to match only directories or -- to match only regular files.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
