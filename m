Subject: Re: SELinux on Wheezy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328543813.1905.2.camel@x220.mydomain.internal>
	 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 12:47:06 -0500
Message-ID: <1328636826.2162.60.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-02-07 at 09:35 -0800, C.J. Adams-Collier KF7BMP wrote:
> On Mon, 2012-02-06 at 08:21 -0800, C.J. Adams-Collier KF7BMP wrote:
> > On Mon, 2012-02-06 at 16:56 +0100, Dominick Grift wrote:
> > > On Sun, 2012-02-05 at 20:26 -0800, C.J. Adams-Collier KF7BMP wrote:
> > > > Hey folks,
> > > > 
> > > > I brought up a wheezy install on an alternate lvm root a couple of weeks
> > > > ago.  I turned SELinux on shortly thereafter.  I think I updated my
> > > > kernel, and now X won't start.  Could someone look at these logs with me
> > > > and help figure out what's going on?  Something showed up during boot
> > > > that said something about updating labels, but I didn't capture it.
> > > > Where should I look to find these boot logs, do you think?
> > > > 
> > > > http://www.colliertech.org/federal/nsa/selinux-20120205T2023PST.log
> > > > 
> > > > Thank you in advance!
> > > > 
> > > > C.J.
> > > > 
> > > > 
> > > 
> > > Seems to be an XACE issue.
> > > 
> > > > > /var/log/Xorg.56.log.old:[    46.050] SELinux: a property label lookup failed!
> > > > > /var/log/Xorg.56.log.old:[    46.050] SELinux: Failed to set label property on window!
> > > 
> > > getsebool -a | xserver_object_manager
> > > 
> > > Does it work if you set it to off?
> > > 
> > > setsebool -P xserver_object_manager off
> > > 
> > > http://selinuxproject.org/page/NB_XWIN
> > 
> > Thank you Dominick.  I will give this a try when I re-boot.
> > 
> > Russell, do you think this is something we should patch in to the xorg
> > debian packaging?
> > 
> 
> 
> http://www.colliertech.org/federal/nsa/sebool-20120206T091638.log:
> cjac@foxtrot:~$ sudo getsebool -a | grep -i xserver_object_manager | wc -l
> 0
> cjac@foxtrot:~$ sudo setsebool -P xserver_object_manager off
> libsemanage.dbase_llist_set: record not found in the database (No such file or directory).
> libsemanage.dbase_llist_set: could not set record value (No such file or directory).
> Could not change boolean xserver_object_manager
> Could not change policy booleans
> 
> How do I fill these in?  Is there a .deb with the correct policy
> modification?

That's interesting - suggests that you do not have the xserver policy
module installed.  semodule -l shows what?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
