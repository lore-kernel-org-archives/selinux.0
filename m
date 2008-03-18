Subject: Re: [patch] selinux:  handle files opened with flags 3 by checking
	ioctl permission
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        selinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
        casey@schaufler-ca.com
In-Reply-To: <1205792367.2891.1.camel@localhost.localdomain>
References: <1205349239.2925.11.camel@localhost.localdomain>
	 <7e0fb38c0803121220w21275aadl7f148eccf645a7f1@mail.gmail.com>
	 <43af0f430803130456y844d429j2a64fb46ec4d71a7@mail.gmail.com>
	 <1205504199.22912.52.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0803170840430.24928@us.intercode.com.au>
	 <1205758518.22912.154.camel@moss-spartans.epoch.ncsc.mil>
	 <1205764248.4169.0.camel@localhost.localdomain>
	 <Xine.LNX.4.64.0803180915000.25060@us.intercode.com.au>
	 <1205792367.2891.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 18 Mar 2008 08:52:36 -0400
Message-Id: <1205844756.6466.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-03-17 at 18:19 -0400, Eric Paris wrote:
> On Tue, 2008-03-18 at 09:15 +1100, James Morris wrote:
> > On Mon, 17 Mar 2008, Eric Paris wrote:
> > 
> > > 
> > > On Mon, 2008-03-17 at 08:55 -0400, Stephen Smalley wrote:
> > > > On Mon, 2008-03-17 at 08:41 +1100, James Morris wrote:
> > > > > On Fri, 14 Mar 2008, Stephen Smalley wrote:
> > > > > 
> > > > > > Alternatively, we could default to returning FILE__IOCTL from
> > > > > > file_to_av() if the f_mode has neither FMODE_READ nor FMODE_WRITE, and
> > > > > > thus check ioctl permission on exec or transfer, thereby validating such
> > > > > > descriptors early as with normal r/w descriptors and catching leaks of
> > > > > > them prior to attempted usage.
> > > > > 
> > > > > I think this sounds like a good plan.
> > > > 
> > > > Handle files opened with flags 3 by checking ioctl permission.
> > > > 
> > > > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > > 
> > > Acked-by: Eric Paris <eparis@redhat.com>
> > 
> > Fixes the problem I was seeing.  Applied to for-akpm.
> 
> Are you at least now seeing a FILE__IOCTL avc for mdadm?  If not why
> would mdadm have that permission for /dev/null?

ioctl permission is widely granted due to the common use of ioctl for
probing the object type (isatty).  The common permission set macros
usually include it whenever they include read or write.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
