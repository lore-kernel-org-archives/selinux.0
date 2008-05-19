Subject: Re: [RFC][PATCH] selinux:  simplify ioctl checking
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1210595177.6206.21.camel@moss-spartans.epoch.ncsc.mil>
References: <1210336991.6434.200.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805121034110.22560@us.intercode.com.au>
	 <1210595177.6206.21.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 19 May 2008 08:36:03 -0400
Message-Id: <1211200563.7486.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-05-12 at 08:26 -0400, Stephen Smalley wrote:
> On Mon, 2008-05-12 at 10:34 +1000, James Morris wrote:
> > On Fri, 9 May 2008, Stephen Smalley wrote:
> > 
> > > Simplify and improve the robustness of the SELinux ioctl checking by 
> > > using the "access mode" bits of the ioctl command to determine the 
> > > permission check rather than dealing with individual command values.
> > > This removes any knowledge of specific ioctl commands from SELinux
> > > and follows the same guidance we gave to Smack earlier.
> > 
> > Looks good to me, let me know if you want it applied to for-akpm.
> 
> Could we perhaps get it added to the F10/rawhide kernel for a while and
> mention it on fedora-devel-list for people to look out for cases where
> it causes any failures with existing policy?  That will help us to know
> whether we need to introduce a compatibility knob / policy capability
> for it or if we can just make this change unconditionally.

Eric - any indications of breakage in rawhide from this change?  If not,
then I think we can likely queue it up on the for-akpm branch and target
2.6.27.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
