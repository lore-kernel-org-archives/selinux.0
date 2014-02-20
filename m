Date: Thu, 20 Feb 2014 20:26:45 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Eric Paris <eparis@parisplace.org>
Subject: Re: [systemd-devel] [PATCH] selinux: Only attempt to load policy
 exactly once, in the real root
Message-ID: <20140220192644.GA28064@tango.0pointer.de>
References: <20140220154726.19E25680237@frontend2.nyi.mail.srv.osa>
 <5306441F.8050207@tycho.nsa.gov>
 <20140220182215.4613AC00005@frontend1.nyi.mail.srv.osa>
 <20140220183643.GB24876@tango.0pointer.de>
 <CACLa4ps3J9i8sSqxgrn6X=X08__rv4DWUPwYpeTPC-VcYBpjAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACLa4ps3J9i8sSqxgrn6X=X08__rv4DWUPwYpeTPC-VcYBpjAQ@mail.gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 systemd Mailing List <systemd-devel@lists.freedesktop.org>,
 SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 20.02.14 13:50, Eric Paris (eparis@parisplace.org) wrote:

> Not really.  If it doesn't exist on the final root fs and I put
> enforcing=1 on the command line, I expect the box to
> panic/fail/die/whatever....

OK, then maybe check "!in_initrd() || access("/etc/selinux/", F_OK) >= 0"? 

Lennart

-- 
Lennart Poettering, Red Hat
