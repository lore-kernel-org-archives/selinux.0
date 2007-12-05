Subject: RE: Effect of changing SELinux package versions...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D0432853D@de01exm68.ds.mot.com>
References: <472B817D.3030400@redhat.com>
	 <1194625539.624.57.camel@moss-spartans.epoch.ncsc.mil>
	 <47349353.7080203@redhat.com>
	 <D06FE0A2807BC145B0D38744789D4F5D0420612B@de01exm68.ds.mot.com>
	 <1194637184.624.78.camel@moss-spartans.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D0432853D@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 13:13:17 -0500
Message-Id: <1196878397.16006.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-12-05 at 13:00 -0500, Hasan Rezaul-CHR010 wrote:
> Hi Stephen,
> 
> So turns out that the core SELinux packages shown below are the versions
> in Fedora Core 7.
> 
> Are these versions known to be stable versions that will work well
> together ?  If not, where can I find the latest set of stable core
> SELinux packages ?
> 
> > 1.  audit 1.5.3
> > 2.  libselinux 2.0.13
> > 3.  libsemanage 2.0.1
> > 4.  libsepol 2.0.3
> > 5.  libsetrans 0.1.18
> > 6.  mcstrans 0.2.5
> > 7.  policycoreutils 2.0.16
> > 8.  setools 3.2-0

If they shipped together in a given Fedora release, then they should
work well together.  The only reason to move to a newer upstream version
would be if you needed some feature that didn't yet exist when that
Fedora release was made.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
