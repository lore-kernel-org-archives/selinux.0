Content-Type: text/plain;
  charset="windows-1252"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Mark Westerman" <mark.westerman@westcam.com>, <SELinux@tycho.nsa.gov>
Subject: Re: Security Enhanced Linux distro
Date: Fri, 15 Nov 2002 14:16:15 +0100
References: <862636C39A8D56448223B94D19757133015E91@server.westcam.com>
In-Reply-To: <862636C39A8D56448223B94D19757133015E91@server.westcam.com>
Cc: bam@snoopy.apana.org.au
MIME-Version: 1.0
Message-Id: <200211151416.15981.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 15 Nov 2002 13:54, Mark Westerman wrote:
> >OK.  Could you please tell us more about this distro.  What is it based
> > on, what have you done to make is a "SE Linux distro"?
> >
> >Is the distro based on RPM or Debian packaging systems?
> >If RPM then have you solved the issues of upgrading a live system?  If so
> > >then  please release it.
>
> The distro uses anaconda to load the OS onto the disk and is RPM based. No
> we still have not solved the upgrading a live system. One way we have been
> trying to approach the problem is to look at all the files in the package
> and relabel according to existing labels.

That's what I do.  I have a modified version of dpkg to relabel the files 
after the package is unpacked but before the postinst script is run.  However 
this is still not quite satisfactory for upgrades of important packages such 
as libc6 as for a short time window it may be impossible to run dynamically 
linked programs.

For the moment I am taking the approach that when you do something so serious 
and significant as upgrading libc6 then having programs in domains other than 
sysadm_t be unable to execute other programs temporarily is not a serious 
problem.  Upgrading libc6 is not something that you expect to be entirely 
transperant (consider all the times that a libc6 upgrade required daemons 
such as sshd to be restarted for correct operation).

> The problem comes when there are
> new files, and the scripts in the rpm package uses to update any existing
> files.

Yes, little things like the following in a postinst are a real bitch:
some_program > /tmp/foo ; mv /tmp/foo /etc

Of course the fact that most occurances of such things are a security hole on 
non-SE systems makes it easier to get them fixed.  ;)

> Still requires a relabel of the files system, which can take a while
> depending on CPU speed, Disk speed, and how much you have loaded on you
> system.

A relabel of a live file system is not an option except in the most extreme 
situations.  In the NSA policy /tmp and /var/tmp will be relabelled and thus 
access to open temporary files will be denied (and in the case of /var/tmp it 
may interfere with the next system boot).

Also relabelling of /home is really undesirable for obvious reasons, and if 
you have only a single file system (typical for workstations and small 
servers) then you'll need to specifically exclude /home from the relabel.

Finally, some of the systems I run take over 30 minutes to relabel all the 
file systems (and I don't have SE installed on anything I consider to be a 
big server).  I could halve that or better by optimising setfiles but it 
would still be excessively long (and of course if a security issue is opened 
the window will be long enough to be easily exploitable).

> We have even
> started to convert the rules to XML so update to policies can be handled
> more programmatically. The initial XML version uses XLST template to create
> the policy.conf file and uses the checkpolicy to compile the policy.conf
> file. The XML stuff is not near ready for public consumption.

Brian May has started work on similar things.  What you have developed may not 
be ready for public consumption, but it may be ready to be sent to Brian.  
I'm sure that Brian could offer some useful suggestions for it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
