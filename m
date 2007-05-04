Subject: Re: Where to specific the handling of unknown kernel classes and
	perms
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Joshua Brindle <method@manicmethod.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <463B5356.1040804@redhat.com>
References: <1178141128.3897.33.camel@dhcp59-235.rdu.redhat.com>
	 <463930F3.7020803@manicmethod.com>
	 <1178196394.3443.135.camel@moss-spartans.epoch.ncsc.mil>
	 <4639E183.4080909@manicmethod.com>
	 <1178200479.3443.172.camel@moss-spartans.epoch.ncsc.mil>
	 <463A005B.3010504@manicmethod.com>  <463B5356.1040804@redhat.com>
Content-Type: text/plain
Date: Fri, 04 May 2007 12:15:58 -0400
Message-Id: <1178295358.15062.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-05-04 at 11:37 -0400, Daniel J Walsh wrote:
> Joshua Brindle wrote:
> > Stephen Smalley wrote:

<snip>

> >
> > Ok, I agree, we can work out how to change it on end systems without 
> > rebuilding the policy later. This should certainly be a managed 
> > setting so that we can enforce access control on it and audit if 
> > necessary.
> >

<snip>

> Is this possible to be a boolean?  Tunable eventually.
> 

Nope - but it could be an semanage command eventually (which would be
nice since it would generate audit messages).

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
