Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PEUDf1025458
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 10:30:13 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3PEUCd2026888
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 14:30:12 GMT
Subject: Re: adding to selinux.py
From: James Athey <jathey@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <462F5A3D.80109@redhat.com>
References: <462CAF84.20708@gmail.com>
	 <1177337371.24282.8.camel@moss-spartans.epoch.ncsc.mil>
	 <462E6ADC.7010802@gmail.com>  <462F5A3D.80109@redhat.com>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 10:30:06 -0400
Message-Id: <1177511406.1719.1.camel@exodus.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 09:40 -0400, Daniel J Walsh wrote:
> Ted X Toth wrote:
> > Stephen Smalley wrote:
> >> On Mon, 2007-04-23 at 08:07 -0500, Ted X Toth wrote:
> >>  
> >>> Would it be possible to get get_ordered_context_list and 
> >>> get_default_context* added to selinux.py?
> >>>     
> >>
> >> selinux.py is generated via swig, so you'd actually want to modify
> >> selinuxswig.i and regenerate it.   And I think selinuxswig.i should be
> >> reworked and split along the lines of semanageswig.i and
> >> semanageswig_python.i over in libsemanage.
> >>
> >>   
> > Is this something that I should look at doing or will Dan be doing it? 
> > Should I open a bug report?
> >
> > Ted
> You can open a bug report, and as always patches welcome.
> 
I took a stab at cleaning up the .i files for libselinux a few months
back.  I'll rebase and clean up the patch and submit it soon.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
