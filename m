Date: Fri, 24 Oct 2003 09:38:32 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Eamon Walsh <ewalsh@epoch.ncsc.mil>
cc: lky <lky77@sjtu.edu.cn>, SELINUX <SELinux@tycho.nsa.gov>
Subject: Re: problem about boot
In-Reply-To: <1066951180.22348.31.camel@moss-tarheels.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0310240936420.3347-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 23 Oct 2003, Eamon Walsh wrote:

> You need new modutils for the 2.6 kernel.  You can get them from
> http://www.kernel.org/pub/linux/kernel/people/rusty/modules
> (I'd suggest using the SRPM at the bottom of the list).
> 
> You also need to change /etc/rc.d/rc.sysinit to make the modules load
> automatically.  See the "Modules" section of:
> http://www.codemonkey.org.uk/post-halloween-2.5.txt
> 
> And looking ahead, once you get the 2.6 kernel working, rpm is not going
> to work.  To fix that, see the "Regressions" section of the same
> document.


Another option is to download and install Fedora, as it is set up for 2.6 
kernels.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
