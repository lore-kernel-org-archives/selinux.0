Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iACISCIi012292
	for <selinux@tycho.nsa.gov>; Fri, 12 Nov 2004 13:28:12 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iACIQmZY003644
	for <selinux@tycho.nsa.gov>; Fri, 12 Nov 2004 18:26:48 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <4182959B.4080503@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
Content-Type: text/plain
Message-Id: <1100283858.4306.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 12 Nov 2004 13:24:18 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-29 at 15:10, Darrel Goeddel wrote:
> 	We would like to propose adding support for a trusted process to
> alter its security context dynamically in order to support privilege
> bracketing within an application.  We are aware that this idea has been
> discussed in the past on the list and entirely understand the concerns
> about non-tranquility, but we feel that this feature, and its
> implementation, have considerable merit and can be provided with
> appropriate controls to mitigate the risks.
<snip>
+       fd = open("/proc/self/attr/current", O_RDWR);
<snip>

Hi,

Karl MacMillan raised the question of the impact of this change on
per-thread security attributes.  SELinux already stores the security
attributes on a per kernel thread basis (in the task struct) even though
the current process context can only change via exec presently.  If you
want dynamic context transitions to be useable by child threads in a
multi-threaded application, then you likely want to use
/proc/self/task/<gettid()> rather than /proc/self, as the latter always
refers to the thread group leader (since 2.6.0-test6, see
http://marc.theaimsgroup.com/?l=linux-kernel&m=106499883901011&w=2) and
attempting to set /proc/self/attr/current will always fail for child
threads (as they are different tasks in the kernel).  This also raises
the question again of whether we should do likewise for the other
libselinux functions that act on /proc/self/attr, e.g. to support
per-thread fscreate context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
