Date: Tue, 18 Mar 2008 09:15:25 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        selinux <selinux@tycho.nsa.gov>, linux-security-module@vger.kernel.org,
        casey@schaufler-ca.com
Subject: Re: [patch] selinux:  handle files opened with flags 3 by checking
 ioctl permission
In-Reply-To: <1205764248.4169.0.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0803180915000.25060@us.intercode.com.au>
References: <1205349239.2925.11.camel@localhost.localdomain>
 <7e0fb38c0803121220w21275aadl7f148eccf645a7f1@mail.gmail.com>
 <43af0f430803130456y844d429j2a64fb46ec4d71a7@mail.gmail.com>
 <1205504199.22912.52.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0803170840430.24928@us.intercode.com.au>
 <1205758518.22912.154.camel@moss-spartans.epoch.ncsc.mil>
 <1205764248.4169.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 17 Mar 2008, Eric Paris wrote:

> 
> On Mon, 2008-03-17 at 08:55 -0400, Stephen Smalley wrote:
> > On Mon, 2008-03-17 at 08:41 +1100, James Morris wrote:
> > > On Fri, 14 Mar 2008, Stephen Smalley wrote:
> > > 
> > > > Alternatively, we could default to returning FILE__IOCTL from
> > > > file_to_av() if the f_mode has neither FMODE_READ nor FMODE_WRITE, and
> > > > thus check ioctl permission on exec or transfer, thereby validating such
> > > > descriptors early as with normal r/w descriptors and catching leaks of
> > > > them prior to attempted usage.
> > > 
> > > I think this sounds like a good plan.
> > 
> > Handle files opened with flags 3 by checking ioctl permission.
> > 
> > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> Acked-by: Eric Paris <eparis@redhat.com>

Fixes the problem I was seeing.  Applied to for-akpm.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
