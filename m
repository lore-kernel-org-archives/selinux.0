Message-ID: <72222DC86846D411ABD300A0C9EB08A101524366@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>,
        "'Reino Wallin'" <reino@oribium.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: RE: SELinux RPM Version
Date: Thu, 25 Apr 2002 09:14:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, April 25, 2002 8:51 AM, Russell Coker wrote:

> On Thu, 25 Apr 2002 14:48, Westerman, Mark wrote:
> > In the Filesystem Hierarchy Standard (FHS) document for the
> > Linux Standard Base.
> >
> > "Any program or package which contains or requires data the doesn't
> > need to modified should store that data in /usr/share. "
> >
> > the doc subdirectory if for "Miscellaneous documentation"
> 
> IMHO that means that /usr/share/selinux is better than 
> /usr/share/doc/selinux 
> for the sample policy files.
> 

While it is true that the policy do not contain any comments per say,
the fact that the examples show you an "example policy" in 
itself is documentation. I have use the term 
self documentation code. 

Mark

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
