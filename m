Subject: Re: GNU Coding Standards (was: Setools 1.0.1 released)
From: Karl MacMillan <kmacmillan@tresys.com>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <ogtn0az2dqq.fsf@divan.mitre.org>
References: <1067890582.1269.32.camel@colossus.columbia.tresys.com>
	 <ogtn0az2dqq.fsf@divan.mitre.org>
Content-Type: text/plain
Message-Id: <1068829432.18498.221.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 14 Nov 2003 12:03:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-11-14 at 10:04, John D. Ramsdell wrote:
> 
> It would also be very helpful if the setools distribution adhered to
> GNU Coding Standards.  The standards have been developed over a long
> period of time, and compliant distributions fit into the Linux
> framework well.  Furthermore, tools are available that automate most
> of the work needed to meet the standards.  The lastest generation of
> autoconf, automake, libtool, and autoheader, make managing releases a
> no-brainer.
> 

This was discussed off-list - we will not be moving to the GNU config
tools until there is a compelling reason to do so. As for more general
coding standards, we will continue to follow the linux kernel style
instead of the GNU style.

Karl


> If you're not an Emacs user, you can read about the GNU Coding
> Standards with the command "info standards".
> 
> You can see an example of a distribution that meets the standards in
> the selinux-usr/slat directory of the nsa module in the selinux
> project's CVS repository on SourceForge.  I just finished tuning it.
> 
> John
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
