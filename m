Subject: Re: Error running semanage from trunk
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Brian M. Williams" <bwilliams@tresys.com>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158801CD22C7@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158801CD22C7@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 Apr 2008 12:44:24 -0400
Message-Id: <1207241064.27710.225.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-04-03 at 11:45 -0400, Brian M. Williams wrote:
> I built the toolchain out of trunk this morning (rev 2860); I have
> python 2.4.3 installed on RHEL 5.1, running semanage with any input
> gives this error:
> 
> [root@localhost policy]# semanage
> Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 24, in ?
>     import seobject
>   File "/usr/lib/python2.4/site-packages/seobject.py", line 93, in ?
>     import xml.etree.ElementTree
> ImportError: No module named etree.ElementTree
> 
> Does anyone know where this might be coming from?  Does semanage need a
> newer version of python?

Provided by /usr/lib/python2.5/xml/etree in Fedora.
Introduced into seobject.py in r2700.
Don't know if there is a version for python 2.4.

So that would make semanage, audit2allow, and chcat dependent on newer
python in trunk.  Of course, sepolgen was already dependent on newer
python, so audit2allow already had that dependency.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
