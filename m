Subject: Re: [PATCH] kernel: Dynamic port labeling
From: Paul Nuzzi <pjnuzzi@tycho.ncsc.mil>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>,
        "George S. Coker, II" <gscoker@alpha.ncsc.mil>
In-Reply-To: <4B06AD18.2010007@manicmethod.com>
References: <1258657635.2753.8.camel@moss-stripedbass.epoch.ncsc.mil>
	 <4B06AD18.2010007@manicmethod.com>
Content-Type: text/plain
Date: Fri, 20 Nov 2009 11:20:58 -0500
Message-Id: <1258734058.2606.48.camel@moss-stripedbass.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-11-20 at 09:52 -0500, Joshua Brindle wrote: 
> 
> Paul Nuzzi wrote:
> > Added a mechanism to add/delete/update port labels with an interface in
> > the selinuxfs filesystem.  This will give administrators the ability to
> > update port labels faster than reloading the entire policy with
> > semanage.  The administrator will also need less privilege since they
> > don't have to be authorized to reload the full policy. Let me know what
> > you think of the patch.  Not sure if the policy_rwlock semaphore needs
> > to be taken before modifying the ocontext list.
> >
> > A listing of all port labels will be output if the file /selinux/rw_port
> > is read.  Labels could be added or deleted with the following commands
> >
> 
> why rw_port? That doesn't seem intuitive. Using "portcon" would match 
> what users already know about.

I wasn't sure what to call it.  Portcon works for me.

> Also, this isn't atomic, if a connection is made between the above 2 
> commands the port will be mislabeled. IMHO these operations, especially 
> delete/add ones like above must happen atomically.

Based on the above example you don't need to delete the port and add it
to relabel.  You can run add on an existing labeled port to change it
atomically.  

> > echo -n "del system_u:object_r:ssh_port_t:s0 6 22">  /selinux/rw_port
> > echo -n "add system_u:object_r:telnetd_port_t:s0 6 22">  /selinux/rw_port
> >
> 
> How are you handling ordering? Would someone need to delete all ports 
> and re-add them all to ensure they are before the catchall 1-1024 and 
> 1025-65535 portcons?

Everything is added to the front of the list and take precedence to the
labels behind it.  If a port is added or deleted the catchalls will be
unaffected.

> >
> > Signed-off-by: Paul Nuzzi<pjnuzzi@tycho.ncsc.mil>
> >
> > ---
> >   security/selinux/hooks.c            |    1
> >   security/selinux/include/classmap.h |    2
> >   security/selinux/include/security.h |    9 ++
> >   security/selinux/selinuxfs.c        |   96 +++++++++++++++++++++
> >   security/selinux/ss/services.c      |  159 ++++++++++++++++++++++++++++++++++++
> >   5 files changed, 265 insertions(+), 2 deletions(-)
> >



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
