Subject: Re: new file contexts
From: Timothy Wood <timothy@hallcomp.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0208231010230.20183-100000@raven>
References: <Pine.GSO.4.33.0208231010230.20183-100000@raven>
Content-Type: text/plain; charset=koi8-r
Date: 23 Aug 2002 10:47:15 -0400
Message-Id: <1030114035.16278.31.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

В Птн, 23.08.2002, в 10:14, Stephen Smalley написал:
> 
> On 23 Aug 2002, Timothy Wood wrote:
> 
> > So then I am required to have a corresponding .te for my new .fc file
> > correct?
> 
> Yes, and this is typically what you want - there should be no reason to
> have a program .fc file if there is no corresponding program .te file
> (Where else would the program's domain and types be defined in the
> policy?).  If for some reason you do not have any corresponding program
> .te file (this would be odd, and I'd be interested in the explanation),
> you could directly edit file_contexts/type.fc to add your entries or you
> could add your new .fc file to the FCFILES= definition in the
> policy/Makefile.
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com

I have a Window Manager that installs itself in /usr/apps (ROX
http://rox.sourceforge.net ).  I need to label all of the AppRun files
in the subdirectories, as well as a few other files, in the
system_u:object_r:bin_t context.  I don't really need to change anything
else for it to work because I relabeled them and everything runs ok.
What I did was when remaking the policy didn't seem to pickup the new
.fc I appended it to an existing .fc to see if it would read the changes
from there.  The relabeling worked after that, obviously, but I couldn't
figure out why it didn't pickup my new .fc file.  Though now I know it
needs a .te file to look for a .fc file.  At any rate, the changes I
made just relabel the ROX executable files as if they were installed in
the /usr/bin directory, so they really don't need their own domain
(gnome doesn't so I don't see why ROX would).  So should I just append
these changes to the types.fc since that is where the generic /usr/bin
type is located or would it be better to leave them in the already
seperate rox.fc and change the Makefile?

here are my changes:

# ROX
/usr/apps/ROX-Filer/Linux-ix86/ROX-Filer		system_u:object_r:bin_t
/usr/apps/ROX-Session/Linux-ix86/ROX-Session		system_u:object_r:bin_t
/usr/apps/(.*)/AppRun		system_u:object_r:bin_t

Timothy,



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
