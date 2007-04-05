Subject: Re: secmark integration
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <461553B6.9050303@tycho.nsa.gov>
References: <Line.LNX.4.64.0703191021480.22828@d.namei>
	 <1175284031.3602.24.camel@localhost.localdomain>
	 <1175286309.20396.13.camel@localhost.localdomain>
	 <Line.LNX.4.64.0703302201520.29742@d.namei>  <46111709.9060402@redhat.com>
	 <1175525718.20396.46.camel@localhost.localdomain>
	 <1175526952.14681.44.camel@sgc>
	 <1175534120.5433.2.camel@localhost.localdomain>
	 <1175707323.11382.25.camel@sgc.columbia.tresys.com>
	 <1175717294.3191.2.camel@localhost.localdomain>
	 <46140FCA.5020901@redhat.com>
	 <1175788131.3174.4.camel@localhost.localdomain>
	 <1175792799.17676.10.camel@sgc>
	 <1175794800.2902.6.camel@localhost.localdomain>
	 <1175795226.5711.92.camel@moss-spartans.epoch.ncsc.mil>
	 <1175796134.17676.17.camel@sgc>
	 <1175795963.5711.99.camel@moss-spartans.epoch.ncsc.mil>
	 <1175798799.17676.19.camel@sgc>
	 <1175800942.5711.141.camel@moss-spartans.epoch.ncsc.mil>
	 <461553B6.9050303@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 15:59:35 -0400
Message-Id: <1175803175.5711.161.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-05 at 15:53 -0400, Eamon Walsh wrote:
> Stephen Smalley wrote:
> > On Thu, 2007-04-05 at 14:46 -0400, Christopher J. PeBenito wrote:
> >> On Thu, 2007-04-05 at 13:59 -0400, Stephen Smalley wrote:
> >>> On Thu, 2007-04-05 at 14:02 -0400, Christopher J. PeBenito wrote:
> >>>> On Thu, 2007-04-05 at 13:47 -0400, Stephen Smalley wrote:
> >>>>> On Thu, 2007-04-05 at 13:40 -0400, Karl MacMillan wrote:
> >>>>>> That sounds fine to me (assuming I understand), but I thought people
> >>>>>> were concerned about the number of booleans.
> >>>>> We just need a per-domain subtree of booleans under /selinux/booleans ;)
> >>>>> /selinux/booleans/httpd_t/enable_cgi 
> >>>>>
> >>>>> Speaking of which, we do want to try to go with a one file per value
> >>>>> approach in selinuxfs, so on the dynamic class/perm discovery work,
> >>>>> let's try to provide a nice directory tree form of it.
> >>>> Ok, that means I get to start over. :)  I was doing some final debugging
> >>>> on a single /selinux/class node that uses a simple transaction
> >>>> like /selinux/access.
> >>>>
> >>>> Just to be certain, you're asking for
> >>>>
> >>>> /selinux/class/[classname]/index
> >>>> /selinux/class/[classname]/[permname]
> >>>>
> >>>> where each of those just return the values?
> >>> Yes, doesn't that sound nicer?
> >> Its fine with me, though it was just mentioned to me that we'll have
> >> problems if there is a future perm named index.  Suggestions on what to
> >> call that node?
> > 
> > 00index ;)
> > 
> 
> Directories are cheap:
> 
> /selinux/class/[classname]/index
> /selinux/class/[classname]/perms/[permname]

Yes, that's a better idea.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
