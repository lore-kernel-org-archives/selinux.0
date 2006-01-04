Subject: Re: [SEMANAGE] [SETSEBOOL] Clone record on set/add/modify
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43BBF408.7030701@cornell.edu>
References: <43BBD6C0.6020108@cornell.edu>
	 <1136395785.27632.272.camel@moss-spartans.epoch.ncsc.mil>
	 <43BBF408.7030701@cornell.edu>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 13:24:58 -0500
Message-Id: <1136399098.27632.284.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-01-04 at 11:12 -0500, Ivan Gyurdiev wrote:
> > Thanks, your entire patch series has been merged as of libsepol 1.11.2,
> > libsemanage 1.5.4, and policycoreutils 1.29.3.
> >   
> Question - I did some reordering of the headers in semanageswig.i (at 
> the beginning).
> I see you haven't merged that part, but you're missing a header that I 
> added - booleans_active.h (which is why I did the reordering actually - 
> not to miss any headers). Of course, semanage.h includes all of those 
> headers, so I'm not sure whether or not any of them are needed in the 
> first place, given that semanage.h is included.

Ah, I had some rejects on that file, and tried resolving them manually,
but I missed that.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
