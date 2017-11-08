Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vA86xdXr030891
 for <selinux@tycho.nsa.gov>; Wed, 8 Nov 2017 01:59:39 -0500
Received: by mail-pg0-f53.google.com with SMTP id o7so1212185pgc.4
 for <selinux@tycho.nsa.gov>; Tue, 07 Nov 2017 22:59:36 -0800 (PST)
Date: Wed, 8 Nov 2017 14:59:33 +0800
From: Jason Zaman <jason@perfinion.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <20171108065933.GB9205@meriadoc.perfinion.com>
References: <20171103082211.GA8075@pl-rpi.tpb.lab.eng.brq.redhat.com>
 <20171106150040.25300-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171106150040.25300-1-plautrba@redhat.com>
Subject: Re: [PATCH] python/semanage: Do not try to reload policy
 when SELinux is disabled
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Nov 06, 2017 at 04:00:37PM +0100, Petr Lautrbach wrote:
> First two patches do a little cleanup and try to re factorize the code
> used for seobject object initialization.
> 
> The 3rd patch changes the behavior in order to call
> semanage_set_reload() only if -N is used.

all looks good to me,
merged :)
