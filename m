Message-ID: <72222DC86846D411ABD300A0C9EB08A10152432C@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "'Howard Holm'"
	 <hdholm@epoch.ncsc.mil>, SeLinux@tycho.nsa.gov
Cc: sds@tislabs.com, pal@tycho.nsa.gov
Subject: RE: Policy
Date: Wed, 3 Apr 2002 14:43:28 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wednesday, April 03, 2002 2:12 PM, Russell wrote:

> How about the following for distributions other than Slackware:
> /usr/bin
> /usr/sbin
> /usr/include/selinux
> /usr/lib
> /usr/share/man
> /etc/policy

The reason I was putting every thing under /usr/local/selinux
was to get away from any distributions quirks. I really
have no argument about where to put the files, I would
like a consciences. Also we have to get the folks at the NSA
to agree.

I want to start building packages for selinux, I just don't
want to do a lot of rework when the location changes. I do think
we should find some place beside the source tree location. If I 
build a binary package (rpm .....) for installation a standard location
for the policy files would be nice. 

I do like Russell's Idea about two separate locations for the 
policy files. 

> 
> > When performing a make quickinstall the make will not overwrite
> > /usr/local/selinux/policy
> > /usr/local/selinux/setfiles
> > if those directories exist. If the directories do not exist
> > create them and then populate them with the example policy.
> >
> > The make will overwrite the example policy files.
> > /usr/share/doc/examples/policy
> > /usr/share/doc/examples/setfiles
> 
> s/doc/doc\/selinux/ for non-Slackware.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
