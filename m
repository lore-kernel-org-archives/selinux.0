MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: object class discovery userland
Date: Fri, 20 Apr 2007 10:23:59 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588A7180A@exchange.columbia.tresys.com>
In-Reply-To: <1177078673.4625.1.camel@localhost.localdomain>
References: <1177077717.15762.32.camel@sgc> <6FE441CD9F0C0C479F2D88F959B01588A717F1@exchange.columbia.tresys.com> <1177078673.4625.1.camel@localhost.localdomain>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        "SELinux Mail List" <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> On Fri, 2007-04-20 at 10:04 -0400, Joshua Brindle wrote:
> > > From: Christopher J. PeBenito
> > > 
> > > I have nearly completed the kernel patch for object class 
> discovery 
> > > which creates the structure:
> > > 
> > > /selinux/class/CLASSNAME/index
> > > /selinux/class/CLASSNAME/perms/PERMNAME
> > > 
> > > so you get the class index number from the index file, and the 
> > > permission name file gets the index number of the permission.  I 
> > > started looking at the userland side of this, and there are some 
> > > relevant
> > > functions:
> > > 
> > > security_class_t string_to_security_class(const char 
> *name); const 
> > > char *security_class_to_string(security_class_t cls);
> > > 
> > > access_vector_t string_to_av_perm(security_class_t tclass, const 
> > > char *name); const char 
> *security_av_perm_to_string(security_class_t 
> > > tclass, access_vector_t perm);
> > > 
> > > The implementation for the first one is straightforward, 
> just look 
> > > at the index file for the class.  The other three are a 
> little more 
> > > problematic with the above structure since they use an 
> index, since 
> > > it would have to search through the CLASSNAME/index files to find 
> > > the right one.
> > > 
> > > So to get the reverse lookup we could:
> > > 1. search /selinux/class/ in the userland code 2. create symlinks 
> > > /selinux/class, one possible structure:
> > > 
> > > /selinux/class/1 -> security
> > > /selinux/class/2 -> process
> > > /selinux/class/security/perms/1 -> compute_av
> > > /selinux/class/security/perms/2 -> compute_create
> > > 
> > > 3. stop exporting class and perm indexes outside of the 
> libraries.  
> > > Then the reverse lookup wouldn't be needed.  This would 
> involve some 
> > > overhauling of the libraries.
> > > 
> > > 4. other ideas?
> > > 
> > 
> > I think we should do the symlink thing to support the current 
> > interfaces but mark them as deprecated and implement a new string 
> > based API. Then work on getting all the object managers 
> switched over 
> > to the string API and eventually deprecate the userspace 
> side and remove the symlinks.
> > 
> 
> If it is deprecated then why do the symlinks? It is only an 
> optimization and libselinux can cache the mappings after the 
> first lookup. The symlinks also complicate the code to do 
> string lookup (because they have to ignore the numeric nodes).
> 

The lookup is done by opening %s/perm/%s,class,perm just like the other
libselinux code, not by traversing the directory structure so there is
no complication or ignoring the numeric nodes.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
