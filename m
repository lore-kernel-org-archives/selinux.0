Subject: Re: adding objects classes and permissions to policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: Andy Warner <warner@rubix.com>, selinux@tycho.nsa.gov
In-Reply-To: <cadfc0e40810161302m18dd3c0er54ee77c598cdc902@mail.gmail.com>
References: <48F798BB.6070602@rubix.com>
	 <cadfc0e40810161302m18dd3c0er54ee77c598cdc902@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 16:06:12 -0400
Message-Id: <1224187572.9247.144.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-10-16 at 15:02 -0500, Xavier Toth wrote:
> On Thu, Oct 16, 2008 at 2:40 PM, Andy Warner <warner@rubix.com> wrote:
> >
> > When adding new object classes and permissions to SELinux policy is it
> > necessary to re-create flask.h and av_permissions.h header files so that a
> > user-space object manager can access the associated defines? If so, would
> > someone give me some pointers as to how these are generated?
> >
> > Thanks,
> >
> > Andy
> >
> This might help:
> http://selinuxproject.org/page/Adding_New_Permissions

Deprecated for userspace object managers, should only be followed for
kernel classes/permissions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
