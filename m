Subject: Re: semanage and semodule failures...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Steve Grubb <sgrubb@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1187896538.1451.640.camel@moss-spartans.epoch.ncsc.mil>
References: <D06FE0A2807BC145B0D38744789D4F5D03EA1C75@de01exm68.ds.mot.com>
	 <1187896538.1451.640.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 15:22:31 -0400
Message-Id: <1187896951.1451.644.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-23 at 15:15 -0400, Stephen Smalley wrote:
> On Thu, 2007-08-23 at 13:32 -0400, Hasan Rezaul-CHR010 wrote:
> > Hi All,
> > 
> > I am running SELinux in STRICT mode on an embedded Linux card (running
> > Linux 2.6.14).
> > 
> > Initially had the following versions of core SELinux libs :
> > 
> >  [ libsemanage-1.6.17-1 , checkpolicy-1.33.1-2 , libsepol-1.15.3-1 ,
> > libselinux-1.33.4-2 , policycoreutils-1.34.1-4 ]
> > 
> > With the above versions, "semanage" and "semodule" would work just
> > fine ! However, the problem was that everytime any minor policy change
> > was made using semanage or semodule,
> > a  /etc/selinux/strict/modules/previous/   directory would get created
> > with redundant policy info, and  waste a lot of space on my Linux
> > Card !
> > 
> > In order to eliminate creation of this unnecessary "previous"
> > directory, Stephen Smalley suggested that I upgrade my core SELinux
> > libs to the following newer/stable versions:
> > 
> > [ libsemanage-1.10.4 ,
> > checkpolicy-1.34.3-x , libsepol-1.16.3-x , libselinux-1.34.10-x , policycoreutils-1.34.10-x ]...
> > 
> > However, with these newer lib versions, I cant successfully make any
> > policy changes anymore  :-(   Any ideas ?
> > 
> >  
> > 
> > root# semodule -r myPolicy
> > 
> > libsemanage.semanage_make_sandbox: Could not copy files to
> > sandbox /etc/selinux/strict/modules/tmp.
> > 
> > semodule:  Failed on myPolicy!
> > 
> >  
> > 
> > root# semanage login -a -s staff_u Admin
> > 
> > libsemanage.semanage_make_sandbox: Could not copy files to
> > sandbox /etc/selinux/strict/modules/tmp.
> > 
> > /usr/sbin/semanage: Could not start semanage transaction
> > 
> >  
> > 
> > *** Note: I did run "restorecon -rF /etc/selinux/strict/modules"
> > 
> >              I also gave full (777) permissions to
> > the /etc/selinux/strict/modules  directory...   same result  :-(
> 
> Any avc messages in /var/log/messages or /var/log/audit/audit.log?
> 
> Filesystem full?  Filesystem mounted read-only?

Note:  We should have libsemanage include strerror(errno) in its error
messages.   Especially ones from system calls like this.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
