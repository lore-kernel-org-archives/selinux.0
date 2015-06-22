Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5MCnOI6020465
 for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2015 08:49:24 -0400
Message-ID: <55880431.1030507@tycho.nsa.gov>
Date: Mon, 22 Jun 2015 08:48:49 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: libselinux equivalent of restorecon -F
References: <9833421.4OAA7AQtgN@sifl> <6033.1434651905@warthog.procyon.org.uk>
 <9305.1434966107@warthog.procyon.org.uk>
 <20150622121355.GA10451@localhost.localdomain>
In-Reply-To: <20150622121355.GA10451@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/22/2015 08:13 AM, Dominick Grift wrote:
> Please excuse my ignorance, and please bear with me for a moment:
> 
> I would consider lsetfilecon() functionality roughly the same to that of "restorecon" (in a sense at least).
> 
> Which libselinux interface would be provide roughly the same functionality to that of "restorecon -F" (in a sense at least) ?
> 
> Is that what selinux_lsetfilecon_default() is for?

Yes, that's probably the closest equivalent in upstream libselinux.
However, in Android libselinux [1], we have a
selinux_android_restorecon() function that fully replicates restorecon
functionality.  We should likely take a version of that to upstream
libselinux.  Interface is:
#define SELINUX_ANDROID_RESTORECON_NOCHANGE 1
#define SELINUX_ANDROID_RESTORECON_VERBOSE  2
#define SELINUX_ANDROID_RESTORECON_RECURSE  4
#define SELINUX_ANDROID_RESTORECON_FORCE    8
#define SELINUX_ANDROID_RESTORECON_DATADATA 16
extern int selinux_android_restorecon(const char *file, unsigned int flags);

[1] https://android.googlesource.com/platform/external/libselinux
