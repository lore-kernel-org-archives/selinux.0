Subject: Re: patch makefiles
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carsten Grohmann <carstengrohmann@gmx.de>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200303231800.39827.carstengrohmann@gmx.de>
References: <200303231800.39827.carstengrohmann@gmx.de>
Content-Type: text/plain
Message-Id: <1051018679.14761.25.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Apr 2003 09:38:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-03-23 at 12:00, Carsten Grohmann wrote:
> last days I create new rpm files for SuSE 8.1 with the selinux version 
> published in January. (This time I don't publish the new rpm's on my page. 
> I hope I can publish the packages in the first week of April.)
> Thereby I add in a lot of makefile $(PREFIX), $(INCDIR) and so on. With this 
> changes it is simple to create packages from the source.
> The attached patch (against the current cvs) contains this changes.

Thanks, I've merged this patch into the sourceforge CVS tree, with one
correction:  the PREFIX in policy/Makefile had a typo (seinux instead of
selinux).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
