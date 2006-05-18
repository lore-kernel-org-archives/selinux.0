Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4ILCxr3019200
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 17:12:59 -0400
Received: from purple.iano.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4ILCw7v022203
	for <selinux@tycho.nsa.gov>; Thu, 18 May 2006 21:12:58 GMT
Date: Thu, 18 May 2006 17:12:45 -0400
From: Maria Iano <maria@iano.org>
To: Erich Schubert <erich@debian.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: correct way to set context in perl?
Message-ID: <20060518171245.Y26098@iano.org>
References: <20060518160656.V26098@iano.org> <1147985248.3617.2.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147985248.3617.2.camel@wintermute.xmldesign.de>; from erich@debian.org on Thu, May 18, 2006 at 10:47:27PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Eric,

Thanks for your response. The master and slave directories are separate. The zones are divided into over a hundred different groups (and growing). Individual users have access to edit zones in some groups and not others. Each group has its own directory. Under each group's directory are the master and slave directories. As new groups are created (by the perl scripts), new directories need to be created (as well as new files) and I need to be able to give them the correct security contexts, and there will be two different types under each group directory.

It looks like this:

                                 data
                                  |
      ___________________________________________________________
     |                      |
    grp1                   grp2          ... and so on ...
     |                      |
  __________          ____________
  |        |          |           |
master   slave    master       slave

Of course I built this directory structure with no thought of selinux at the time. Perhaps I should just redo the directory structure so anything new created just inherits the correct context.

Thanks,
Maria

On Thu, May 18, at 10:47%P so wrote Erich Schubert (erich@debian.org):

> Hi,
> I'd recommend to use different directories for master and slave zones.
> I used to do that back in kernel 2.0 days already.
> It's nice to know you can nuke the contents of the slave dir and not
> lose any data. ;-) Also I made the slave directory writable by the name
> server, the master directory not. There are a couple of reasons to do
> such things
> (e.g. if you have zones with dynamic updates enabled, you might also
> want to put them into a separate directory, while keeping the "root"
> zone files protected.
> I for example have a dyn.domain.tld zone which is updateable, and some
> CNAMES
> from the static zone file pointing in there)
> 
> best regards,
> Erich Schubert
> -- 
>     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
>    There was never a good war or a bad peace. - Benjamin Franklin   //\
>     Mathematik: Das Alphabet, mit dessen Hilfe Gott das Universum   V_/_
>                 beschrieben hat. --- Galileo Galilei

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
