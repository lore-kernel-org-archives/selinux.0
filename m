Date: Thu, 29 Mar 2001 08:43:02 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: gawain.lynch@felicity-consulting.com.au
cc: SELinux@tycho.nsa.gov
Subject: Re: Problem in installation...
In-Reply-To: <OF47CED767.27D7E95D-ONCA256A1D.007D6A98@felicity.net.au>
Message-ID: <Pine.SOL.3.95.1010329082932.17401C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


People also had compiler problems with the older 2.2-based 
SELinux release on RedHat 7, but were able to address them
by using kgcc or by upgrading their gcc to the latest version.  
See the thread starting at 
http://www.nsa.gov/selinux/list-archive/0232.html.
However, it seemed like at least some of the problems
were due to using 2.2-based kernel sources rather than
2.4-based sources, so I'm not sure why there would
still be problems with the new release.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Thu, 29 Mar 2001 gawain.lynch@felicity-consulting.com.au wrote:

> I tracked one of the problems down.  A lot of people, myself included seem 
> to be trying to compile with Red Hat 7. 
> 
> The RH7 install is missing egcs (provides 
> /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/), which I installed off 
> my RH6.2 CD, _reinstalled_ the updated gcc and no more stddef.h error!
> 
> I still can't give anymore reasons as to the tools/build-kernel script 
> fails, but it will work if you have run make dep and commented that action 
> out of the script.
> 
> Cheers,
> 
> Gawain


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
