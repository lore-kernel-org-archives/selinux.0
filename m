Subject: Re: SElinux from scratch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Goo GGooo <googgooo@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <ef5305790602061729o5b8e0a02p12215cb731e00bd5@mail.gmail.com>
References: <ef5305790602061729o5b8e0a02p12215cb731e00bd5@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 08:37:19 -0500
Message-Id: <1139319439.2872.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-07 at 14:29 +1300, Goo GGooo wrote:
> For now my intent is to harden Apache httpd, prevent it from executing
> all but permitted binaries, restrict access to some filesystem areas,
> etc. I'm running OpenSUSE 10.0 and have found the SElinux-related
> packages (sysvinit, pam, ...) and basically I'm ready to create
> whatever files in /etc, compile them, load in permissive mode, watch
> the syslog, fix the policies, etc. I just don't know where to start...
> 
> Can someone point me to such an introduction?

There are some old HOWTOs and FAQs over at the sourceforge site,
http://sourceforge.net/docman/?group_id=21266

Various information resources are listed at
http://selinux.sourceforge.net/resources.php3

However, as I understand it, OpenSuSE does not have a complete set of
patched userland packages for SELinux, and they are phasing out their
SELinux support altogether.  See 
http://marc.theaimsgroup.com/?l=selinux&m=113628380004182&w=2

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
