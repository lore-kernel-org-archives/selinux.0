Subject: Re: Latest diffs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: ivg2@cornell.edu
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107294094.32037.0.camel@cobra.ivg2.net>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107294094.32037.0.camel@cobra.ivg2.net>
Content-Type: text/plain
Message-Id: <1107349071.890.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 02 Feb 2005 07:57:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-02-01 at 16:41, Ivan Gyurdiev wrote:
> > +# libGL
> > +/usr/X11R6/lib/libGL\.so.* 	-- system_u:object_r:texrel_shlib_t
> > +
> 
> How about those:
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=145067

Dan has already marked certain shared objects with texrel_shlib_t in his
diffs; I was only adding libGL because I was also changing an existing
execmod allow rule for it to use the new texrel_shlib_t type.  I think
that the shared objects you originally listed are being reviewed by Red
Hat and some of them will be fixed, as not all of them truly require
text relocations.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
