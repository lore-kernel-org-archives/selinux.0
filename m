Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3IMS4mw005631
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 18:28:04 -0400
Received: from relay1.gtri.gatech.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3IMS3Yk027301
	for <selinux@tycho.nsa.gov>; Fri, 18 Apr 2008 22:28:03 GMT
Subject: Re: [refpolicy] RFC: hal_read_log interface
From: rob myers <rob.myers@gtri.gatech.edu>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
In-Reply-To: <1208534100.7113.9.camel@gorn>
References: <1208213525.31069.77.camel@rxm-581b.stl.gtri.gatech.edu>
	 <1208534100.7113.9.camel@gorn>
Content-Type: text/plain
Date: Fri, 18 Apr 2008 18:28:01 -0400
Message-ID: <1208557681.31069.329.camel@rxm-581b.stl.gtri.gatech.edu>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-04-18 at 11:55 -0400, Christopher J. PeBenito wrote:
> On Mon, 2008-04-14 at 18:52 -0400, rob myers wrote:
> > While trying to create a domain that could read all the files
> > in /var/log, I noticed that hald_log_t files do not have the logfile
> > attribute.  This appears to be intentional because the
> > logging_log_filetrans interface was used instead of the logging_log_file
> > interface.  Is this still the intention?
> > 
> > Attached is a patch to add an interface to allow domains to read
> > hald_log_t in case hald_log_t needs to remain a private type.
> 
> The filetrans interface is needed so that when hal creates it's log
> in /var/log, it gets the correct type.  It should also have the log_file
> interface too, since its a log file.  I changed hald_log_t to be a log
> file.

If hald_log_t is a log file, then I no longer need my proposed
hal_read_log interface.  If anyone else desires that interface let me
know and I would be glad to clean up the patch and resubmit.

Thanks,

rob.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
