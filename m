Subject: Re: openssh
From: Timothy Wood <timothy@hallcomp.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <Pine.GSO.4.33.0208260944120.10972-100000@raven>
References: <Pine.GSO.4.33.0208260944120.10972-100000@raven>
Content-Type: text/plain; charset=koi8-r
Date: 26 Aug 2002 12:41:07 -0400
Message-Id: <1030380067.29699.89.camel@phobos>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

В Пнд, 26.08.2002, в 09:48, Stephen Smalley написал:
> 
> On 26 Aug 2002, Timothy Wood wrote:
> 
> > After installing the version of ssh that comes with SELinux I am unable
> > to connect to the machine.  I've followed the instructions in the
> > README.privsep to make sure everything is setup and still nothing.  I
> > tried a make install to reinstall it and I noticed that the install
> > reports that the sshd user is not setup despite the fact that it does
> > output the user id information for the sshd user when it calls id sshd
> > from the script.  There are no avc or log messages generated (other than
> > the normal ssh connect failed message) in enforcing or permissive mode.
> > I'd assume that this is a problem installing ssh since it doesn't even
> > work in permissive mode.  Any ideas as to what I've done wrong?
> 
> I assume that you restarted sshd (either by rebooting or by running
> run_init /etc/init.d/sshd restart)?  Are you using the latest release
> (2002082308, 23 August 2002) or the previous one (2002070313, 3 July
> 2002)?  Did you download from the NSA SELinux web site or the sourceforge
> CVS tree?
> 
> --
> Stephen D. Smalley, NAI Labs
> ssmalley@nai.com
> 
> 
> 
> 

I had to reboot because run_init has quit working for some reason, which
I hadn't noticed.  run_init is being denied transition.  BTW I had to
make my own /etc/init.d/sshd file because when I removed the RPMS for
the stock openssh it took that file with it. (I should have copied it
somewhere else before I removed the rpms but I forgot to do that) 
Anyhow I can send the avc message for the run_init later because I do
not have time right now, but as I previously mentioned the sshd is not
leaving any messages so I don't know if that'll be of any use unless the
problems are related somehow.

Previous release.  NSA site.

Timothy,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
