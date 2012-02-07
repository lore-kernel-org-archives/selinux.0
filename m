Subject: Re: SELinux on Wheezy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
In-Reply-To: <1328570597.4395.36.camel@foxtrot.cjac.ntr.f5net.com>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328542762.9705.62.camel@moss-pluto>
	 <1328545024.7648.12.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328570597.4395.36.camel@foxtrot.cjac.ntr.f5net.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 07 Feb 2012 12:42:36 -0500
Message-ID: <1328636556.2162.59.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2012-02-06 at 15:23 -0800, C.J. Adams-Collier KF7BMP wrote:
> Here are the logs you requested:
> 
> http://www.colliertech.org/federal/nsa/avc-20120206T090101.log
> 
> http://www.colliertech.org/federal/nsa/sestatus-20120206T090618.log
> 
> It seems to me that the Debian SELinux docs could use some improvement.
> To this end, I have submitted an application to join the SELinux project
> on Alioth.  I will probably make some updates to the wiki pages as well.
> 
> I am going to install the packages which provide the tools you and
> Dominick recommended this morning and dig a little deeper as time
> permits.
> 
> Thank you again for taking the time to help me through this.

The avc message suggests that your processes are not running in the
right domains, which in turn suggests that perhaps your filesystems are
not correctly labeled.  sestatus -v should provide more information.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
