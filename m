Subject: Re: Multiple small fixes to policycoreutils
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <4559DB81.7060601@redhat.com>
References: <4559DB81.7060601@redhat.com>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 11:13:32 -0500
Message-Id: <1163520813.18181.131.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-14 at 10:06 -0500, Daniel J Walsh wrote:
> Add -fPIE and -pie to build of restorecond.

> -CFLAGS ?= -g -Werror -Wall -W
> -override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
> +LDFLAGS ?= -pie
> +CFLAGS ?= -g -Werror -Wall -W 
> +override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 -fPIE

I would say that this shouldn't be added in general, especially not to
the override.  The default flags should be pretty basic, IMO.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
