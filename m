Message-ID: <72222DC86846D411ABD300A0C9EB08A10152433F@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Russell Coker'" <russell@coker.com.au>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>,
        "'Stephen Smalley'" <sds@tislabs.com>,
        Howard Holm <hdholm@epoch.ncsc.mil>
Cc: Tom <tom@lemuria.org>, SELinux@tycho.nsa.gov
Subject: RE: db conflict ?
Date: Fri, 12 Apr 2002 13:13:06 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Where every they want to put the selinux files I don't care.
I am in the process of build an rpm package (80%) complete.
I am trying to keep close to a standard NSA installation as possible.
The policy and setfiles do not belong with the source, Plus
with the rpm packages I am building, unless you install the source
rpm the source will not be there. So I am left with a question of where
to put the files. Since the NSA wants to put things in /usr/local/selinux
I will keep with that for now. If you can convince them to put them other
places OK with me.

Since you and built a Debian package I would also like keep it similar
to yours.  

What is you directory structure ? (include utils)

Mark,

> -----Original Message-----
> From: Russell Coker [mailto:russell@coker.com.au]
> Sent: Friday, April 12, 2002 1:04 PM
> To: Westerman, Mark; 'Stephen Smalley'; Howard Holm
> Cc: Tom; SELinux@tycho.nsa.gov
> Subject: Re: db conflict ?
> 
> 
> On Fri, 12 Apr 2002 19:37, Westerman, Mark wrote:
> > Could you think about placing the policy sources
> > into the /usr/local/selinux Directory
> >
> > (i.e.
> > 	/usr/local/selinux/policy
> > 	/usr/local/selinux/setfiles
> > 	/usr/local/selinux/share/doc/examples/policy
> > 	/usr/local/selinux/share/doc/examples/setfiles
> 
> I don't like any of that.
> 
> /usr/local is for the local sysadmin to copy files into, not 
> for packaged 
> software.
> 
> > For new version of selinux the install could look and
> > see if there is a /usr/local/selinux/policy and setfiles
> > if the directories are present the install will populate then
> > with the example policy. If the directories are present just
> > overwrite the /usr/local/selinux/share/doc/example files.
> 
> That's mostly what I'm doing with my Debian packages, but 
> with /etc/selinux.
> 
> -- 
> If you send email to me or to a mailing list that I use which 
> has >4 lines
> of legalistic junk at the end then you are specifically 
> authorizing me to do
> whatever I wish with the message and all other messages from 
> your domain, by
> posting the message you agree that your long legalistic sig is void.
> 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
