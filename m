Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA788uw9014563
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 03:08:56 -0500
Received: from asav3.lyse.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA788tcW027212
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 08:08:56 GMT
Date: Fri, 7 Nov 2008 09:08:50 +0100
From: Jan-Frode Myklebust <janfrode@tanso.net>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>
Subject: Re: user guide draft: "Port Numbers"
Message-ID: <20081107080850.GA19548@lc4eb5760521341.ibm.com>
References: <4912A65C.7090906@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4912A65C.7090906@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 06, 2008 at 06:10:04PM +1000, Murray McAllister wrote:
> I renamed "Booleans for Confined Services" to "How are Confined Services  
> Running?", and added a little about port numbers:
>
> ...
>
> Port Numbers
>
> Depending on policy configuration, services may only be allowed to run  
> on certain port numbers. Attempting to change which port a servers runs  
> on without changing policy may result in the service failing to start.  
> For example, run the semanage port -l | grep http command to list http  
> related ports:

Can one redefine the policy defined http_port's ? I.e. change port 80
from http_port_t to http_cache_port_t ? I don't think this is possible, 
but it would be nice with some clarification in the user guide..


  -jf

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
