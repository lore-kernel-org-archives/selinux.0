Message-ID: <3FB51DBB.7070308@ispwest.com>
Date: Fri, 14 Nov 2003 10:23:55 -0800
From: "gndeva@ispwest.com" <gndeva@ispwest.com>
MIME-Version: 1.0
To: "John D. Ramsdell" <ramsdell@mitre.org>
CC: Karl MacMillan <kmacmillan@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: GNU Coding Standards
References: <1067890582.1269.32.camel@colossus.columbia.tresys.com> <ogtn0az2dqq.fsf@divan.mitre.org>
In-Reply-To: <ogtn0az2dqq.fsf@divan.mitre.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Note that GNU automake requires perl, which does
not seem to be in the base selinux tool chest
(at least in the 2.4 flavor).

In making test systems from scratch I've been
finding these chicken-egg problems with the
tool chain. I've been considering using
the busybox package as a bootstrap mechanism.


John D. Ramsdell wrote:
> Karl MacMillan <kmacmillan@tresys.com> writes:
> 
> 
>>We have just released version 1.0.1 of setools.
> 
> 
> ...
> 
> 
>>The next release, sometime in early December, will include improved
>>information flow analysis, the ability to save and load complex
>>queries in apol, the removal of Tcl/TK and X dependencies from the
>>command-line tools, and a log file analysis tool that leverages
>>libapol to help a policy developer or system administrator
>>understand the audit message from SELinux.
> 
> 
> Karl,
> 
> It would also be very helpful if the setools distribution adhered to
> GNU Coding Standards.  The standards have been developed over a long
> period of time, and compliant distributions fit into the Linux
> framework well.  Furthermore, tools are available that automate most
> of the work needed to meet the standards.  The lastest generation of
> autoconf, automake, libtool, and autoheader, make managing releases a
> no-brainer.
> 
> If you're not an Emacs user, you can read about the GNU Coding
> Standards with the command "info standards".
> 
> You can see an example of a distribution that meets the standards in
> the selinux-usr/slat directory of the nsa module in the selinux
> project's CVS repository on SourceForge.  I just finished tuning it.
> 
> John
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
