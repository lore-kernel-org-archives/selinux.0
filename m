Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j177rY53019484
	for <selinux@tycho.nsa.gov>; Mon, 7 Feb 2005 02:53:34 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j177pOv3012198
	for <selinux@tycho.nsa.gov>; Mon, 7 Feb 2005 07:51:24 GMT
Subject: Re: Latest diffs
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107530908.31488.1.camel@cobra.ivg2.net>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
	 <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
	 <1107349736.890.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1107350272.890.82.camel@moss-spartans.epoch.ncsc.mil>
	 <4200D68A.6030309@redhat.com> <1107478728.4065.3.camel@cobra.ivg2.net>
	 <42037FDC.9000908@redhat.com>
	 <1107526206.8078.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1107530908.31488.1.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 02:53:52 -0500
Message-Id: <1107762833.7200.4.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-02-04 at 10:28 -0500, Ivan Gyurdiev wrote:
> On Fri, 2005-02-04 at 09:10 -0500, Stephen Smalley wrote:
> > On Fri, 2005-02-04 at 08:59, Daniel J Walsh wrote:
> > > You need to set the boolean
> > > 
> > > setsebool -P allow_execmod 1
> > >  On fresh installs this will be in there. 
> 
> Right, but the boolean is for user_t, and not for X.
> For X the whole execmod rule was removed, which is why I get denials.

And now execmod denials for user_mozilla_t and flash are back again.
Those in addition to the mozilla execmem denials I posted about earlier.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
